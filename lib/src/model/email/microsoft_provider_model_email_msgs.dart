/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:microsoft_provider/src/utils/json/json_object.dart';
import 'package:microsoft_provider/src/utils/json/json_utils.dart';

import 'microsoft_provider_model_email_msg.dart';

class MicrosoftProviderModelEmailMsgs extends JsonObject {
  List<MicrosoftProviderModelEmailMsg>? messages;
  int? resultSizeEstimate;
  String? nextPageToken;

  MicrosoftProviderModelEmailMsgs(
      {this.messages, this.resultSizeEstimate, this.nextPageToken});

  MicrosoftProviderModelEmailMsgs.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      messages = JsonUtils.listFromJson(
          json['messages'], (json) => MicrosoftProviderModelEmailMsg.fromJson(json));
      resultSizeEstimate = json['resultSizeEstimate'];
      nextPageToken = json['nextPageToken'];
    }
  }

  @override
  Map<String, dynamic> toJson() => {
        'messages': JsonUtils.listToJson(messages),
        'resultSizeEstimate': resultSizeEstimate,
        'nextPageToken': nextPageToken
      };
}
