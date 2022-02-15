/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:microsoft_provider/src/utils/json/json_object.dart';

import 'microsoft_provider_model_company.dart';


class MicrosoftProviderModelSender extends JsonObject {
  int? senderId;
  MicrosoftProviderModelCompany? company;
  String? name;
  String? email;
  String? category;
  String? unsubscribeMailTo;
  DateTime? emailSince;
  bool? unsubscribed;
  DateTime? ignoreUntil;
  DateTime? created;
  DateTime? modified;

  MicrosoftProviderModelSender(
      {this.senderId,
      this.company,
      this.name,
      this.email,
      this.category,
      this.unsubscribeMailTo,
      this.emailSince,
      DateTime? ignoreUntil,
      this.unsubscribed = false,
      this.modified,
      this.created})
      : ignoreUntil =
            ignoreUntil ?? DateTime.fromMillisecondsSinceEpoch(0);

  MicrosoftProviderModelSender.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      senderId = json['sender_id'];
      company = MicrosoftProviderModelCompany.fromJson(json['company']);
      name = json['name'];
      email = json['email'];
      category = json['category'];
      unsubscribeMailTo = json['unsubscribe_mail_to'];
      unsubscribed = json['unsubscribed_bool'] == 1 ? true : false;
      if (json['ignore_until_epoch'] != null) {
        ignoreUntil =
            DateTime.fromMillisecondsSinceEpoch(json['ignore_until_epoch']);
      }
      if (json['email_since_epoch'] != null) {
        emailSince =
            DateTime.fromMillisecondsSinceEpoch(json['email_since_epoch']);
      }
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
        'sender_id': senderId,
        'company_domain': company?.domain,
        'name': name,
        'email': email,
        'category': category,
        'unsubscribe_mail_to': unsubscribeMailTo,
        'email_since_epoch': emailSince?.millisecondsSinceEpoch,
        'ignore_until_epoch': ignoreUntil?.millisecondsSinceEpoch,
        'unsubscribed_bool': unsubscribed == true ? 1 : 0,
        'modified_epoch': modified?.millisecondsSinceEpoch,
        'created_epoch': created?.millisecondsSinceEpoch
      };

  @override
  String toString() {
    return 'MicrosoftProviderModelSender{senderId: $senderId, company: $company, name: $name, email: $email, category: $category, unsubscribeMailTo: $unsubscribeMailTo, emailSince: $emailSince, unsubscribed: $unsubscribed, ignoreUntil: $ignoreUntil}';
  }
}
