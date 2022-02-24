/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../microsoft_provider_service.dart';


class MicrosoftProviderViewSee extends StatelessWidget {

  const MicrosoftProviderViewSee({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MicrosoftProviderService service = Provider.of<MicrosoftProviderService>(context);
    return Container(
        color: Colors.white,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: service.style.size(12)),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text("What data does Microsoft hold",
                style: TextStyle(
                    fontSize: service.style.text(14),
                    fontWeight: FontWeight.bold,
                    color: service.style.infoLinkColor)),
            Container(
                margin: EdgeInsets.only(left: service.style.size(8)),
                child: Image(
                  image: const AssetImage('res/images/right-arrow.png', package: 'microsoft_provider'),
                  height: service.style.text(16),
                  fit: BoxFit.fitHeight,
                ))
          ]),
        ));
  }
}
