import 'package:flutter/material.dart';

class GenerateKeyPairPage extends StatelessWidget {
  const GenerateKeyPairPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate Key Pair'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Generate a public and private key pair',
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Go back to Authentication'),
            ),
          ],
        ),
      ),
    );
  }
}
