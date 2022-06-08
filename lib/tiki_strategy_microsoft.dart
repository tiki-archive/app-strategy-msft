/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/widgets.dart';
import 'package:httpp/httpp.dart';

import 'src/auth/auth_model.dart';
import 'src/auth/auth_service.dart';
import 'src/email/email_service.dart';
import 'tiki_strategy_microsoft_model_email.dart';

export 'src/auth/auth_model.dart';

class TikiStrategyMicrosoft {
  final AuthService _authService;
  late final EmailService _emailService;

  TikiStrategyMicrosoft(
      {required String redirectUri,
      required String clientId,
      Function(AuthModel)? onLink,
      Function(String?)? onUnlink,
      Function(
              {String? accessToken,
              DateTime? accessExp,
              String? refreshToken,
              DateTime? refreshExp})?
          onRefresh,
      Httpp? httpp})
      : _authService = AuthService(
            redirectUri: redirectUri,
            clientId: clientId,
            httpp: httpp,
            onLink: onLink,
            onUnlink: onUnlink,
            onRefresh: onRefresh) {
    _emailService = EmailService(_authService);
  }

  TikiStrategyMicrosoft.loggedIn(
      {required String redirectUri,
      required String clientId,
      required String? token,
      String? email,
      String? displayName,
      String? refreshToken,
      Function(AuthModel)? onLink,
      Function(String?)? onUnlink,
      Function(
              {String? accessToken,
              DateTime? accessExp,
              String? refreshToken,
              DateTime? refreshExp})?
          onRefresh,
      Httpp? httpp})
      : _authService = AuthService(
            model: AuthModel(
              isLinked: true,
              email: email,
              token: token,
              displayName: displayName,
              refreshToken: refreshToken,
            ),
            redirectUri: redirectUri,
            clientId: clientId,
            httpp: httpp,
            onLink: onLink,
            onUnlink: onUnlink,
            onRefresh: onRefresh) {
    _emailService = EmailService(_authService);
  }

  Widget get authButton => _authService.presenter.authButton();

  String? get displayName => _authService.model.displayName;

  Future<void> update({Function(AuthModel)? onUpdate}) async =>
      await _authService.updateUserInfo(onSuccess: onUpdate);

  Future<void> fetchInbox(
          {DateTime? since,
          required Function(List<String> messagesIds, {String? page}) onResult,
          required Function() onFinish}) =>
      _emailService.fetchInbox(
          since: since, onResult: onResult, onFinish: onFinish);

  Future<void> fetchMessages(
          {required List<String> messageIds,
          required Function(TikiStrategyMicrosoftModelEmail message) onResult,
          required Function() onFinish}) =>
      _emailService.fetchMessages(
          messageIds: messageIds, onResult: onResult, onFinish: onFinish);

  Future<void> sendEmail(
          {String? body,
          required String to,
          String? subject,
          Function(bool)? onResult}) =>
      _emailService.send(
          body: body, to: to, subject: subject, onResult: onResult);
}
