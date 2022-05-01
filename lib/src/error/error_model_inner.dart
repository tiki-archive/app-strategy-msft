/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class ErrorModelInner {
  DateTime? date;
  String? requestId;
  String? clientRequestId;

  ErrorModelInner.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      if (json['date'] != null) {
        date = DateTime.tryParse(json['date']);
      }
      requestId = json['request-id'];
      clientRequestId = json['client-request-id'];
    }
  }

  Map<String, dynamic> toJson() => {
        'date': date?.toIso8601String(),
        'request-id': requestId,
        'client-request-id': clientRequestId
      };
}
