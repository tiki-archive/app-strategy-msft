/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */


import 'package:microsoft_provider/src/utils/json/json_object.dart';

class MicrosoftProviderModelEmailMsgPartBody extends JsonObject {
  String? attachmentId;
  int? size;
  String? data;

  MicrosoftProviderModelEmailMsgPartBody({this.attachmentId, this.size, this.data});

  MicrosoftProviderModelEmailMsgPartBody.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      attachmentId = json['attachmentId'];
      size = json['size'];
      data = json['data'];
    }
  }

  @override
  Map<String, dynamic> toJson() =>
      {'attachmentId': attachmentId, 'size': size, 'data': data};
}
