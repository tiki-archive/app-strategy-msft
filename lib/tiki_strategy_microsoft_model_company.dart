/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class TikiStrategyMicrosoftModelCompany {
  String? domain;

  TikiStrategyMicrosoftModelCompany({this.domain});

  TikiStrategyMicrosoftModelCompany.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      domain = json['domain'];
    }
  }

  Map<String, dynamic> toJson() => {'domain': domain};
}
