/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiki_style/tiki_style.dart';

import 'auth_service.dart';
import 'auth_view_widget_account.dart';
import 'auth_view_widget_see.dart';
import 'auth_view_widget_unlink.dart';

class AuthViewLayoutLinked extends StatelessWidget {
  const AuthViewLayoutLinked({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthService service = Provider.of<AuthService>(context);
    return GestureDetector(
        onTap: () => service.controller.seeInfo(context),
        behavior: HitTestBehavior.opaque,
        child: Container(
            margin: EdgeInsets.all(SizeProvider.instance.size(8)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(SizeProvider.instance.size(16)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x0D000000),
                  blurRadius: SizeProvider.instance.size(8),
                  offset: Offset(SizeProvider.instance.size(3),
                      SizeProvider.instance.size(3)), // Shadow position
                ),
              ],
            ),
            child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(SizeProvider.instance.size(12)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Align(
                        alignment: Alignment.centerRight,
                        child: AuthViewWidgetUnlink()),
                    Container(
                      padding: EdgeInsets.only(
                          left: SizeProvider.instance.size(5),
                          top: SizeProvider.instance.size(5)),
                      child: const AuthViewWidgetAccount(),
                    ),
                    const Divider(color: Colors.grey),
                    const AuthViewWidgetSee()
                  ],
                ))));
  }
}
