/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../utils/json/json_object.dart';

import 'microsoft_provider_model_email_address.dart';

class MicrosoftProviderModelRecipient extends JsonObject {
  MicrosoftProviderModelEmailAddress? emailAddress;

  MicrosoftProviderModelRecipient({this.emailAddress});

  MicrosoftProviderModelRecipient.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      emailAddress =
          MicrosoftProviderModelEmailAddress.fromJson(json['emailAddress']);
    }
  }

  @override
  Map<String, dynamic> toJson() => {'emailAddress': emailAddress?.toJson()};
}
