/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'tiki_strategy_microsoft_model_sender.dart';

class TikiStrategyMicrosoftModelEmail {
  String? extMessageId;
  TikiStrategyMicrosoftModelSender? sender;
  DateTime? receivedDate;
  DateTime? openedDate;
  String? toEmail;
  String? subject;

  TikiStrategyMicrosoftModelEmail(
      {this.extMessageId,
      this.sender,
      this.receivedDate,
      this.openedDate,
      this.toEmail,
      this.subject});

  TikiStrategyMicrosoftModelEmail.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      extMessageId = json['ext_message_id'];
      sender = TikiStrategyMicrosoftModelSender.fromJson(json['sender']);
      toEmail = json['to_email'];
      subject = json['subject'];
      if (json['received_date_epoch'] != null) {
        receivedDate =
            DateTime.fromMillisecondsSinceEpoch(json['received_date_epoch']);
      }
      if (json['opened_date_epoch'] != null) {
        openedDate =
            DateTime.fromMillisecondsSinceEpoch(json['opened_date_epoch']);
      }
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'ext_message_id': extMessageId,
      'sender': sender?.toJson(),
      'received_date_epoch': receivedDate?.millisecondsSinceEpoch,
      'opened_date_epoch': openedDate?.millisecondsSinceEpoch,
      'to_email': toEmail,
      'subject': subject
    };
  }
}
