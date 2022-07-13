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
  static const String _redirectUri = "com.mytiki.app://oauth/";
  static const String _clientId = "6e52a878-7251-4669-8e42-70655255a263";
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) =>
        print('${record.level.name} [${record.loggerName}] ${record.message}'));
    TikiStrategyMicrosoft notLoggedIn = TikiStrategyMicrosoft(
        onLink: (model) => _log.finest(model),
        onUnlink: (email) => _log.finest(email),
        redirectUri: _redirectUri,
        clientId: _clientId);

    TikiStrategyMicrosoft loggedIn = TikiStrategyMicrosoft.loggedIn(
        displayName: "Test",
        email: "reallylongemailtooverflow@gmail.com",
        token: "EwCIA8l6BAAUkj1NuJYtTVha+Mogk+HEiPbQo04AASb5sQLuLi4L/DsPuck1GTtnD068R9cbCKPxG117oDgc4n3jXimSUXVmUZ2+XJWaJVUgEKUdPCU+fgsjGW6QF1YxIPbjAl1k738N8LwXvbE01s5lXW9GaHWuLs+5JQahZUOCxfOwsoWtQe0oljU5hTvF3ZOQ2dHSDvRJ7ypthmHw0/V3CNgv4AAqZJF0gxR5qe2Ij2iAGg+pudT7SVeYgQssbNzSsJgX3sAyRNWSIvLhCfatuhy16YE/4sVuy68ux+mTGfBLqR77BsFFKhNnAWuHiFZYnYhiGPDJ39+QTP99qP/kXY+nW0LSA/fSrlqy2vcWCQCVLX6l+f7WxdURM1gDZgAACPwu0l+rW0rAWAKBmqgHQFspuM5eUOLgaBhrX3t7GfDX5nptq0oNRrfl4sRReFzK5w6YvZ5Ul0X4g8tpdlIukwEifpts4Zc7RoGMlmzyIxvZJl+PTpYZvMkdioN/zU3ejn7aGw6Dr7ZGE8PZyvH8JrDDKEA7BH9fjw41uq9M0DsfPtLXGJpg3uzKiTqaBYHUpIj+s/qz30OtDe8DDay1EgCdHEMmEn9KX13evHzNL8M1ykq6r0+8R2XSgiep/FDRw7f0xcLGzJ0HADYONc8PhEwxq2XTEc3vj49l/zOsMz6GWJehvubXK+DcLR/LstGwtyaWaID7E+0GV/HiQLyNFzjpQvFCk/6liXGO4AMPH4MBzklaT2KmJ8/6Td7mM4hlAI0ZeFXLCubmZAOfGYkxuDV9aPvRSGeAdcHMqi/irB8sEik+4W/T8dPoZoe4ZHVE8qUP1sZqG3pNl1bTbYYBfRKHtV/+AsgycV6rfCCvgsIERvfkZng8VgTMI9MP3Z6ZltwXABzHEgCMJJHFrI6p/fZ+v1DUAoePd1pQAJ1XYG7Udwic5wN6AYFd2y8fv1aDSsSYDhGGk+QusPR43y5WtTK3U1GaGah+K5jXwD9UB/+b3ljNWwMIpbOf/XFeP4EhOaq7aUIwkUvtdqUXTr2b4ZVYKA4eTIlY2e3WxyxvYa/7/P1QyTcnCQaxwKq7VhGJmuDjrS//fZNPEJmm7fYHsteHR9JE0cCJqYqGaUtp4PZzoOFgXcZaKzCRRdKYZ9eZo4rAdpOhks1itl9VZWyOHxvKv+DlbXuI/TeDl1dp7MCSQUygAg==",
        refreshToken: "def",
        redirectUri: 'test',
        clientId: 'test');

    _log.info("Building strat");

    loggedIn.countInbox(onResult: (val) => {
      _log.info("Found ${val} emails")
    }, onFinish: () => {
      _log.info("Finished count")
    });


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
                onPressed: () => notLoggedIn.sendEmail(
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
                    notLoggedIn.fetchInbox(onResult: (messages, {page}) async {
                      msgIds.addAll(messages);
                      _log.fine('fetched ${messages.length} messages');
                      _log.fine('lastPage $page');
                    }, onFinish: () async {
                      _log.fine('finished fetching inbox.');
                    }),
                child: const Text('Fetch Inbox')),
            const Padding(padding: EdgeInsets.all(10)),
            ElevatedButton(
                onPressed: () => notLoggedIn.fetchMessages(
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
