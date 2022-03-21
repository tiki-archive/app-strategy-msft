import 'package:flutter/cupertino.dart';
import '../microsoft_provider_service.dart';
import 'package:provider/provider.dart';

import 'microsoft_provider_view_link.dart';
import 'microsoft_provider_view_linked.dart';

class MicrosoftProviderAccountWidget extends StatelessWidget{

  const MicrosoftProviderAccountWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MicrosoftProviderService service = Provider.of<MicrosoftProviderService>(context);
    if(service.model.isLinked){
      return const MicrosoftProviderViewLinked();
    }
    return const MicrosoftProviderViewLink();
  }

}