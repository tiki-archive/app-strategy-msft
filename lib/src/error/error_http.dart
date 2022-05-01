/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../graph/graph_rsp.dart';

class ErrorHttp<T> extends Error {
  final GraphRsp<T> rsp;
  final Map<String, dynamic> Function(T?) valueToJson;

  ErrorHttp(this.rsp, this.valueToJson);

  @override
  String toString() =>
      "Http error. ${rsp.toJson((value) => valueToJson(value))}";
}
