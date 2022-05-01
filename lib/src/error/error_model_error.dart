/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

/*
{"error":{"code":"InvalidAuthenticationToken","message":"CompactToken parsing failed with error code: 80049217","innerError":{"date":"2022-05-01T05:17:05","request-id":"0c118c74-a50d-425c-92a0-7808a6693ccf","client-request-id":"0c118c74-a50d-425c-92a0-7808a6693ccf"}}}
 */

import 'error_model_inner.dart';

class ErrorModelError {
  String? code;
  String? message;
  ErrorModelInner? innerError;

  ErrorModelError.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      code = json['code'];
      message = json['message'];
      innerError = ErrorModelInner.fromJson(json['innerError']);
    }
  }

  Map<String, dynamic> toJson() =>
      {'code': code, 'message': message, 'innerError': innerError?.toJson()};
}
