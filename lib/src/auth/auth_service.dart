/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/widgets.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:httpp/httpp.dart';
import 'package:logging/logging.dart';

import '../error/error_http.dart';
import '../error/error_model.dart';
import 'auth_controller.dart';
import 'auth_model.dart';
import 'auth_presenter.dart';
import 'auth_repository.dart';

class AuthService extends ChangeNotifier {
  final Logger _log = Logger('AuthService');

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

  AuthModel model;
  late final AuthPresenter presenter;
  late final AuthController controller;

  final Function(AuthModel)? onLink;
  final Function(String?)? onUnlink;
  final Function(
      {String? accessToken,
      DateTime? accessExp,
      String? refreshToken,
      DateTime? refreshExp})? onRefresh;
  final HttppClient client;

  final String _redirectUri;
  final String _clientId;

  final FlutterAppAuth _appAuth;
  final AuthRepository _repository;

  AuthService(
      {Httpp? httpp,
      model,
      this.onLink,
      this.onUnlink,
      this.onRefresh,
      required String redirectUri,
      required String clientId})
      : model = model ?? AuthModel(),
        _appAuth = const FlutterAppAuth(),
        _repository = AuthRepository(),
        _clientId = clientId,
        _redirectUri = redirectUri,
        client = httpp == null ? Httpp().client() : httpp.client() {
    presenter = AuthPresenter(this);
    controller = AuthController(this);
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
      updateUserInfo(onSuccess: onLink);
      notifyListeners();
    }
  }

  Future<void> updateUserInfo({Function(AuthModel)? onSuccess}) async {
    await _repository.userInfo(
      accessToken: model.token!,
      client: client,
      onSuccess: (response) {
        model.displayName = response?.body?.jsonBody['name'];
        model.email = response?.body?.jsonBody['email'];
        model.isLinked = true;
        if (onSuccess != null) {
          onSuccess(model);
        }
        notifyListeners();
      },
      onError: (err) {
        if (err is HttppResponse) {
          if (HttppUtils.isUnauthorized(err.statusCode)) {
            _log.warning('Unauthorized. Trying refresh');
            client.denyUntil(err.request!, () async {
              await refreshToken();
              err.request?.headers?.auth(model.token);
            });
          } else {
            ErrorModel body = ErrorModel.fromJson(err.body?.jsonBody);
            throw ErrorHttp(body);
          }
        } else {
          _log.severe(err);
          throw err;
        }
      },
    );
  }

  Future<void> signOut() async {
    if (onUnlink != null) {
      onUnlink!(model.email);
    }
    model = AuthModel();
    notifyListeners();
  }

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
    } catch (err) {
      _log.severe(err.toString());
      rethrow;
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
