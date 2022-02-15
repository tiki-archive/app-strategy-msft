import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../microsoft_provider_service.dart';

class MicrosoftProviderViewLink extends StatelessWidget {

  final String _text = "Sign in with Google";

  const MicrosoftProviderViewLink({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MicrosoftProviderService service = Provider.of<MicrosoftProviderService>(context);
    return GestureDetector(
        onTap: service.controller.signIn,
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: service.style.size(8)),
          height: service.style.size(40),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(service.style.size(5)),
            boxShadow: [
              BoxShadow(
                color: const Color(0x0D000000),
                blurRadius: service.style.size(2),
                offset: Offset(service.style.size(0.75), service.style.size(0.75)), // Shadow position
              ),
            ],
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Image(
              image: const AssetImage('res/images/google-icon.png', package: 'microsoft_provider'),
              height: service.style.size(18),
              fit: BoxFit.fitHeight,
            ),
            Container(
                margin: EdgeInsets.only(left: service.style.size(24)),
                child: Text(_text,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: service.style.size(14),
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w500,
                        color: Colors.black54))),
          ]),
        ));
  }
}
