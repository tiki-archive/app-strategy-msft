import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiki_style/tiki_style.dart';

import '../microsoft_provider_service.dart';

class MicrosoftProviderViewLink extends StatelessWidget {

  final String _text = "Sign in with Microsoft";

  const MicrosoftProviderViewLink({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MicrosoftProviderService service = Provider.of<MicrosoftProviderService>(context);
    return GestureDetector(
        onTap: service.controller.signIn,
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: SizeProvider.instance.size(12)),
          height: SizeProvider.instance.size(45),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFF8C8C8C), width: 1.0),
            boxShadow: [
              BoxShadow(
                color: const Color(0x0D000000),
                blurRadius: SizeProvider.instance.size(2),
                offset: Offset(SizeProvider.instance.size(0.75), SizeProvider.instance.size(0.75)), // Shadow position
              ),
            ],
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            SizedBox(
                height: SizeProvider.instance.size(18),
                width: SizeProvider.instance.size(18),
                child: FittedBox(
                    fit:BoxFit.fill,
                    child: ImgProvider.windowsLogo)
            ),
            Container(
                margin: EdgeInsets.only(left: SizeProvider.instance.size(12)),
                child: Text(_text,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: SizeProvider.instance.text(15),
                        fontFamily: TextProvider.familySegoe,
                        package: "tiki_style",
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF5E5E5E)))),
          ]),
        ));
  }
}
