/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:httpp/httpp.dart';
import 'package:logging/logging.dart';

import '../../tiki_strategy_microsoft_model_company.dart';
import '../../tiki_strategy_microsoft_model_email.dart';
import '../../tiki_strategy_microsoft_model_sender.dart';
import '../auth/auth_service.dart';
import 'email_model_header.dart';
import 'email_model_message.dart';
import 'email_model_recipient.dart';
import 'email_paginator_inbox.dart';
import 'email_repository.dart';

class EmailService {
  final Logger _log = Logger('EmailService');
  final EmailRepository _repository;
  final AuthService _authService;

  EmailService(this._authService) : _repository = EmailRepository();

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
    return _repository.send(
        client: _authService.client,
        accessToken: _authService.model.token,
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
        onResult: (response) async {
          _log.warning('send email failed with code ${response.statusCode}');
          _handleUnauthorized(response);
          _handleTooManyRequests(response);
          if (onResult != null) onResult(false);
        },
        onError: (error) {
          _log.severe('send email failed with error ${error.runtimeType}', error);
          if (onResult != null) onResult(false);
        });
  }

  Future<void> fetchInbox(
      {DateTime? since,
      required Function(List<String> messages, {String? page}) onResult,
      required Function() onFinish}) async {
    return EmailPaginatorInbox(
        onResult: (response) {
          _log.warning(
              'Fetch inbox failed with statusCode ${response.statusCode}');
          _handleUnauthorized(response);
          _handleTooManyRequests(response);
        },
        onSuccess: onResult,
        since: since,
        onFinish: onFinish,
        authService: _authService,
        repository: _repository,
        onError: (error) {
          _log.warning('Fetch inbox failed with error $error');
        }).fetchInbox();
  }

  Future<void> countInbox(
      {DateTime? since,
        required Function(int messages) onResult,
        required Function() onFinish}) async {

    return _repository.pathProfile(
      client: _authService.client,
      accessToken: _authService.model.token,
      filter: "", // _buildFilter(after: since)
      onSuccess: (response) {

        Map<String, dynamic>? json = response.body?.jsonBody;
        int totalMessageCount = json!["@odata.count"];

        onResult(totalMessageCount);
        onFinish();
      },
      onResult: (response) {
        _log.warning('Count inbox ${_authService.model.email} failed with statusCode ${response.statusCode}: ${response.body?.body}');
        _handleUnauthorized(response);
        _handleTooManyRequests(response);
      },
      onError: (error) => _log.warning('Count inbox ${_authService.model.email} failed with error $error'),
    );
  }

  Future<void> fetchMessages(
      {required List<String> messageIds,
      required Function(TikiStrategyMicrosoftModelEmail message) onResult,
      required Function() onFinish}) async {
    List<Future> futures = [];
    for (String messageId in messageIds) {
      futures.add(_repository.message(
          client: _authService.client,
          accessToken: _authService.model.token,
          messageId: messageId,
          onSuccess: (response) {
            EmailModelMessage message =
                EmailModelMessage.fromJson(response.body?.jsonBody);
            onResult(TikiStrategyMicrosoftModelEmail(
                extMessageId: message.id,
                receivedDate: message.receivedDateTime,
                openedDate: null, //TODO implement open date detection
                toEmail: _toEmailFromRecipients(
                    message.toRecipients, _authService.model.email!),
                subject: _subject(message.internetMessageHeaders),
                sender: TikiStrategyMicrosoftModelSender(
                    email: message.from?.emailAddress?.address,
                    name: message.from?.emailAddress?.name,
                    category: 'inbox',
                    unsubscribeMailTo:
                        _unsubscribeMailTo(message.internetMessageHeaders),
                    company: TikiStrategyMicrosoftModelCompany(
                        domain: _domainFromEmail(
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
    onFinish();
  }

  void _handleUnauthorized(HttppResponse response) {
    if (HttppUtils.isUnauthorized(response.statusCode)) {
      _log.warning('Unauthorized. Trying refresh');
      _authService.client.denyUntil(response.request!, () async {
        try {
          await _authService.refreshToken();
          response.request?.headers?.auth(_authService.model.token);
        } catch (err) {
          _log.severe('Failed refresh. Cancelling', err);
          response.request?.cancel();
        }
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
      _authService.client.denyFor(response.request!, retry);
    }
  }

  String? _unsubscribeMailTo(List<EmailModelHeader>? headers) {
    if (headers != null) {
      for (EmailModelHeader header in headers) {
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
      List<EmailModelRecipient>? recipients, String expected) {
    if (recipients == null || recipients.isEmpty) return expected;
    for (EmailModelRecipient recipient in recipients) {
      if (recipient.emailAddress?.address == expected) return expected;
    }
    return recipients[0].emailAddress?.address;
  }

  String? _domainFromEmail(String? email) {
    if (email != null) {
      List<String> atSplit = email.split('@');

      // todo: repeated code w/ google strat
      return atSplit[atSplit.length - 1];
    }
    return null;
  }

  String? _subject(List<EmailModelHeader>? headers) {
    if (headers != null) {
      for (EmailModelHeader header in headers) {
        if (header.name?.trim().toLowerCase() == 'subject') {
          return header.value;
        }
      }
    }
    return null;
  }
}
