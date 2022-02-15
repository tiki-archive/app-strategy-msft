import 'package:flutter/material.dart';
import 'package:microsoft_provider/microsoft_provider.dart';
import 'package:logging/logging.dart';

import 'config_log.dart';

Future<void> main() async {
  ConfigLog();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Logger _log = Logger('example app');

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MicrosoftProvider googleProvider = MicrosoftProvider(
      onLink: (model) => _log.finest(model),
      onUnlink: (email) => _log.finest(email),
      onSee: (data) => _log.finest(data),
    );
    List<String> msgIds = [];
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Container(
            color: Colors.grey,
            child: Center(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MicrosoftProvider.loggedIn(
                            displayName : "Test",
                            email : "reallylongemailtooverflow@gmail.com",
                            token : "abc",
                            refreshToken : "def"
                          ).accountWidget(),
                      const Padding(padding: EdgeInsets.all(10)),
                      googleProvider.accountWidget(),
                      const Padding(padding: EdgeInsets.all(10)),
                      ElevatedButton(
                          onPressed: () => googleProvider.sendEmail(
                              body : "test email from google provider",
                              to : "ricardolgrj@yahoo.com.br",
                              subject : "testing email",
                              onResult : (isOk) => isOk ?
                                  _log.finest('email sent') :
                                  _log.warning('email not sent')
                          ),
                          child: const Text('Send test email')
                      ),
                      const Padding(padding: EdgeInsets.all(10)),
                      ElevatedButton(
                        onPressed: () => googleProvider.fetchInbox(
                            onResult: (messages) async {
                              msgIds.addAll(messages);
                              _log.fine('fetched ${messages.length} messages');
                            },
                            onFinish: () async {
                              _log.fine('finished fetching inbox.');
                          }),
                          child: const Text('Fetch Inbox')
                      ),
                      const Padding(padding: EdgeInsets.all(10)),
                      ElevatedButton(
                        onPressed: () => googleProvider.fetchMessages(
                            messageIds: msgIds,
                            onResult: (message) async {
                              _log.fine('fetched message id ${message.extMessageId} - $message');
                            },
                            onFinish: () async {
                              _log.fine('finished fetching messages.');
                            }),
                        child: const Text('Fetch Messages')
                    )])
            )),
      ));
  }
}