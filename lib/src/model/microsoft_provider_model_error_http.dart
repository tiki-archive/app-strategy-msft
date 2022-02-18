import 'email/microsoft_provider_model_rsp.dart';

class MicrosoftProviderModelErrorHttp extends Error {
    final MicrosoftProviderModelRsp rsp;
    MicrosoftProviderModelErrorHttp(this.rsp);

    @override
    String toString() => "Http error. ${rsp.toJson()}";
}
