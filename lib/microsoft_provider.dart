import 'package:flutter/material.dart';
import 'package:httpp/httpp.dart';
import 'package:microsoft_provider/src/microsoft_provider_service.dart';
import 'package:microsoft_provider/src/microsoft_provider_style.dart';

import 'src/model/email/microsoft_provider_model_email.dart';
import 'src/model/info/microsoft_provider_info_model.dart';
import 'src/model/microsoft_provider_model.dart';

class MicrosoftProvider {
  late final MicrosoftProviderService _service;

  MicrosoftProvider(
      {MicrosoftProviderStyle? style,
      Function(MicrosoftProviderModel)? onLink,
      Function(String?)? onUnlink,
      Function(List<MicrosoftProviderInfoModel>)? onSee,
      Httpp? httpp})
      : _service = MicrosoftProviderService(
            httpp: httpp,
            onLink: onLink,
            onUnlink: onUnlink,
            onSee: onSee,
            style: style ?? MicrosoftProviderStyle());

  MicrosoftProvider.loggedIn({
        required email,
        required token,
        String? displayName,
        String? refreshToken,
        MicrosoftProviderStyle? style,
        Function(MicrosoftProviderModel)? onLink,
        Function(String?)? onUnlink,
        Function(List<MicrosoftProviderInfoModel>)? onSee,
        Httpp? httpp}){
    _service = MicrosoftProviderService(
        model: MicrosoftProviderModel(
          isLinked: true,
          email : email,
          token : token,
          displayName : displayName,
          refreshToken : refreshToken,
        ),
        httpp: httpp,
        onLink: onLink,
        onUnlink: onUnlink,
        onSee: onSee,
        style: style ?? MicrosoftProviderStyle());
  }

  Widget accountWidget() => _service.presenter.accountButton();

  Future<void> sendEmail(
      {String? body,
      required String to,
      String? subject,
      Function(bool)? onResult}) =>
    _service.email.send(
        body: body, to: to, subject: subject, onResult: onResult);

  Future<void> fetchInbox(
      {DateTime? since,
      required Function(List<String> messagesIds) onResult,
      required Function() onFinish}) =>
    _service.email.fetchInbox(since: since, onResult: onResult, onFinish: onFinish);


  Future<void> fetchMessages(
      {required List<String> messageIds,
      required Function(MicrosoftProviderModelEmail message) onResult,
      required Function() onFinish}) =>
    _service.email.fetchMessages(
        messageIds: messageIds, onResult: onResult, onFinish: onFinish);

}
