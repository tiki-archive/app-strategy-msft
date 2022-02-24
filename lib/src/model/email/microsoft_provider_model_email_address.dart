/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */


import 'package:microsoft_provider/src/utils/json/json_object.dart';

class MicrosoftProviderModelEmailAddress extends JsonObject {
  String? address;
  String? name;

  MicrosoftProviderModelEmailAddress.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      address = json['address'];
      name = json['name'];
    }
  }

  @override
  Map<String, dynamic> toJson() => {'address': address, 'name': name};
}
