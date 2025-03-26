import 'package:flutter_udid/flutter_udid.dart';
import 'package:secure_enclave/secure_enclave.dart';
import 'package:solosafe/providers/password.dart';
import 'package:solosafe/services/key_manager.dart';

/// This file contains logic for managing device ids
/// The device IDs are core to the security of the offline transactions.

Future<String> getDeviceId() async {
  String mobileDeviceId = '';
  final secureEnclave = SecureEnclave();
  try {
    mobileDeviceId =
        await FlutterUdid.consistentUdid + await getEncryptedPrivateKey();

    final tagExists =
        (await secureEnclave.isKeyCreated(tag: getSecureEnclaveDeviceIdTag()))
            .value;
    if (!tagExists!) {
      await secureEnclave.generateKeyPair(
        accessControl: AccessControlModel(
          password: getSecureEnclavePassword(),
          options: [
            AccessControlOption.applicationPassword,
            AccessControlOption.privateKeyUsage,
          ],
          tag: getSecureEnclaveDeviceIdTag(),
        ),
      );
    }

    final publicIdBase64 =
        await secureEnclave.getPublicKey(tag: getSecureEnclaveDeviceIdTag());
    mobileDeviceId = publicIdBase64.value!;
  } catch (ex) {
    throw Exception('Error getting device id: $ex');
  }
  return mobileDeviceId;
}
