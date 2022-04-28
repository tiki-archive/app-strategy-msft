import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:httpp/httpp.dart';
import 'package:info_carousel/info_carousel.dart';
import 'package:logging/logging.dart';

import 'microsoft_provider_controller.dart';
import 'microsoft_provider_presenter.dart';
import 'microsoft_provider_service_email.dart';
import 'model/microsoft_provider_model.dart';
import 'repository/microsoft_provider_repository_info.dart';
import 'repository/microsoft_provider_repository_oauth.dart';

class MicrosoftProviderService extends ChangeNotifier {
  final Logger _log = Logger('MicrosoftProviderService');

  static const String _redirectUri = "com.mytiki.app://oauth/";
  static const String _clientId = "6e52a878-7251-4669-8e42-70655255a263";
  static const String _authorizationEndpoint =
      "https://login.microsoftonline.com/common/oauth2/v2.0/authorize";
  static const String _tokenEndpoint =
      "https://login.microsoftonline.com/common/oauth2/v2.0/token";
  static const List<String> _promptValues = ["select_account"];
  static const List<String> _scopes = [
    "openid",
    "email",
    "profile",
    "mail.read",
    "mail.send",
    "offline_access"
  ];

  MicrosoftProviderModel model;
  late final MicrosoftProviderPresenter presenter;
  late final MicrosoftProviderController controller;
  late final MicrosoftProviderRepositoryOauth _oauth;
  late final MicrosoftProviderServiceEmail email;
  final Function(MicrosoftProviderModel)? onLink;
  final Function(String?)? onUnlink;
  final FlutterAppAuth _appAuth;
  final HttppClient client;
  final Function(
      {String? accessToken,
      DateTime? accessExp,
      String? refreshToken,
      DateTime? refreshExp})? onRefresh;

  MicrosoftProviderService(
      {Httpp? httpp, model, this.onLink, this.onUnlink, this.onRefresh})
      : model = model ?? MicrosoftProviderModel(),
        _appAuth = FlutterAppAuth(),
        client = httpp == null ? Httpp().client() : httpp.client() {
    presenter = MicrosoftProviderPresenter(this);
    controller = MicrosoftProviderController(this);
    _oauth = MicrosoftProviderRepositoryOauth();
    email = MicrosoftProviderServiceEmail(this);
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
      await updateUserInfo(onSuccess: onLink);
      notifyListeners();
    }
  }

  Future<void> updateUserInfo(
      {Function(MicrosoftProviderModel)? onSuccess}) async {
    await _oauth.userInfo(
      accessToken: model.token!,
      client: client,
      onSuccess: (response) {
        model.displayName = response?.body?.jsonBody['name'];
        model.email = response?.body?.jsonBody['email'];
        model.isLinked = true;
        if (onSuccess != null) {
          onSuccess(model);
        }
      },
      onError: (e) => _log.severe(e),
    );
  }

  Future<void> signOut() async {
    if (onUnlink != null) {
      onUnlink!(model.email);
    }
    model = MicrosoftProviderModel();
    notifyListeners();
  }

  Widget seeInfo() {
    List<InfoCarouselCardModel> data =
        MicrosoftProviderRepositoryInfo.theyKnowInfo;
    return InfoCarousel(cards: data).carouselWidget();
  }

  // TODO handle if token cannot be refreshed
  Future<void> refreshToken() async {
    try {
      TokenResponse tokenResponse = (await _appAuth.token(TokenRequest(
          _clientId, _redirectUri,
          serviceConfiguration: const AuthorizationServiceConfiguration(
              authorizationEndpoint: _authorizationEndpoint,
              tokenEndpoint: _tokenEndpoint),
          refreshToken: model.refreshToken,
          scopes: _scopes,
          grantType: "refresh_token")))!;
      model.token = tokenResponse.accessToken;
      model.refreshToken = tokenResponse.refreshToken;
      if (onRefresh != null) {
        onRefresh!(
            accessToken: tokenResponse.accessToken,
            accessExp: tokenResponse.accessTokenExpirationDateTime,
            refreshToken: tokenResponse.refreshToken);
      }
    } catch (e) {
      _log.severe(e.toString());
    }
  }

  Future<AuthorizationTokenResponse?> _authorizeAndExchangeCode() async {
    AuthorizationServiceConfiguration authConfig =
        const AuthorizationServiceConfiguration(
      authorizationEndpoint: _authorizationEndpoint,
      tokenEndpoint: _tokenEndpoint,
    );
    List<String> providerScopes = _scopes;
    return await _appAuth.authorizeAndExchangeCode(
      AuthorizationTokenRequest(_clientId, _redirectUri,
          promptValues: _promptValues,
          serviceConfiguration: authConfig,
          scopes: providerScopes),
    );
  }
}
