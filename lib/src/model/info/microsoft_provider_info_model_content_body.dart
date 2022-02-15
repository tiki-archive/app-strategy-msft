/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'microsoft_provider_info_model_content_icon.dart';
import 'microsoft_provider_info_model_content_text.dart';

class MicrosoftProviderInfoModelContentBody{
  final List<MicrosoftProviderInfoModelContentText>? explain;
  final List<MicrosoftProviderInfoModelContentIcon>? theySay;
  final List<MicrosoftProviderInfoModelContentIcon>? shouldKnow;

  const MicrosoftProviderInfoModelContentBody(
      {this.explain, this.theySay, this.shouldKnow});
}
