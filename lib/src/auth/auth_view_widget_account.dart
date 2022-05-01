/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiki_style/tiki_style.dart';

import 'auth_service.dart';

class AuthViewWidgetAccount extends StatelessWidget {
  final double _rowPadding = 16;
  final double _logoSize = 40;
  final double _rowGap = 15;

  const AuthViewWidgetAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthService service = Provider.of<AuthService>(context);
    return LayoutBuilder(builder: (context, constraints) {
      double cardWidth = constraints.maxWidth;
      return Container(
          padding: EdgeInsets.all(SizeProvider.instance.size(_rowPadding)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(SizeProvider.instance.size(5)),
          ),
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SizedBox(
              child: FittedBox(
                fit: BoxFit.fill,
                child: ImgProvider.windowsLogo,
              ),
              width: SizeProvider.instance.size(_logoSize),
              height: SizeProvider.instance.size(_logoSize),
            ),
            Container(
                padding:
                    EdgeInsets.only(left: SizeProvider.instance.size(_rowGap)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(
                              bottom: SizeProvider.instance.size(8)),
                          child: Text("Microsoft",
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: ColorProvider.greySix,
                                  height: 1,
                                  fontSize: SizeProvider.instance.text(14)))),
                      SizedBox(
                          width: SizeProvider.instance.size(cardWidth -
                              _logoSize -
                              (2 * _rowPadding) -
                              _rowGap),
                          child: Text(service.model.email!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: ColorProvider.tikiBlue,
                                  height: 1,
                                  fontSize: SizeProvider.instance.text(18))))
                    ]))
          ]));
    });
  }
}
