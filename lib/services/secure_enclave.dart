import 'package:secure_enclave/secure_enclave.dart';

Future<bool> init_enclave(String tag, String password) async{
  final _secure_enclave = SecureEnclave();
  ResultModel res = await _secure_enclave.generateKeyPair(accessControl: AccessControlModel(
      tag: tag,
      password: password, 
      options: [
        AccessControlOption.applicationPassword,
        AccessControlOption.privateKeyUsage
      ]
    )
  );

  

  return true;
}