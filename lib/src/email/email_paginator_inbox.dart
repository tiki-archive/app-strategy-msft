// ignore_for_file: constant_identifier_names

/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:httpp/httpp.dart';
import 'package:logging/logging.dart';

import '../auth/auth_service.dart';
import '../graph/graph_model_page.dart';
import 'email_model_id.dart';
import 'email_repository.dart';

class EmailPaginatorInbox {
  final _log = Logger('EmailServicePaginator');

  static const int MAX_RESULTS = 1000;
  static const int NUM_REQUESTS = 1;

  // from https://docs.microsoft.com/en-us/office/client-developer/outlook/mapi/pidtaglistunsubscribe-canonical-property
  static const String MAP_LIST_UNSUBSCRIBE_ID = "0x1045";
  static const String LIST_UNSUBSCRIBE_FILTER = "singleValueExtendedProperties/Any(ep: ep/id eq 'String " +
                                                MAP_LIST_UNSUBSCRIBE_ID +
                                                "' and ep/value ne null )";

  final AuthService _authService;
  final EmailRepository _repository;
  final void Function(List<String> messages, {String? page})? onSuccess;
  final void Function(Object error)? onError;
  final void Function(HttppResponse response)? onResult;
  final void Function()? onFinish;
  final DateTime? since;
  int page = 0;
  late final HttppClient httppClient;

  EmailPaginatorInbox(
      {required AuthService authService,
      required EmailRepository repository,
      this.onFinish,
      this.onSuccess,
      this.onResult,
      this.onError,
      this.since,
      this.page = 0})
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
            _buildFilter(page: page, maxResults: MAX_RESULTS, after: since),
        onSuccess: (response) => _onSuccess(response, page: page.toString()),
        onResult: _onResult,
        onError: _onError);
    page++;
    return future;
  }

  Future<void> _onSuccess(HttppResponse response, {String? page}) async {
    GraphModelPage<List<EmailModelId>> model = GraphModelPage.fromJson(
        response.body?.jsonBody,
        (json) => (json as List).map((e) => EmailModelId.fromJson(e)).toList());

    if (onSuccess != null) {
      List<EmailModelId> messages = model.value ?? List.empty();
      List<String> messagesIds = messages.map((m) => m.id ?? "").toList();
      messagesIds.removeWhere((element) => element.isEmpty);
      onSuccess!(messagesIds, page: page);
    }

    if (model.nextLink != null) {
      await _fetch();
    } else if (onFinish != null) {
      onFinish!();
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

    // only fetch emails with list unsubscribes
    // _appendQuery(queryBuffer, LIST_UNSUBSCRIBE_FILTER);
    
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
