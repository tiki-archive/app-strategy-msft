/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class EmailModelHeader {
  String? value;
  String? name;

  EmailModelHeader.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      value = json['value'];
      name = json['name'];
    }
  }

  Map<String, dynamic> toJson() => {'value': value, 'name': name};
}
