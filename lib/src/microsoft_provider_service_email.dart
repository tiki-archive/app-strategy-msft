import 'dart:convert';

import 'package:microsoft_provider/src/microsoft_provider_service.dart';
import 'package:microsoft_provider/src/model/email/microsoft_provider_model_email_msg_header.dart';
import 'package:microsoft_provider/src/model/email/microsoft_provider_model_email_msgs.dart';
import 'package:microsoft_provider/src/model/microsoft_provider_model_message.dart';
import 'package:microsoft_provider/src/repository/microsoft_provider_repository_email.dart';
import 'package:httpp/httpp.dart';
import 'package:logging/logging.dart';

import 'model/email/microsoft_provider_model_company.dart';
import 'model/email/microsoft_provider_model_email.dart';
import 'model/email/microsoft_provider_model_email_msg.dart';
import 'model/email/microsoft_provider_model_sender.dart';
import 'model/microsoft_provider_model_error.dart';
import 'package:collection/collection.dart';

class MicrosoftProviderServiceEmail {
  final Logger _log = Logger('MicrosoftProviderServiceEmail');
  final MicrosoftProviderRepositoryEmail _repositoryEmail;
  final MicrosoftProviderService _service;

  MicrosoftProviderServiceEmail(this._service)
      : _repositoryEmail = MicrosoftProviderRepositoryEmail();

  @override
  Future<void> fetchInbox(
      {
        DateTime? since,
        required Function(List<MicrosoftProviderModelEmail> messages) onResult,
        required Function() onFinish}) async {
    HttppClient client = _service.client;
    return MicrosoftProviderServiceEmailPaginator(
        httppClient: client,
        repositoryEmail: _repositoryEmail,
        onSuccess: onResult,
        onResult: (response) {
          _handleUnauthorized(response);
          _handleTooManyRequests(response);
        },
        since: since,
        onFinish: onFinish)
        .fetchInbox();
  }

  @override
  Future<void> fetchMessages(
      {
        required List<String> messageIds,
        required Function(MicrosoftProviderModelEmail message) onResult,
        required Function() onFinish}) async {
    HttppClient client = _service.client;
    List<Future> futures = [];
    messageIds.forEach((messageId) => futures.add(_repositoryEmail.message(
        client: client,
        accessToken: _service.model.token,
        messageId: messageId,
        onSuccess: (response) {
          MicrosoftProviderModelEmail message =
            MicrosoftProviderModelEmail.fromJson(response.body?.jsonBody);
          onResult(MicrosoftProviderModelEmail(
              extMessageId: message.id,
              receivedDate: message.receivedDateTime,
              openedDate: null, //TODO implement open date detection
              toEmail:
              _toEmailFromRecipients(message.toRecipients, account.email!),
              sender: ApiEmailSenderModel(
                  email: message.from?.emailAddress?.address,
                  name: message.from?.emailAddress?.name,
                  category: 'inbox',
                  unsubscribeMailTo:
                  _unsubscribeMailTo(message.internetMessageHeaders),
                  unsubscribed: false,
                  company: ApiCompanyModel(
                      domain: ApiCompanyService.domainFromEmail(
                          message.from?.emailAddress?.address)))));
        },
        onResult: (response) {
          _log.warning(
              'Fetch message ${messageId} failed with statusCode ${response.statusCode}');
          _handleUnauthorized(client, response, account);
          _handleTooManyRequests(client, response);
        },
        onError: (error) {
          _log.warning('Fetch message ${messageId} failed with error ${error}');
        })));
    await Future.wait(futures);
  }

  @override
  Future<void> send(
      {required ApiOAuthModelAccount account,
        String? body,
        required String to,
        String? subject,
        Function(bool success)? onResult}) async {
    HttppClient client = _httpp.client();
    return _repositoryEmail.send(
        client: client,
        accessToken: account.accessToken,
        message: HttppBody.fromJson({
          'message': {
            'subject': subject,
            'body': {'contentType': 'HTML', 'content': body},
            'toRecipients': [
              {
                'emailAddress': {'address': to}
              }
            ]
          }
        }),
        onSuccess: (response) {
          _log.finest('unsubscribe mail sent to ' + to);
          if (onResult != null) onResult(true);
        },
        onResult: (response) {
          _log.warning('unsubscribe for ${to} failed.');
          _handleUnauthorized(client, response, account);
          _handleTooManyRequests(client, response);
          if (onResult != null) onResult(false);
        },
        onError: (error) {
          _log.warning('unsubscribe for ${to} failed.');
          if (onResult != null) onResult(false);
        });
  }

  String? _unsubscribeMailTo(List<ApiMicrosoftModelHeader>? headers) {
    if (headers != null) {
      for (ApiMicrosoftModelHeader header in headers) {
        if (header.name?.trim() == 'List-Unsubscribe') {
          if (header.value != null) {
            String removeCaret =
            header.value!.replaceAll('<', '').replaceAll('>', '');
            List<String> splitMailTo = removeCaret.split('mailto:');
            if (splitMailTo.length > 1) return splitMailTo[1].split(',')[0];
          }
        }
      }
    }
  }

  String? _toEmailFromRecipients(
      List<ApiMicrosoftModelRecipient>? recipients, String expected) {
    if (recipients == null || recipients.length == 0) return expected;
    for (ApiMicrosoftModelRecipient recipient in recipients) {
      if (recipient.emailAddress?.address == expected) return expected;
    }
    return recipients[0].emailAddress?.address;
  }

  void _handleUnauthorized(HttppClient client, HttppResponse response,
      ApiOAuthModelAccount account) {
    if (HttppUtils.isUnauthorized(response.statusCode)) {
      _log.warning('Unauthorized. Trying refresh');
      client.denyUntil(response.request!, () async {
        ApiOAuthModelAccount? refreshed =
        await apiOAuthService.refreshToken(account);
        response.request?.headers?.auth(refreshed?.accessToken);
      });
    }
  }

  void _handleTooManyRequests(HttppClient client, HttppResponse response) {
    if (HttppUtils.isTooManyRequests(response.statusCode)) {
      Duration retry = Duration(seconds: 1);
      if (response.headers != null) {
        double milli = int.parse(response.headers!.map.entries
            .singleWhere((element) => element.key == 'retry-after')
            .value) *
            1100;
        retry = Duration(milliseconds: milli.round());
      }
      _log.warning('Too many requests. Retry after $retry');
      client.denyFor(response.request!, retry);
    }
  }

}
