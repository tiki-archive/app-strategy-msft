/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:httpp/httpp.dart';
import 'package:logging/logging.dart';

class MicrosoftProviderRepositoryEmail {
  final Logger _log = Logger('MicrosoftProviderRepositoryEmail');

  Future message({HttppClient client, String? accessToken, String messageId, Null Function(dynamic response) onSuccess, Null Function(dynamic response) onResult, Null Function(dynamic error) onError}) {}

  Future<void> send({HttppClient client, String? accessToken, HttppBody message, Null Function(dynamic response) onSuccess, Future<Null> Function(dynamic response) onResult, Null Function(dynamic error) onError}) {}
}
