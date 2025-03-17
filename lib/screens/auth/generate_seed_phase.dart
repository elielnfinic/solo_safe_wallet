import 'package:flutter/material.dart';

class GenerateSeedPhrasePage extends StatelessWidget {
  const GenerateSeedPhrasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate Seed Phrase'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Generate a 12 word seed phrase',
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
