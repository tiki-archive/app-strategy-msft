/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'microsoft_provider_info_model_content_body.dart';
import 'microsoft_provider_info_model_content_cta.dart';

class MicrosoftProviderInfoModelContent {
  final MicrosoftProviderInfoModelContentBody? body;
  final MicrosoftProviderInfoModelContentCta? cta;

  const MicrosoftProviderInfoModelContent({this.body, this.cta});

}