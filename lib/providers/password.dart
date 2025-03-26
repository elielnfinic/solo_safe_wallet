// a static provider that provide a dummy password

final _secureEnclavePassword = 'password';
final _secureEnclaveDeviceIdTag = 'device_id';
final _secureEnclaveKeyTag = 'user_key'; //Used to store the user's private key and public key

// password getter 
String getSecureEnclavePassword() {
  return _secureEnclavePassword;
}

// device id tag getter
String getSecureEnclaveDeviceIdTag() {
  return _secureEnclaveDeviceIdTag;
}

// user key tag getter
String getSecureEnclaveKeyTag() {
  return _secureEnclaveKeyTag;
}