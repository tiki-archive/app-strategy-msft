/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:provider/provider.dart';

import 'auth_service.dart';
import 'auth_view_layout.dart';

class AuthPresenter {
  final AuthService service;

  AuthPresenter(this.service);

  ChangeNotifierProvider<AuthService> authButton() {
    return ChangeNotifierProvider.value(
        value: service, child: const AuthViewLayout());
  }
}
