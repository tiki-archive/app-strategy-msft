/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:httpp/httpp.dart';
import 'package:logging/logging.dart';

class AuthRepository {
  final Logger _log = Logger('AuthRepository');
  static const String _userinfoEndpoint =
      "https://graph.microsoft.com/oidc/userinfo";

  Future<void> userInfo(
      {required HttppClient client,
      required String accessToken,
      void Function(dynamic)? onSuccess,
      void Function(Object)? onError}) {
    HttppRequest req = HttppRequest(
        uri: Uri.parse(_userinfoEndpoint),
        verb: HttppVerb.GET,
        headers: HttppHeaders.typical(bearerToken: accessToken),
        timeout: const Duration(seconds: 30),
        onSuccess: (rsp) {
          if (onSuccess != null) onSuccess(rsp);
        },
        onResult: onError,
        onError: onError);
    _log.finest('${req.verb.value} — ${req.uri}');
    return client.request(req);
  }
}
