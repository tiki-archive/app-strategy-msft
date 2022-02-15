import 'package:provider/provider.dart';

import '../src/microsoft_provider_service.dart';
import 'ui/microsoft_provider_account_widget.dart';

class MicrosoftProviderPresenter {
  final MicrosoftProviderService service;

  MicrosoftProviderPresenter(this.service);

  ChangeNotifierProvider<MicrosoftProviderService> accountButton(
      {onLink, onUnlink, onSee}) {
    return ChangeNotifierProvider.value(
        value: service, child: const MicrosoftProviderAccountWidget());
  }
}
