/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:info_carousel/info_carousel.dart';

import '../info/info_service.dart';
import 'auth_service.dart';

class AuthController {
  final AuthService service;
  final InfoService _infoService = InfoService();

  AuthController(this.service);

  Future<void> signIn() => service.signIn();

  Future<void> signOut() => service.signOut();

  Future<void> seeInfo(BuildContext context) =>
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              InfoCarousel(cards: _infoService.getAll()).carouselWidget()));
}
