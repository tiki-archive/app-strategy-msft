/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiki_style/tiki_style.dart';

import '../microsoft_provider_service.dart';

class MicrosoftProviderViewUnlink extends StatelessWidget {
  static const String _text = "Unlink";

  const MicrosoftProviderViewUnlink({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MicrosoftProviderService service = Provider.of<MicrosoftProviderService>(context);
    return GestureDetector(
        onTap: service.controller.signOut,
        behavior: HitTestBehavior.opaque,
        child: Container(
            padding: EdgeInsets.only(
                top: SizeProvider.instance.size(15),
                left: SizeProvider.instance.size(18),
                right: SizeProvider.instance.size(18)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _text,
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: SizeProvider.instance.text(9.5),
                      color: ColorProvider.tikiRed),
                ),
                Container(
                    margin: EdgeInsets.only(left: SizeProvider.instance.size(3)),
                    child: Icon(IconProvider.x_mark, size: SizeProvider.instance.text(9.5) * 1.4)),
              ],
            )));
  }
}
