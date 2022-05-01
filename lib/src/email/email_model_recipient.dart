/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'email_model_address.dart';

class EmailModelRecipient {
  EmailModelAddress? emailAddress;

  EmailModelRecipient({this.emailAddress});

  EmailModelRecipient.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      emailAddress = EmailModelAddress.fromJson(json['emailAddress']);
    }
  }

  @override
  Map<String, dynamic> toJson() => {'emailAddress': emailAddress?.toJson()};
}
