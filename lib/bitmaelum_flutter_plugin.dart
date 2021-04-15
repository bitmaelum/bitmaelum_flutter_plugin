
import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'dart:convert';

import 'package:bitmaelum_flutter_plugin/bridge/binding_stub.dart'
    if (dart.library.io) 'package:bitmaelum_flutter_plugin/bridge/binding.dart'
    if (dart.library.js) 'package:bitmaelum_flutter_plugin/bridge/binding_stub.dart';

import 'messages.dart';

class BitmaelumException implements Exception {
  String cause;
  BitmaelumException(this.cause);
}

class BitmaelumClientPlugin {
  static const MethodChannel _channel = const MethodChannel('bitmaelum_flutter_plugin');
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
    if (jsonResponse["error"] != null) {
        throw new BitmaelumException(jsonResponse["error"]);
    }

    return jsonResponse["response"];
  }

  static Future<Object> _jsonResponse(String name, Uint8List payload) async {
    var data = await _call(name, payload);
    
    String myResponse = new String.fromCharCodes(data);
    var jsonResponse = json.decode(myResponse);
    if (jsonResponse["error"] != null) {
        throw new BitmaelumException(jsonResponse["error"]);
    }

    return jsonResponse["response"];
  }

  static Future<List<int>> _byteResponse(String name, Uint8List payload) async {
    var data = await _call(name, payload);
    
    String myResponse = new String.fromCharCodes(data);
    var jsonResponse = json.decode(myResponse);
    if (jsonResponse["error"] != null) {
        throw new BitmaelumException(jsonResponse["error"]);
    }

    return base64.decode(jsonResponse["response"]);
  }

  static Future<Object> openVault (String path, String password) async {
    var myJson = {
                'path':path,
                'password':password,
                }; 

    return await _jsonResponse("openVault", Uint8List.fromList(json.encode(myJson).codeUnits));
  }

  static Future<Object> setClientFromVault (String account) async {
    var myJson = {
                'account':account,
                }; 
                
    return await _jsonResponse("setClientFromVault", Uint8List.fromList(json.encode(myJson).codeUnits));
  }

  static Future<Object> setClientFromMnemonic (String account, String name, String mnemonic) async {
    var myJson = {
                'account':account,
                'name':name,
                'mnemonic':mnemonic
                }; 

    return await _jsonResponse("setClientFromMnemonic", Uint8List.fromList(json.encode(myJson).codeUnits));
  }

  static Future<Object> setClientFromPrivateKey (String account, String name, String private_key) async {
    var myJson = {
                'account':account,
                'name':name,
                'private_key':private_key
                }; 

    return await _jsonResponse("setClientFromPrivateKey", Uint8List.fromList(json.encode(myJson).codeUnits));
  }

  static Future<Object> sendSimpleMessage (String recipient, String subject, String body) async {
    var myJson = {
                'recipient':recipient,
                'subject':subject,
                'body':body
                }; 

    return await _jsonResponse("sendSimpleMessage", Uint8List.fromList(json.encode(myJson).codeUnits));
  }

  static Future<Object> sendMessage (String recipient, String subject, Map blocks, List attachments ) async {
    var myJson = {
                  'recipient':recipient,
                  'subject':subject,
                  'blocks':blocks,
                  'attachments':attachments
                  }; 

    return await _jsonResponse("sendMessage", Uint8List.fromList(json.encode(myJson).codeUnits));
  }

  static Future<List<MessageItem>> listMessages (DateTime since, int boxID ) async {
    var myJson = {
                  'since':since.toIso8601String(),
                  'box':boxID
                  }; 
    
    var response = await _jsonResponse("listMessages", Uint8List.fromList(json.encode(myJson).codeUnits));
    Iterable l = response as Iterable;
    return List<MessageItem>.from(l.map((m)=> MessageItem.fromJson(m)));
  }

  static Future<List<int>> readBlock (String msgID, String blockID ) async {
    var myJson = {
                  'msgid':msgID,
                  'blockid':blockID
                  }; 

    return await _byteResponse("readBlock", Uint8List.fromList(json.encode(myJson).codeUnits));
  }

  static Future<Object> saveAttachment (String msgID, String attachmentID, String path, bool overwrite) async {
    var myJson = {
                  'msgid':msgID,
                  'attachmentid':attachmentID,
                  'path':path,
                  'overwrite':overwrite
                  }; 

    return await _jsonResponse("saveAttachment", Uint8List.fromList(json.encode(myJson).codeUnits));
  }
}
