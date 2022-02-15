/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:microsoft_provider/src/utils/json/json_object.dart';

class MicrosoftProviderModelErrorDetail extends JsonObject {
  String? type;
  String? reason;
  String? domain;
  Map<String, dynamic>? metadata;

  MicrosoftProviderModelErrorDetail(
      {this.type, this.reason, this.domain, this.metadata});

  MicrosoftProviderModelErrorDetail.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      type = json['@type'];
      reason = json['reason'];
      domain = json['domain'];
      metadata = json['metadata'];
    }
  }

  @override
  Map<String, dynamic> toJson() =>
      {'@type': type, 'reason': reason, 'domain': domain, 'metadata': metadata};
}
