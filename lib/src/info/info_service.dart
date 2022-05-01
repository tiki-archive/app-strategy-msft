/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:info_carousel/info_carousel.dart';

import 'info_repository.dart';

class InfoService {
  List<InfoCarouselCardModel> getAll() => InfoRepository.cards;
}
