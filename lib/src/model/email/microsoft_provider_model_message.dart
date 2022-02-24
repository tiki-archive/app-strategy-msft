/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */


import 'package:microsoft_provider/src/utils/json/json_object.dart';
import 'package:microsoft_provider/src/utils/json/json_utils.dart';

import 'microsoft_provider_model_header.dart';
import 'microsoft_provider_model_recipient.dart';

class MicrosoftProviderModelMessage extends JsonObject {
  String? etag;
  String? id;
  String? context;
  DateTime? receivedDateTime;
  List<MicrosoftProviderModelHeader>? internetMessageHeaders;
  MicrosoftProviderModelRecipient? from;
  List<MicrosoftProviderModelRecipient>? toRecipients;

  MicrosoftProviderModelMessage(
      {this.etag,
      this.id,
      this.context,
      this.receivedDateTime,
      this.internetMessageHeaders,
      this.from,
      this.toRecipients});

  MicrosoftProviderModelMessage.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      etag = json['@odata.etag'];
      id = json['id'];
      context = json['@odata.context'];
      receivedDateTime = DateTime.tryParse(json['receivedDateTime']);
      internetMessageHeaders = JsonUtils.listFromJson(
          json['internetMessageHeaders'],
          (json) => MicrosoftProviderModelHeader.fromJson(json));
      from = MicrosoftProviderModelRecipient.fromJson(json['from']);
      toRecipients = JsonUtils.listFromJson(json['toRecipients'],
          (json) => MicrosoftProviderModelRecipient.fromJson(json));
    }
  }

  @override
  Map<String, dynamic> toJson() => {
        '@odata.etag': etag,
        'id': id,
        '@odata.context': context,
        'receivedDateTime': receivedDateTime?.toIso8601String(),
        'internetMessageHeaders': JsonUtils.listToJson(internetMessageHeaders),
        'from': from?.toJson(),
        'toRecipients': JsonUtils.listToJson(toRecipients)
      };
}
