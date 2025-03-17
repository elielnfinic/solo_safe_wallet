// this class should generate a 12 word seed phrase. Import the necessary library and generate the seed phrase
// it should also generate a public and private key pair. Import the necessary library and generate the key pair
// the address should be compatible with Ethereum and Bitcoin. The address should be generated from the public key

import 'package:flutter/material.dart';
import 'package:solosafe/generate_key_pair.dart';
import 'package:solosafe/generate_seed_phase.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Authentication'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to your Authentication Page!',
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const GenerateSeedPhrasePage()),
                );
              },
              child: const Text('Generate Seed Phrase'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const GenerateKeyPairPage()),
                );
              },
              child: const Text('Generate Key Pair'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const GenerateAddressPage()),
                );
              },
              child: const Text('Generate Address'),
            ),
          ],
        ),
      ),
    );
  }
}

class GenerateAddressPage extends StatelessWidget {
  const GenerateAddressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate Address'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Generate an address compatible with Ethereum and Bitcoin',
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
