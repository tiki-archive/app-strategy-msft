/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */


import 'package:microsoft_provider/src/utils/json/json_object.dart';

class MicrosoftProviderModelHeader extends JsonObject {
  String? value;
  String? name;

  MicrosoftProviderModelHeader.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      value = json['value'];
      name = json['name'];
    }
  }

  @override
  Map<String, dynamic> toJson() => {'value': value, 'name': name};
}
