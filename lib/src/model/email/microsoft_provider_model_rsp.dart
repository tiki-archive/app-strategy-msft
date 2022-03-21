/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */


import '../../utils/json/json_object.dart';
import '../../utils/json/json_utils.dart';

class MicrosoftProviderModelRsp<T extends JsonObject> extends JsonObject {
  String? context;
  String? nextLink;
  dynamic value;

  MicrosoftProviderModelRsp({this.context, this.nextLink, required this.value});

  MicrosoftProviderModelRsp.fromJson(
      Map<String, dynamic>? json, T Function(Map<String, dynamic>? json) fromJson) {
    if (json != null) {
      context = json['@odata.context'];
      nextLink = json['@odata.nextLink'];
      if (json['value'] != null) {
        value = json['value'] is List
            ? JsonUtils.listFromJson(json['value'], fromJson)
            : fromJson(json);
      }
    }
  }

  @override
  Map<String, dynamic> toJson() => {
        '@odata.context': context,
        '@odata.nextLink': nextLink,
        'value': value?.toJson()
      };
}
