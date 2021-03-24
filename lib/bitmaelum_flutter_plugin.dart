
import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'dart:convert';

import 'package:bitmaelum_flutter_plugin/bridge/binding_stub.dart'
    if (dart.library.io) 'package:bitmaelum_flutter_plugin/bridge/binding.dart'
    if (dart.library.js) 'package:bitmaelum_flutter_plugin/bridge/binding_stub.dart';

class BitmaelumException implements Exception {
  String cause;
  BitmaelumException(this.cause);
}

class BitmaelumClientPlugin {
  static const MethodChannel _channel =
      const MethodChannel('bitmaelum_flutter_plugin');

  static bool bindingEnabled = Binding().isSupported();

  static Future<Uint8List> _call(String name, Uint8List payload) async {
    if (bindingEnabled) {
      return await Binding().callAsync(name, payload);
    }
    return await _channel.invokeMethod(name, payload);
  }

  static Future<String> _stringResponse(String name, Uint8List payload) async {
    var data = await _call(name, payload);

    String myResponse = new String.fromCharCodes(data);
    var jsonResponse = json.decode(myResponse);
    if (jsonResponse.error != "") {
        throw new BitmaelumException(jsonResponse["error"].toString());
    }

    return jsonResponse["response"].toString();
  }

  static Future<String> openVault (String path, String password) async {
    var myJson = '{"path": "' + path + '", "password": "' + password + '"}';

    return await _stringResponse("openVault", Uint8List.fromList(myJson.codeUnits));
  }

}
