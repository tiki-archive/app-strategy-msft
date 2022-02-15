import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:microsoft_provider/microsoft_provider.dart';

void main() {
  const MethodChannel channel = MethodChannel('microsoft_provider');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

}
