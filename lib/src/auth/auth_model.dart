/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class AuthModel {
  bool isLinked = false;
  String? displayName;
  String? email;
  String? token;
  DateTime? accessTokenExp;
  String? refreshToken;

  AuthModel(
      {this.isLinked = false,
      this.displayName,
      this.email,
      this.token,
      this.accessTokenExp,
      this.refreshToken});
}
