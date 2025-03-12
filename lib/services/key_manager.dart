import 'dart:typed_data';

import 'package:bip39/bip39.dart' as bip39;
import 'package:convert/convert.dart';
import 'package:flutter/material.dart';
import 'package:secure_enclave/secure_enclave.dart';
import 'package:web3dart/web3dart.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SoloSafeSecureEnclaveInterface {
  Future<SecureEnclave> getSecureEnclave();
}

class SoloSafeSecureEnclave implements SoloSafeSecureEnclaveInterface {
  final tag = 'keys';
  final password = 'password';
  var secureEnclave;

  _add_enclave_tag() async {
    if (secureEnclave == null) secureEnclave = SecureEnclave();
    final is_secure_enclave_created =
        (await secureEnclave.isKeyCreated(tag: tag)).value ?? false;
    if (is_secure_enclave_created) {
      return;
    } else {
      final res = await secureEnclave.generateKeyPair(
          accessControl: AccessControlModel(
              tag: tag,
              password: password,
              options: [
            AccessControlOption.applicationPassword,
            AccessControlOption.privateKeyUsage
          ]));
      if (res.error != null) {
        throw Exception('Error adding secure enclave tag');
      }
    }
  }

  Future<SecureEnclave> getSecureEnclave() async {
    await _add_enclave_tag();
    return secureEnclave;
  }

  Future<String> encryptValue(String value) async {
    final _secure_enclave = await getSecureEnclave();
    final _s_e_encrypted_value =
        (await _secure_enclave.encrypt(message: value, tag: tag)).value;
    if (_s_e_encrypted_value == null) {
      throw Exception(
          'Error encrypting value, unable to encrypt value with secure enclave');
    }
    return hex.encode(_s_e_encrypted_value);
  }

  Future<String> decryptValue(String value) async {
    final _secure_enclave = await getSecureEnclave();
    final _s_e_decrypted_value = (await _secure_enclave.decrypt(
            message: Uint8List.fromList(hex.decode(value)), tag: tag))
        .value;
    if (_s_e_decrypted_value == null) {
      throw Exception(
          'Error decrypting value, unable to decrypt value with secure enclave');
    }
    return _s_e_decrypted_value;
  }
}

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

  // Save the keys into SharedPreferences
  Future<void> saveKeys(String privateKey, String publicKey) async {
    final _solosafe_secure_enclave = await SoloSafeSecureEnclave();
    final _encrypted_key =
        await _solosafe_secure_enclave.encryptValue(privateKey);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('publicKey', publicKey);
    await prefs.setString('privateKey', _encrypted_key);
  }

  // Retrieve saved keys
  static Future<Map<String, String>> getKeys() async {
    final _solosafe_secure_enclave = await SoloSafeSecureEnclave();

    final prefs = await SharedPreferences.getInstance();
    String? privateKey;
    String? publicKey = prefs.getString('publicKey');

    privateKey = prefs.getString('privateKey') ?? "";
    privateKey = await _solosafe_secure_enclave.decryptValue(privateKey);

    return {
      'privateKey': privateKey,
      'publicKey': publicKey ?? '',
    };
  }
}
