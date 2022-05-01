// ignore_for_file: constant_identifier_names

/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:httpp/httpp.dart';
import 'package:logging/logging.dart';

import '../auth/auth_service.dart';
import '../graph/graph_rsp.dart';
import 'email_model_id.dart';
import 'email_repository.dart';

class EmailPaginatorInbox {
  final _log = Logger('EmailServicePaginator');

  static const int MAX_RESULTS = 1000;
  static const int NUM_REQUESTS = 1;

  final AuthService _authService;
  final EmailRepository _repository;
  final void Function(List<String> messages)? onSuccess;
  final void Function(Object error)? onError;
  final void Function(HttppResponse response)? onResult;
  final DateTime? since;
  int _page = 0;
  late final HttppClient httppClient;

  EmailPaginatorInbox(
      {required AuthService authService,
      required EmailRepository repository,
      void Function()? onFinish,
      this.onSuccess,
      this.onResult,
      this.onError,
      this.since})
      : _authService = authService,
        _repository = repository,
        httppClient = authService.client;

  Future<void> fetchInbox() async {
    List<Future> futures = [];
    for (int i = 0; i < NUM_REQUESTS; i++) {
      futures.add(_fetch());
    }
    await Future.wait(futures);
  }

  Future<void> _fetch() {
    Future<void> future = _repository.messageId(
        client: httppClient,
        accessToken: _authService.model.token,
        filter:
            _buildFilter(page: _page, maxResults: MAX_RESULTS, after: since),
        onSuccess: _onSuccess,
        onResult: _onResult,
        onError: _onError);
    _page++;
    return future;
  }

  Future<void> _onSuccess(HttppResponse response) async {
    GraphRsp model = GraphRsp.fromJson(
        response.body?.jsonBody, (json) => EmailModelId.fromJson(json));

    if (model.nextLink != null) await _fetch();

    if (onSuccess != null) {
      List<EmailModelId> messages = List.castFrom(model.value);
      List<String> messagesIds = messages.map((m) => m.id ?? "").toList();
      messagesIds.removeWhere((element) => element.isEmpty);
      onSuccess!(messagesIds);
    }
  }

  void _onResult(HttppResponse response) {
    _log.warning(
        'Fetch inbox ${_authService.model.email} failed with statusCode ${response.statusCode}');
    if (onResult != null) onResult!(response);
  }

  void _onError(Object error) {
    _log.warning(
        'Fetch inbox ${_authService.model.email} failed with error $error');
    if (onError != null) onError!(error);
  }

  String _buildFilter({DateTime? after, int page = 0, int maxResults = 10}) {
    StringBuffer queryBuffer = StringBuffer();
    if (after != null) {
      _appendQuery(queryBuffer,
          'receivedDateTime ge ${after.toUtc().toIso8601String()}');
    }
    int skip = page * maxResults;
    queryBuffer.write('&\$skip=$skip&\$top=$maxResults');
    return queryBuffer.toString();
  }

  StringBuffer _appendQuery(StringBuffer queryBuffer, String append) {
    if (queryBuffer.isNotEmpty) {
      queryBuffer.write(' and ');
    }
    queryBuffer.write(append);
    return queryBuffer;
  }
}
