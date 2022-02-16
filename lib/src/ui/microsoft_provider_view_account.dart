/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../microsoft_provider_service.dart';

class MicrosoftProviderViewAccount extends StatelessWidget {

  const MicrosoftProviderViewAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MicrosoftProviderService service = Provider.of<MicrosoftProviderService>(context);
    return Container(
        padding: EdgeInsets.all(service.style.size(16)),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(service.style.size(5)),
        ),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Image(
            image: const AssetImage('res/images/windows-logo.png', package: 'microsoft_provider'),
            height: service.style.size(30),
            fit: BoxFit.fitHeight,
          ),
          Container(
            padding: EdgeInsets.only(left: service.style.size(15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.only(bottom: service.style.size(8)),
                    child: Text("Microsoft",
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: service.style.providerColor,
                            height: 1,
                            fontSize: service.style.text(14)))),
                SizedBox(
                      width: service.style.size(280),
                      child: Text(service.model.email!,
                        maxLines : 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: service.style.textColor,
                            height: 1,
                            fontSize: service.style.text(18)))
                    )
              ]))]));
  }
}
