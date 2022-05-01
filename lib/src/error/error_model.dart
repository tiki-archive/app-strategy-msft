/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'error_model_error.dart';

class ErrorModel {
  ErrorModelError? error;

  ErrorModel({this.error});

  ErrorModel.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      error = ErrorModelError.fromJson(json['error']);
    }
  }

  Map<String, dynamic> toJson() => {'error': error?.toJson()};
}
