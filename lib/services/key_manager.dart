import 'dart:typed_data';

import 'package:bip39/bip39.dart' as bip39;
import 'package:convert/convert.dart';
import 'package:secure_enclave/secure_enclave.dart';
import 'package:web3dart/web3dart.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SoloSafeSecureEnclaveInterface {
  Future<SecureEnclave> getSecureEnclave();
}

class SoloSafeSecureEnclave implements SoloSafeSecureEnclaveInterface {
  final tag = 'keys';
  final password = 'password';
  SecureEnclave? secureEnclave;

  addEnclaveTag() async {
    secureEnclave ??= SecureEnclave();
    final isSecureEnclaveCreated =
        (await secureEnclave?.isKeyCreated(tag: tag))?.value ?? false;
    if (isSecureEnclaveCreated) {
      return;
    } else {
      final res = await secureEnclave?.generateKeyPair(
          accessControl: AccessControlModel(
              tag: tag,
              password: password,
              options: [
            AccessControlOption.applicationPassword,
            AccessControlOption.privateKeyUsage
          ]));
      if (res?.error != null) {
        throw Exception('Error adding secure enclave tag');
      }
    }
  }

  @override
  Future<SecureEnclave> getSecureEnclave() async {
    await addEnclaveTag();
    return secureEnclave!;
  }

  Future<String> encryptValue(String value) async {
    final secureEnclave = await getSecureEnclave();
    final seEncryptedValue =
        (await secureEnclave.encrypt(message: value, tag: tag)).value;
    if (seEncryptedValue == null) {
      throw Exception(
          'Error encrypting value, unable to encrypt value with secure enclave');
    }
    return hex.encode(seEncryptedValue);
  }

  Future<String> decryptValue(String value) async {
    final secureEnclave = await getSecureEnclave();
    final seEncryptedValue = (await secureEnclave.decrypt(
            message: Uint8List.fromList(hex.decode(value)), tag: tag))
        .value;
    if (seEncryptedValue == null) {
      throw Exception(
          'Error decrypting value, unable to decrypt value with secure enclave');
    }
    return seEncryptedValue;
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
  static String generatePublicKey(String privateKey) {
    final ethPrivateKey = EthPrivateKey.fromHex(privateKey);
    final publicKey = ethPrivateKey.address;
    return publicKey.hex;
  }

  // Save the keys into SharedPreferences
  Future<void> saveKeys(String privateKey, String publicKey) async {
    final solosafeSecureEnclave = SoloSafeSecureEnclave();
    final encryptedKey = await solosafeSecureEnclave.encryptValue(privateKey);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('publicKey', publicKey);
    await prefs.setString('privateKey', encryptedKey);
  }

  // Retrieve saved keys
  static Future<Map<String, String>> getKeys() async {
    final solosafeSecureEnclave = SoloSafeSecureEnclave();

    final prefs = await SharedPreferences.getInstance();
    String? privateKey;
    String? publicKey = prefs.getString('publicKey');

    privateKey = prefs.getString('privateKey');
    privateKey = await solosafeSecureEnclave.decryptValue(privateKey ?? '');

    return {
      'privateKey': privateKey,
      'publicKey': publicKey ?? '',
    };
  }
}
