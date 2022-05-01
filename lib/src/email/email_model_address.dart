/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class EmailModelAddress {
  String? address;
  String? name;

  EmailModelAddress.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      address = json['address'];
      name = json['name'];
    }
  }

  Map<String, dynamic> toJson() => {'address': address, 'name': name};
}
