/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:microsoft_provider/src/utils/json/json_object.dart';
import 'package:microsoft_provider/src/utils/json/json_utils.dart';

import 'microsoft_provider_model_email_msg_header.dart';
import 'microsoft_provider_model_email_msg_part_body.dart';

class MicrosoftProviderModelEmailMsgPart extends JsonObject {
  String? partId;
  String? mimeType;
  String? filename;
  List<MicrosoftProviderModelEmailMsgHeader>? headers;
  MicrosoftProviderModelEmailMsgPartBody? body;
  List<MicrosoftProviderModelEmailMsgPart>? parts;

  MicrosoftProviderModelEmailMsgPart(
      {this.partId,
      this.mimeType,
      this.filename,
      this.headers,
      this.body,
      this.parts});

  MicrosoftProviderModelEmailMsgPart.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      partId = json['partId'];
      mimeType = json['mimeType'];
      filename = json['filename'];
      headers = JsonUtils.listFromJson(
          json['headers'], (json) => MicrosoftProviderModelEmailMsgHeader.fromJson(json));
      body = MicrosoftProviderModelEmailMsgPartBody.fromJson(json['body']);
      parts = JsonUtils.listFromJson(
          json['parts'], (json) => MicrosoftProviderModelEmailMsgPart.fromJson(json));
    }
  }

  @override
  Map<String, dynamic> toJson() => {
        'partId': partId,
        'mimeType': mimeType,
        'filename': filename,
        'headers': JsonUtils.listToJson(headers),
        'body': body?.toJson(),
        'parts': JsonUtils.listToJson(parts)
      };
}
