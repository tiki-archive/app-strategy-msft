/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class GraphRsp<T> {
  String? context;
  String? nextLink;
  T? value;

  GraphRsp({this.context, this.nextLink, required this.value});

  GraphRsp.fromJson(Map<String, dynamic>? json,
      T Function(Map<String, dynamic>? json) fromJson) {
    if (json != null) {
      context = json['@odata.context'];
      nextLink = json['@odata.nextLink'];
      value = fromJson(json['value']);
    }
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T?) valueToJson) =>
      {
        '@odata.context': context,
        '@odata.nextLink': nextLink,
        'value': valueToJson(value)
      };
}
