import 'dart:typed_data';

import 'package:bip39/bip39.dart' as bip39;
import 'package:convert/convert.dart';
import 'package:flutter/material.dart';
import 'package:secure_enclave/secure_enclave.dart';
import 'package:web3dart/web3dart.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class SoloSafeSecureEnclave{
//   final tag = 'keys';
//   final password = 'password';
//   var secureEnclave;

//   _createSecureEnclave() async {
//     secureEnclave = SecureEnclave();
//     final is_secure_enclave_created = await secureEnclave.isKeyCreated(tag: tag) ?? false;
    
//   }

//   getSecureEnclave(){

//     return SecureEnclave();
//   }
// }

class KeyManager {
  // Generate a mnemonic
  static Future<String> generateMnemonic() async {
    return bip39.generateMnemonic();
  }

  // Generate a private key using the mnemonic
  static Future<String> generatePrivateKey(String mnemonic) async {
    var seed = bip39.mnemonicToSeedHex(mnemonic);
    var privateKey = EthPrivateKey.fromHex(seed);
    return privateKey.privateKeyInt.toRadixString(16);
  }

  // Generate a public key from the private key
  static Future<String> generatePublicKey(String privateKey) async {
    var ethPrivateKey = EthPrivateKey.fromHex(privateKey);
    var publicKey = await ethPrivateKey.extractAddress();
    return publicKey.hex;
  }

  static Future<ResultModel> get_sec_enclave() async{
    final _secure_enclave = SecureEnclave();
    final tag = 'keys';
    final password = 'password'; //will prompt the user to input their password 
    final tag_created = (await _secure_enclave.isKeyCreated(tag: tag)).value ?? false;
    ResultModel _secure_enclave_res;
    if(!tag_created){
      _secure_enclave_res = await _secure_enclave.generateKeyPair(
        accessControl: AccessControlModel(
          tag: tag, 
          password: password,
          options: [
            AccessControlOption.applicationPassword,
            AccessControlOption.privateKeyUsage
          ]
        )   
      );
    } else {
      _secure_enclave_res = await _secure_enclave.getPublicKey(tag: tag, password: 'password');
    }
    return _secure_enclave_res;
  }

  // Save the keys into SharedPreferences
  Future<void> saveKeys(String privateKey, String publicKey) async {
    final _secure_enclave = SecureEnclave();
    final tag = 'keys';
    final password = 'password'; //will prompt the user to input their password
    final tag_created = (await _secure_enclave.isKeyCreated(tag: tag)).value ?? false;
    ResultModel _secure_enclave_res;
    if(!tag_created){
      _secure_enclave_res = await _secure_enclave.generateKeyPair(
        accessControl: AccessControlModel(
          tag: tag, 
          password: password,
          options: [
            AccessControlOption.applicationPassword,
            AccessControlOption.privateKeyUsage
          ]
        )   
      );
    } else {
      _secure_enclave_res = await _secure_enclave.getPublicKey(tag: tag, password: 'password');
    }
    
    if(_secure_enclave_res.error != null) {
      print(_secure_enclave_res.error);
      throw Exception('Error saving keys, unable to generate key pair with secure enclave');    
    } else {
      final _s_e_public_key = _secure_enclave_res.value; // _s_e : secure enclave
      
      final _s_e_encrypted_private_key = (await _secure_enclave.encrypt(message: privateKey, tag: tag)).value;
      if(_s_e_encrypted_private_key == null) {
        throw Exception('Error saving keys, unable to encrypt private key with secure enclave');
      }
      final hex_s_e_encrypted_private_key = hex.encode(_s_e_encrypted_private_key);

      final prefs = await SharedPreferences.getInstance();      
      await prefs.setString('publicKey', publicKey);
      await prefs.setString('privateKey', hex_s_e_encrypted_private_key);
    }
    
  }

  // Retrieve saved keys
  static Future<Map<String, String>> getKeys() async {
    final _secure_enclave = SecureEnclave();
    final tag = 'keys';
    final password = 'password'; //will prompt the user to input their password
    final tag_created = (await _secure_enclave.isKeyCreated(tag: tag)).value ?? false;
    ResultModel _secure_enclave_res;
    if(!tag_created){
      _secure_enclave_res = await _secure_enclave.generateKeyPair(
        accessControl: AccessControlModel(
          tag: tag, 
          password: password,
          options: [
            AccessControlOption.applicationPassword,
            AccessControlOption.privateKeyUsage
          ]
        )   
      );
    } else {
      _secure_enclave_res = await _secure_enclave.getPublicKey(tag: tag, password: 'password');
    }

    final prefs = await SharedPreferences.getInstance();
    String? privateKey;
    String? publicKey = prefs.getString('publicKey');

    if(_secure_enclave_res.error != null) {
      print(_secure_enclave_res.error);
      throw Exception('Error getting keys, unable to generate key pair with secure enclave');    
    } else {
      
      privateKey = prefs.getString('privateKey') ?? "";      
      privateKey = (await _secure_enclave.decrypt(message: Uint8List.fromList(hex.decode(privateKey)), tag: tag)).value;
    }

    
    return {
      'privateKey': privateKey ?? '',
      'publicKey': publicKey ?? '',
    };
  }
}
