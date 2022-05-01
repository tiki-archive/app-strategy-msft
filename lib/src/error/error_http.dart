/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'error_model.dart';

class ErrorHttp extends Error {
  final ErrorModel rsp;

  ErrorHttp(this.rsp);

  @override
  String toString() => "Http error. ${rsp.toJson()}";
}
