import 'package:flutter/material.dart';

class MainnetTestnet extends StatefulWidget {
  const MainnetTestnet({super.key});

  @override
  State<MainnetTestnet> createState() => _MainnetTestnetState();
}

class _MainnetTestnetState extends State<MainnetTestnet> {
  bool _isTestnet = true; // To toggle between testnet and mainnet

  _toggleNetwork(bool isTestnet) {
    setState(() {
      _isTestnet = isTestnet;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Testnet'),
        Switch(
          value: !_isTestnet,
          onChanged: (value) {
            _toggleNetwork(!value);
          },
        ),
        Text('Mainnet'),
      ],
    );
  }
}
