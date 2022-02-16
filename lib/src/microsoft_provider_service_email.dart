
import 'package:logging/logging.dart';
import 'package:microsoft_provider/src/microsoft_provider_service.dart';
import 'package:microsoft_provider/src/repository/microsoft_provider_repository_email.dart';

import 'model/email/microsoft_provider_model_email.dart';

class MicrosoftProviderServiceEmail {
  final Logger _log = Logger('MicrosoftProviderServiceEmail');
  final MicrosoftProviderRepositoryEmail _repositoryEmail;
  final MicrosoftProviderService _service;

  MicrosoftProviderServiceEmail(this._service)
      : _repositoryEmail = MicrosoftProviderRepositoryEmail();

  Future<void> fetchInbox({DateTime? since, required Function(List<String> messagesIds) onResult, required Function() onFinish}) {
    throw Exception("TO BE IMPLEMENTED");
  }

  Future<void> fetchMessages({required List<String> messageIds, required Function(MicrosoftProviderModelEmail message) onResult, required Function() onFinish}) {
    throw Exception("TO BE IMPLEMENTED");
  }

  Future<void> send({String? body, required String to, String? subject, Function(bool p1)? onResult}) {
    throw Exception("TO BE IMPLEMENTED");
  }

}
