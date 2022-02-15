/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */


import 'package:microsoft_provider/src/utils/json/json_object.dart';

class MicrosoftProviderModelEmailMsgHeader extends JsonObject {
  String? name;
  String? value;

  MicrosoftProviderModelEmailMsgHeader({this.name, this.value});

  MicrosoftProviderModelEmailMsgHeader.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      name = json['name'];
      value = json['value'];
    }
  }

  @override
  Map<String, dynamic> toJson() => {'name': name, 'value': value};
}
