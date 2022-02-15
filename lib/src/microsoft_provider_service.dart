import 'package:flutter/cupertino.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:httpp/httpp.dart';
import 'package:logging/logging.dart';
import 'package:microsoft_provider/src/microsoft_provider_service_email.dart';
import 'package:microsoft_provider/src/model/info/microsoft_provider_info_model.dart';

import 'config/microsoft_provider_config.dart';
import 'microsoft_provider_controller.dart';
import 'microsoft_provider_presenter.dart';
import 'microsoft_provider_style.dart';
import 'model/email/microsoft_provider_model_email.dart';
import 'model/microsoft_provider_model.dart';
import 'repository/microsoft_provider_repository.dart';

class MicrosoftProviderService extends ChangeNotifier {
  final Logger _log = Logger('MicrosoftProviderService');

  MicrosoftProviderModel model;
  late final MicrosoftProviderPresenter presenter;
  late final MicrosoftProviderController controller;
  late final MicrosoftProviderRepository _repository;
  late final MicrosoftProviderStyle style;
  late final MicrosoftProviderServiceEmail _serviceEmail;
  final Function(MicrosoftProviderModel)? onLink;
  final Function(String?)? onUnlink;
  final Function(List<MicrosoftProviderInfoModel>)? onSee;
  final FlutterAppAuth _appAuth;
  final HttppClient client;

  MicrosoftProviderService(
      {required this.style,
      Httpp? httpp,
      model,
      this.onLink,
      this.onUnlink,
      this.onSee})
      : model = model ?? MicrosoftProviderModel(),
        _appAuth = FlutterAppAuth(),
        client = httpp == null ? Httpp().client() : httpp.client() {
    presenter = MicrosoftProviderPresenter(this);
    controller = MicrosoftProviderController(this);
    _repository = MicrosoftProviderRepository();
    _serviceEmail = MicrosoftProviderServiceEmail(this);
  }

  Future<void> signIn() async {
    AuthorizationTokenResponse? tokenResponse =
        await _authorizeAndExchangeCode();
    if (tokenResponse != null) {
      _log.finest(
          "authorizeAndExchangeCode success - ${tokenResponse.tokenType}");
      model.token = tokenResponse.accessToken;
      model.accessTokenExp = tokenResponse.accessTokenExpirationDateTime;
      model.refreshToken = tokenResponse.refreshToken;
      await _repository.userInfo(
        accessToken: model.token!,
        client: client,
        onSuccess: saveUserInfo,
        onError: (e) => print,
      );
      if (onLink != null) {
        onLink!(model);
      }
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    if (onUnlink != null) {
      onUnlink!(model.email);
    }
    model = MicrosoftProviderModel();
    notifyListeners();
  }

  void saveUserInfo(response) {
    model.displayName = response?.body?.jsonBody['name'];
    model.email = response?.body?.jsonBody['email'];
    model.isLinked = true;
  }

  void seeInfo() {
    List<MicrosoftProviderInfoModel> data = _repository.getTheyKnowInfo();
    if (onSee != null) {
      onSee!(data);
    }
  }

  void sendEmail(
      {String? body,
      required String to,
      String? subject,
      Function(bool)? onResult}) {
    _serviceEmail.sendEmail(
      body: body,
      to: to,
      subject: subject,
      onResult: onResult,
    );
  }

  void fetchInbox(
      {DateTime? since,
      required Function(List<String> messagesIds) onResult,
      required Function() onFinish}) {
    _serviceEmail.fetchInbox(
        since: since, onResult: onResult, onFinish: onFinish);
  }

  void fetchMessages(
      {required List<String> messageIds,
      required Function(MicrosoftProviderModelEmail message) onResult,
      required Function() onFinish}) {
    _serviceEmail.fetchMessages(
        messageIds: messageIds, onResult: onResult, onFinish: onFinish);
  }

  // TODO handle if token cannot be refreshed
  Future<void> refreshToken() async {
    try {
      TokenResponse tokenResponse = (await _appAuth.token(TokenRequest(
          MicrosoftProviderConfig.clientId, MicrosoftProviderConfig.redirectUri,
          serviceConfiguration: const AuthorizationServiceConfiguration(
              authorizationEndpoint: MicrosoftProviderConfig.authorizationEndpoint,
              tokenEndpoint: MicrosoftProviderConfig.tokenEndpoint),
          refreshToken: model.refreshToken,
          scopes: MicrosoftProviderConfig.scopes)))!;
      model.token = tokenResponse.accessToken;
      model.refreshToken = tokenResponse.refreshToken;
    } catch (e) {
      _log.severe(e.toString());
    }
  }

  Future<AuthorizationTokenResponse?> _authorizeAndExchangeCode() async {
    AuthorizationServiceConfiguration authConfig =
        const AuthorizationServiceConfiguration(
            authorizationEndpoint: MicrosoftProviderConfig.authorizationEndpoint,
            tokenEndpoint: MicrosoftProviderConfig.tokenEndpoint);
    List<String> providerScopes = MicrosoftProviderConfig.scopes;
    return await _appAuth.authorizeAndExchangeCode(
      AuthorizationTokenRequest(
          MicrosoftProviderConfig.clientId, MicrosoftProviderConfig.redirectUri,
          promptValues: null,
          serviceConfiguration: authConfig,
          scopes: providerScopes),
    );
  }
}
