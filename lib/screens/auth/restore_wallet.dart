import 'package:flutter/material.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:solosafe/screens/home_page/home_page.dart';
import 'package:solosafe/services/key_manager.dart';

class RestoreWalletPage extends StatefulWidget {
  const RestoreWalletPage({super.key});

  @override
  State<RestoreWalletPage> createState() => _RestoreWalletPageState();
}

class _RestoreWalletPageState extends State<RestoreWalletPage> {
  final _mnemonicController = TextEditingController();
  String? _privateKey;
  String? _publicKey;
  bool _isRestoring = false;

  // Function to restore wallet from mnemonic
  void _restoreWallet() async {
    final mnemonic = _mnemonicController.text.trim();

    if (bip39.validateMnemonic(mnemonic)) {
      await generateSoloSafeKeys(mnemonic: mnemonic);
      // Navigate to HomePage
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    } else {
      setState(() {
        _privateKey = 'Invalid Mnemonic!';
        _isRestoring = false;
      });
    }
  }

  @override
  void dispose() {
    _mnemonicController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restore Wallet'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Enter your 12/24-word mnemonic:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _mnemonicController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter mnemonic here',
              ),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            _isRestoring
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _restoreWallet,
                    child: Text(
                      'Restore Wallet',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
            SizedBox(height: 20),
            if (_privateKey != null && _publicKey != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectableText(
                    _privateKey!,
                    style: TextStyle(fontSize: 16, color: Colors.blueGrey),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Public Key:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  SelectableText(
                    _publicKey!,
                    style: TextStyle(fontSize: 16, color: Colors.blueGrey),
                  ),
                ],
              )
            else if (_privateKey == 'Invalid Mnemonic!')
              Text(
                'Invalid Mnemonic! Please try again.',
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(
      home: RestoreWalletPage(),
    ));
