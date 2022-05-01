/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class EmailModelId {
  String? etag;
  String? id;

  EmailModelId({this.etag, this.id});

  EmailModelId.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      etag = json['@odata.etag'];
      id = json['id'];
    }
  }

  Map<String, dynamic> toJson() => {'@odata.etag': etag, 'id': id};
}
