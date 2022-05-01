/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'tiki_strategy_microsoft_model_company.dart';

class TikiStrategyMicrosoftModelSender {
  TikiStrategyMicrosoftModelCompany? company;
  String? name;
  String? email;
  String? category;
  String? unsubscribeMailTo;

  TikiStrategyMicrosoftModelSender(
      {this.company,
      this.name,
      this.email,
      this.category,
      this.unsubscribeMailTo});

  TikiStrategyMicrosoftModelSender.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      company = TikiStrategyMicrosoftModelCompany.fromJson(json['company']);
      name = json['name'];
      email = json['email'];
      category = json['category'];
      unsubscribeMailTo = json['unsubscribe_mail_to'];
    }
  }

  Map<String, dynamic> toJson() => {
        'company': company?.toJson(),
        'name': name,
        'email': email,
        'category': category,
        'unsubscribe_mail_to': unsubscribeMailTo
      };
}
