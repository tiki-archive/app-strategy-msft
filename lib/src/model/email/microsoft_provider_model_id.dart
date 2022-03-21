/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */


import '../../utils/json/json_object.dart';

class MicrosoftProviderModelId extends JsonObject {
  String? etag;
  String? id;

  MicrosoftProviderModelId({this.etag, this.id});

  MicrosoftProviderModelId.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      etag = json['@odata.etag'];
      id = json['id'];
    }
  }

  @override
  Map<String, dynamic> toJson() => {'@odata.etag': etag, 'id': id};
}
