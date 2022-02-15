/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:microsoft_provider/src/utils/json/json_object.dart';

class MicrosoftProviderModelCompany extends JsonObject {
  int? companyId;
  String? logo;
  double? securityScore;
  double? breachScore;
  double? sensitivityScore;
  String? domain;
  DateTime? created;
  DateTime? modified;

  MicrosoftProviderModelCompany(
      {this.companyId,
      this.logo,
      this.securityScore,
      this.domain,
      this.sensitivityScore,
      this.breachScore,
      this.created,
      this.modified});

  MicrosoftProviderModelCompany.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      companyId = json['company_id'];
      logo = json['logo'];
      securityScore = json['security_score'];
      breachScore = json['breach_score'];
      sensitivityScore = json['sensitivity_score'];
      domain = json['domain'];
      if (json['modified_epoch'] != null) {
        modified =
            DateTime.fromMillisecondsSinceEpoch(json['modified_epoch']);
      }
      if (json['created_epoch'] != null) {
        created =
            DateTime.fromMillisecondsSinceEpoch(json['created_epoch']);
      }
    }
  }

  @override
  Map<String, dynamic> toJson() => {
        'company_id': companyId,
        'logo': logo,
        'security_score': securityScore,
        'breach_score': breachScore,
        'sensitivity_score': sensitivityScore,
        'domain': domain,
        'modified_epoch': modified?.millisecondsSinceEpoch,
        'created_epoch': created?.millisecondsSinceEpoch
      };

  @override
  String toString() {
    return 'MicrosoftProviderModelCompanyLocal{companyId: $companyId, logo: $logo, securityScore: $securityScore, breachScore: $breachScore, sensitivityScore: $sensitivityScore, domain: $domain, created: $created, modified: $modified}';
  }

  static String? domainFromEmail(String? email) {
    if (email != null) {
      List<String> atSplit = email.split('@');
      List<String> periodSplit = atSplit[atSplit.length - 1].split('.');
      return periodSplit[periodSplit.length - 2] +
          "." +
          periodSplit[periodSplit.length - 1];
    }
  }
}
