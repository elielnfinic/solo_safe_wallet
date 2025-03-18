import 'package:flutter/material.dart';

class GenerateAddressPage extends StatelessWidget {
  const GenerateAddressPage({super.key});

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
