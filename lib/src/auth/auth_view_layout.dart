/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'auth_service.dart';
import 'auth_view_layout_link.dart';
import 'auth_view_layout_linked.dart';

class AuthViewLayout extends StatelessWidget {
  const AuthViewLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthService service = Provider.of<AuthService>(context);

    return service.model.isLinked
        ? const AuthViewLayoutLinked()
        : const AuthViewLayoutLink();
  }
}
