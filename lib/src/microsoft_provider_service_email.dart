import 'package:httpp/httpp.dart';
import 'package:logging/logging.dart';
import 'microsoft_provider_service.dart';
import 'model/email/microsoft_provider_model_company.dart';
import 'model/email/microsoft_provider_model_sender.dart';
import 'repository/microsoft_provider_repository_email.dart';

import 'microsoft_provider_service_email_paginator.dart';
import 'model/email/microsoft_provider_model_email.dart';
import 'model/email/microsoft_provider_model_header.dart';
import 'model/email/microsoft_provider_model_message.dart';
import 'model/email/microsoft_provider_model_recipient.dart';

class MicrosoftProviderServiceEmail {
  final Logger _log = Logger('MicrosoftProviderServiceEmail');
  final MicrosoftProviderRepositoryEmail repository;
  final MicrosoftProviderService _service;
  MicrosoftProviderServiceEmail(this._service)
      : repository = MicrosoftProviderRepositoryEmail();

  Future<void> send(
      {String? body,
      required String to,
      String? subject,
      Function(bool success)? onResult}) async {
    String message = '''
<!DOCTYPE html PUBLIC “-//W3C//DTD XHTML 1.0 Transitional//EN” “https://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd”>
<html xmlns=“https://www.w3.org/1999/xhtml”>
<head>
<title>$subject</title>
<meta http–equiv=“Content-Type” content=“text/html; charset=UTF-8” />
<meta http–equiv=“X-UA-Compatible” content=“IE=edge” />
<meta name=“viewport” content=“width=device-width, initial-scale=1.0 “ />
</head>
<body class=“em_body” style=“margin:0px; padding:0px;”> 
$body
<br />
*Sent via http://www.mytiki.com. Join the data ownership<br />
revolution today.<br />
</body>
</html>
''';
    return repository.send(
        client: _service.client,
        accessToken: _service.model.token,
        message: HttppBody.fromJson({
          'message': {
            'subject': subject,
            'body': {'contentType': 'HTML', 'content': message},
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
          _log.warning('unsubscribe for $to failed.');
          _handleUnauthorized(response);
          _handleTooManyRequests(response);
          if (onResult != null) onResult(false);
        },
        onError: (error) {
          _log.warning('unsubscribe for $to failed.');
          if (onResult != null) onResult(false);
        });
  }

  Future<void> fetchInbox(
      {DateTime? since,
      required Function(List<String> messages) onResult,
      required Function() onFinish}) async {
    return MicrosoftProviderServiceEmailPaginator(
            onResult: (response) {
              _handleUnauthorized(response);
              _handleTooManyRequests(response);
            },
            onSuccess: onResult,
            since: since,
            onFinish: onFinish,
            service: _service)
        .fetchInbox();
  }

  void _handleUnauthorized(HttppResponse response) {
    if (HttppUtils.isUnauthorized(response.statusCode)) {
      _log.warning('Unauthorized. Trying refresh');
      _service.client.denyUntil(response.request!, () async {
        await _service.refreshToken();
        response.request?.headers?.auth(_service.model.token);
      });
    }
  }

  void _handleTooManyRequests(HttppResponse response) {
    if (HttppUtils.isTooManyRequests(response.statusCode)) {
      Duration retry = const Duration(seconds: 1);
      if (response.headers != null) {
        double milli = int.parse(response.headers!.map.entries
                .singleWhere((element) => element.key == 'retry-after')
                .value) *
            1100;
        retry = Duration(milliseconds: milli.round());
      }
      _log.warning('Too many requests. Retry after $retry');
      _service.client.denyFor(response.request!, retry);
    }
  }

  Future<void> fetchMessages(
      {required List<String> messageIds,
      required Function(MicrosoftProviderModelEmail message) onResult,
      required Function() onFinish}) async {
    List<Future> futures = [];
    for (var messageId in messageIds) {
      futures.add(_service.email.repository.message(
          client: _service.client,
          accessToken: _service.model.token,
          messageId: messageId,
          onSuccess: (response) {
            MicrosoftProviderModelMessage message =
                MicrosoftProviderModelMessage.fromJson(response.body?.jsonBody);
            onResult(MicrosoftProviderModelEmail(
                extMessageId: message.id,
                receivedDate: message.receivedDateTime,
                openedDate: null, //TODO implement open date detection
                toEmail: _toEmailFromRecipients(
                    message.toRecipients, _service.model.email!),
                sender: MicrosoftProviderModelSender(
                    email: message.from?.emailAddress?.address,
                    name: message.from?.emailAddress?.name,
                    category: 'inbox',
                    unsubscribeMailTo:
                        _unsubscribeMailTo(message.internetMessageHeaders),
                    unsubscribed: false,
                    company: MicrosoftProviderModelCompany(
                        domain: MicrosoftProviderModelCompany.domainFromEmail(
                            message.from?.emailAddress?.address)))));
          },
          onResult: (response) {
            _log.warning(
                'Fetch message $messageId failed with statusCode ${response.statusCode}');
            _handleUnauthorized(response);
            _handleTooManyRequests(response);
          },
          onError: (error) {
            _log.warning('Fetch message $messageId failed with error $error');
          }));
    }
    await Future.wait(futures);
  }

  String? _unsubscribeMailTo(List<MicrosoftProviderModelHeader>? headers) {
    if (headers != null) {
      for (MicrosoftProviderModelHeader header in headers) {
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
    return null;
  }

  String? _toEmailFromRecipients(
      List<MicrosoftProviderModelRecipient>? recipients, String expected) {
    if (recipients == null || recipients.isEmpty) return expected;
    for (MicrosoftProviderModelRecipient recipient in recipients) {
      if (recipient.emailAddress?.address == expected) return expected;
    }
    return recipients[0].emailAddress?.address;
  }
}
