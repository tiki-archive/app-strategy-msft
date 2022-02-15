import 'package:microsoft_provider/src/model/info/microsoft_provider_info_model.dart';
import 'package:httpp/httpp.dart';
import 'package:logging/logging.dart';

import '../config/microsoft_provider_config.dart';
import '../model/microsoft_provider_model_error_http.dart';
import '../model/microsoft_provider_model_rsp.dart';
import 'microsoft_provider_repository_info.dart';

class MicrosoftProviderRepository{

  final Logger _log = Logger('MicrosoftProviderRepository');

  Future<void> userInfo(
      {required HttppClient client,
        required String accessToken,
        void Function(dynamic)? onSuccess,
        void Function(Object)? onError}) {
    HttppRequest req = HttppRequest(
        uri: Uri.parse(MicrosoftProviderConfig.userinfoEndpoint),
        verb: HttppVerb.GET,
        headers: HttppHeaders.typical(bearerToken: accessToken),
        timeout: const Duration(seconds: 30),
        onSuccess: (rsp) {
          if (onSuccess != null) onSuccess(rsp);
        },
        onResult: (rsp) {
          MicrosoftProviderModelRsp body =
          MicrosoftProviderModelRsp.fromJson(rsp.body?.jsonBody, (json) {});
          MicrosoftProviderModelErrorHttp error = MicrosoftProviderModelErrorHttp(body);
          onError == null ? throw error : onError(error);
        },
        onError: onError);
    _log.finest('${req.verb.value} — ${req.uri}');
    return client.request(req);
  }

  List<MicrosoftProviderInfoModel> getTheyKnowInfo() => MicrosoftProviderRepositoryInfo.theyKnowInfo;
}