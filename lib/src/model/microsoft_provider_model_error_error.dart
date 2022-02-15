/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:microsoft_provider/src/utils/json/json_object.dart';

class MicrosoftProviderModelErrorError extends JsonObject {
  String? domain;
  String? reason;
  String? message;
  String? locationType;
  String? location;

  MicrosoftProviderModelErrorError(
      {this.domain,
      this.reason,
      this.message,
      this.locationType,
      this.location});

  MicrosoftProviderModelErrorError.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      domain = json['domain'];
      reason = json['reason'];
      message = json['message'];
      locationType = json['locationType'];
      location = json['location'];
    }
  }

  @override
  Map<String, dynamic> toJson() => {
        'domain': domain,
        'reason': reason,
        'message': message,
        'locationType': locationType,
        'location': location
      };
}
