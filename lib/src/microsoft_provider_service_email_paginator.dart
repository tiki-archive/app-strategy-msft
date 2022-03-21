/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:httpp/httpp.dart';
import 'package:logging/logging.dart';
import 'microsoft_provider_service.dart';
import 'model/email/microsoft_provider_model_id.dart';
import 'model/email/microsoft_provider_model_rsp.dart';

class MicrosoftProviderServiceEmailPaginator {
  final _log = Logger('MicrosoftProviderServiceEmailPaginator');

  static const int MAX_RESULTS = 1000;
  static const int NUM_REQUESTS = 1;

  final MicrosoftProviderService service;
  final void Function(List<String> messages)? onSuccess;
  final void Function(Object error)? onError;
  final void Function(HttppResponse response)? onResult;
  final DateTime? since;
  int _page = 0;
  late final HttppClient httppClient;

  MicrosoftProviderServiceEmailPaginator(
      {required this.service,
      void Function()? onFinish,
      this.onSuccess,
      this.onResult,
      this.onError,
      this.since}) {
    httppClient = service.client;
  }

  Future<void> fetchInbox() async {
    List<Future> futures = [];
    for (int i = 0; i < NUM_REQUESTS; i++) {
      futures.add(_fetch());
    }
    await Future.wait(futures);
  }

  Future<void> _fetch() {
    Future<void> future = service.email.repository.messageId(
        client: httppClient,
        accessToken: service.model.token,
        filter:
            _buildFilter(page: _page, maxResults: MAX_RESULTS, after: since),
        onSuccess: _onSuccess,
        onResult: _onResult,
        onError: _onError);
    _page++;
    return future;
  }

  Future<void> _onSuccess(HttppResponse response) async {
    MicrosoftProviderModelRsp model = MicrosoftProviderModelRsp.fromJson(
        response.body?.jsonBody,
        (json) => MicrosoftProviderModelId.fromJson(json));

    if (model.nextLink != null) await _fetch();

    if (onSuccess != null) {
      List<MicrosoftProviderModelId> messages = List.castFrom(model.value);
      List<String> messagesIds = messages.map((m) => m.id ?? "").toList();
      messagesIds.removeWhere((element) => element.isEmpty);
      onSuccess!(messagesIds);
    }
  }

  void _onResult(HttppResponse response) {
    _log.warning(
        'Fetch inbox ${service.model.email} failed with statusCode ${response.statusCode}');
    if (onResult != null) onResult!(response);
  }

  void _onError(Object error) {
    _log.warning('Fetch inbox ${service.model.email} failed with error $error');
    if (onError != null) onError!(error);
  }

  //we dont use from anymore
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
