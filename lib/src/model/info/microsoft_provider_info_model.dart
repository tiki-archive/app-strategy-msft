/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'microsoft_provider_info_model_content.dart';
import 'microsoft_provider_info_model_cover.dart';

class MicrosoftProviderInfoModel {
  final MicrosoftProviderInfoModelCover? cover;
  final MicrosoftProviderInfoModelContent? content;

  const MicrosoftProviderInfoModel({this.cover, this.content});
}