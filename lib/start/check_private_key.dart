import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solosafe/screens/auth/start_auth.dart';
import 'package:solosafe/screens/home_page/home_page.dart';

class CheckPrivateKeyExists extends StatefulWidget {
  const CheckPrivateKeyExists({super.key});

  @override
  State<CheckPrivateKeyExists> createState() => _CheckPrivateKeyExistsState();
}

class _CheckPrivateKeyExistsState extends State<CheckPrivateKeyExists> {
  @override
  void initState() {
    super.initState();
    checkForMnemonic();
  }

  Future<void> checkForMnemonic() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? prKey = prefs.getString('private_key');

    // Navigate based on the presence of mnemonic
    if (mounted) {
      if (prKey != null && prKey.isNotEmpty) {
        // If mnemonic exists, go to HomePage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        // Otherwise, go to AuthPage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => StartAuthPage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ), // Loading indicator while checking
    );
  }
}
