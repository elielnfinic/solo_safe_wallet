import 'package:flutter_udid/flutter_udid.dart';
import 'package:mobile_device_identifier/mobile_device_identifier.dart';
import 'package:secure_enclave/secure_enclave.dart';

/// This file contains logic for managing device ids
/// The device IDs are core to the security of the offline transactions.

Future<String> getDeviceId() async {
  String mobile_device_id = "";
  final secureEnclave = SecureEnclave();
  try {
    mobile_device_id = await FlutterUdid.consistentUdid;
    // secureEnclave.generateKeyPair(accessControl: AccessControlModel.fromJson())
    await secureEnclave.generateKeyPair(
      accessControl: AccessControlModel(
        password: mobile_device_id,
        options: [
          AccessControlOption.applicationPassword,
          AccessControlOption.privateKeyUsage,
        ],
        tag: 'device_id',
      ),
    );

    final public_id = await secureEnclave.getPublicKey(tag: 'device_id');
    print("Public ID: ${public_id.value}");
  } catch (ex) {
    print("Unable to get device ID");
  }
  return mobile_device_id;
}
