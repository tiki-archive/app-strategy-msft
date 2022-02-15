/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:microsoft_provider/src/utils/json/json_object.dart';
import 'package:microsoft_provider/src/utils/json/json_utils.dart';

import 'microsoft_provider_model_error_detail.dart';
import 'microsoft_provider_model_error_error.dart';

class MicrosoftProviderModelError extends JsonObject {
  int? code;
  String? message;
  String? status;
  List<MicrosoftProviderModelErrorError>? errors;
  List<MicrosoftProviderModelErrorDetail>? details;

  MicrosoftProviderModelError(
      {this.code, this.message, this.status, this.errors, this.details});

  MicrosoftProviderModelError.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      code = json['code'];
      message = json['message'];
      status = json['status'];
      errors = JsonUtils.listFromJson(
          json['errors'], (json) => MicrosoftProviderModelErrorError.fromJson(json));
      details = JsonUtils.listFromJson(
          json['details'], (json) => MicrosoftProviderModelErrorDetail.fromJson(json));
    }
  }

  @override
  Map<String, dynamic> toJson() => {
        'code': code,
        'message': message,
        'status': status,
        'errors': JsonUtils.listToJson(errors),
        'details': JsonUtils.listToJson(details)
      };
}
