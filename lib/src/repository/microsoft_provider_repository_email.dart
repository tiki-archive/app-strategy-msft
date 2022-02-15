/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:httpp/httpp.dart';
import 'package:logging/logging.dart';

class MicrosoftProviderRepositoryEmail {
  final Logger _log = Logger('MicrosoftProviderRepositoryEmail');

  Future message({required HttppClient client, String? accessToken, required String messageId, required Null Function(dynamic response) onSuccess, required Function(dynamic response) onResult, required Null Function(dynamic error) onError}) {
    throw Exception("TO BE IMPLEMENTED");
  }

  Future<void> send({required HttppClient client, String? accessToken, required HttppBody message, required Null Function(dynamic response) onSuccess, required Future<void> Function(dynamic response) onResult, required Null Function(dynamic error) onError}) async {
    throw Exception("TO BE IMPLEMENTED");
  }
}
