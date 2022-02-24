/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../microsoft_provider_service.dart';

class MicrosoftProviderViewAccount extends StatelessWidget {
  final double _rowPadding = 16;
  final double _logoSize = 40;
  final double _rowGap = 15;

  const MicrosoftProviderViewAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MicrosoftProviderService service = Provider.of<MicrosoftProviderService>(context);
    return LayoutBuilder(builder: (context, constraints) {
      double cardWidth = constraints.maxWidth;
      return Container(
          padding: EdgeInsets.all(service.style.size(_rowPadding)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(service.style.size(5)),
          ),
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Image(
              image: const AssetImage('res/images/windows-logo.png',
                  package: 'microsoft_provider'),
              height: service.style.size(_logoSize),
              fit: BoxFit.fitHeight,
            ),
            Container(
                padding: EdgeInsets.only(left: service.style.size(_rowGap)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(
                              bottom: service.style.size(8)),
                          child: Text("Microsoft",
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: service.style.providerColor,
                                  height: 1,
                                  fontSize: service.style.text(14)))),
                      SizedBox(
                          width: service.style.size(
                              cardWidth - _logoSize - (2*_rowPadding) - _rowGap
                          ),
                          child: Text(service.model.email!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: service.style.textColor,
                                  height: 1,
                                  fontSize: service.style.text(18)))
                      )
                    ]))
          ]));
    });
  }
}
