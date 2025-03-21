import 'package:flutter/material.dart';

class VerifyMnemoPage extends StatefulWidget {
  const VerifyMnemoPage({super.key});

  @override
  State<VerifyMnemoPage> createState() => _VerifyMnemoPageState();
}

class _VerifyMnemoPageState extends State<VerifyMnemoPage> {

  final Map<int, String> _verificationWords = {};
  final List<int> _positionsToVerify = [];
  final Map<int, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
  }

  

  void _verifyMnemonic() {
    bool isValid = true;

    for (int position in _positionsToVerify) {
      final enteredWord = _controllers[position]?.text.trim();
      final correctWord = _verificationWords[position];

      if (enteredWord != correctWord) {
        isValid = false;
        break;
      }
    }

    if (isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Mnemonic verified successfully!')),
      );
      // Proceed to the next step
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Incorrect mnemonic words. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Crypto Wallet Authentication')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Verify Mnemonic Phrase:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Column(
              children: _positionsToVerify.map((position) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: _controllers[position],
                    decoration: InputDecoration(
                      labelText: 'Enter word #${position + 1}',
                      border: OutlineInputBorder(),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _verifyMnemonic,
              child: Text('Verify Mnemonic'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Proceed to the next step
              },
              child: Text('Proceed'),
            ),
            // Show the mnemonic
          ],
        ),
      ),
    );
  }
}
