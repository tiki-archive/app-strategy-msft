/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:tiki_style/tiki_style.dart';

class MicrosoftProviderViewSee extends StatelessWidget {

  const MicrosoftProviderViewSee({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: SizeProvider.instance.size(12)),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text("What data does Microsoft hold",
                style: TextStyle(
                    fontSize: SizeProvider.instance.text(14),
                    fontWeight: FontWeight.bold,
                    color: ColorProvider.tikiBlue)),
            Container(
                margin: EdgeInsets.only(left: SizeProvider.instance.size(8)),
                child: Icon(IconProvider.arrow_tail_right, size: SizeProvider.instance.text(16))
                )
          ]),
        ));
  }
}
