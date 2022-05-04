/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiki_style/tiki_style.dart';

import 'auth_service.dart';

class AuthViewWidgetUnlink extends StatelessWidget {
  static const String _text = "Unlink";

  const AuthViewWidgetUnlink({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthService service = Provider.of<AuthService>(context);
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
                      fontSize: SizeProvider.instance.text(11),
                      color: ColorProvider.tikiRed),
                ),
                Container(
                    margin:
                        EdgeInsets.only(left: SizeProvider.instance.size(4)),
                    child: Icon(IconProvider.x_mark,
                        color: ColorProvider.tikiRed,
                        size: SizeProvider.instance.text(16))),
              ],
            )));
  }
}
