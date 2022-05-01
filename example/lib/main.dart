import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:tiki_strategy_microsoft/tiki_strategy_microsoft.dart';

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
    TikiStrategyMicrosoft notLoggedIn = TikiStrategyMicrosoft(
        onLink: (model) => _log.finest(model),
        onUnlink: (email) => _log.finest(email),
        redirectUri: 'test',
        clientId: 'test');

    TikiStrategyMicrosoft loggedIn = TikiStrategyMicrosoft.loggedIn(
        displayName: "Test",
        email: "reallylongemailtooverflow@gmail.com",
        token: "abc",
        refreshToken: "def",
        redirectUri: 'test',
        clientId: 'test');

    List<String> msgIds = [];
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Container(
          color: Colors.grey,
          child: Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
            loggedIn.authButton,
            const Padding(padding: EdgeInsets.all(10)),
            notLoggedIn.authButton,
            const Padding(padding: EdgeInsets.all(10)),
            ElevatedButton(
                onPressed: () => loggedIn.sendEmail(
                    body: "test email from google provider",
                    to: "ricardolgrj@yahoo.com.br",
                    subject: "testing email",
                    onResult: (isOk) => isOk
                        ? _log.finest('email sent')
                        : _log.warning('email not sent')),
                child: const Text('Send test email')),
            const Padding(padding: EdgeInsets.all(10)),
            ElevatedButton(
                onPressed: () =>
                    loggedIn.fetchInbox(onResult: (messages) async {
                      msgIds.addAll(messages);
                      _log.fine('fetched ${messages.length} messages');
                    }, onFinish: () async {
                      _log.fine('finished fetching inbox.');
                    }),
                child: const Text('Fetch Inbox')),
            const Padding(padding: EdgeInsets.all(10)),
            ElevatedButton(
                onPressed: () => loggedIn.fetchMessages(
                    messageIds: msgIds,
                    onResult: (message) async {
                      _log.fine(
                          'fetched message id ${message.extMessageId} - $message');
                    },
                    onFinish: () async {
                      _log.fine('finished fetching messages.');
                    }),
                child: const Text('Fetch Messages'))
          ]))),
    ));
  }
}
