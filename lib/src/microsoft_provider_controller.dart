import 'microsoft_provider_service.dart';

class MicrosoftProviderController {
  final MicrosoftProviderService service;

  MicrosoftProviderController(this.service);

  Future<void> signIn() async {
    service.signIn();
  }

  void signOut() {
    service.signOut();
  }

  void seeInfo() {
    service.seeInfo();
  }
}
