/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiki_style/tiki_style.dart';

import '../microsoft_provider_service.dart';
import 'microsoft_provider_view_account.dart';
import 'microsoft_provider_view_see.dart';
import 'microsoft_provider_view_unlink.dart';

class MicrosoftProviderViewLinked extends StatelessWidget {

  const MicrosoftProviderViewLinked({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MicrosoftProviderService service = Provider.of<MicrosoftProviderService>(context);
    return GestureDetector(
        onTap: service.controller.seeInfo,
        behavior: HitTestBehavior.opaque,
        child: Container(
            margin: EdgeInsets.all(SizeProvider.instance.size(8)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(SizeProvider.instance.size(8)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x0D000000),
                  blurRadius: SizeProvider.instance.size(8),
                  offset: Offset(SizeProvider.instance.size(3), SizeProvider.instance.size(3)), // Shadow position
                ),
              ],
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(SizeProvider.instance.size(12)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Align(
                        alignment: Alignment.centerRight,
                        child: MicrosoftProviderViewUnlink()),
                    Container(
                        padding: EdgeInsets.only(left: SizeProvider.instance.size(5), top: SizeProvider.instance.size(5)),
                        child: const MicrosoftProviderViewAccount(),
                    ),
                    const Divider(color: Colors.grey),
                    const MicrosoftProviderViewSee()
                  ],
                ))));
  }
}
