import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bitmaelum_flutter_plugin/bitmaelum_flutter_plugin.dart';

void main() {
  const MethodChannel channel = MethodChannel('bitmaelum_flutter_plugin');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('openVault', () async {
    expect(await BitmaelumClientPlugin.openVault("vault.not.found.file", "password"), 'error opening vault, check your password');
  });
}
