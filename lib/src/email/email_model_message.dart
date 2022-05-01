/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'email_model_header.dart';
import 'email_model_recipient.dart';

class EmailModelMessage {
  String? etag;
  String? id;
  String? context;
  DateTime? receivedDateTime;
  List<EmailModelHeader>? internetMessageHeaders;
  EmailModelRecipient? from;
  List<EmailModelRecipient>? toRecipients;

  EmailModelMessage(
      {this.etag,
      this.id,
      this.context,
      this.receivedDateTime,
      this.internetMessageHeaders,
      this.from,
      this.toRecipients});

  EmailModelMessage.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      etag = json['@odata.etag'];
      id = json['id'];
      context = json['@odata.context'];
      receivedDateTime = DateTime.tryParse(json['receivedDateTime']);
      from = EmailModelRecipient.fromJson(json['from']);
      if (json['internetMessageHeaders'] != null) {
        internetMessageHeaders = (json['internetMessageHeaders'] as List)
            .map((e) => EmailModelHeader.fromJson(e))
            .toList();
      }
      if (json['toRecipients'] != null) {
        toRecipients = (json['toRecipients'] as List)
            .map((e) => EmailModelRecipient.fromJson(e))
            .toList();
      }
    }
  }

  Map<String, dynamic> toJson() => {
        '@odata.etag': etag,
        'id': id,
        '@odata.context': context,
        'receivedDateTime': receivedDateTime?.toIso8601String(),
        'internetMessageHeaders':
            internetMessageHeaders?.map((e) => e.toJson()).toList(),
        'from': from?.toJson(),
        'toRecipients': toRecipients?.map((e) => e.toJson()).toList()
      };
}
