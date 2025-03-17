import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class SendAmountPage extends StatefulWidget {
  final Socket socket;

  const SendAmountPage({super.key, required this.socket});

  @override
  State<SendAmountPage> createState() => _SendAmountPageState();
}

class _SendAmountPageState extends State<SendAmountPage> {
  final _amountController = TextEditingController();

  Future<void> _sendAmount() async {
    final amount = _amountController.text;
    final message = '$amount:SEND';
    widget.socket.add(Uint8List.fromList(message.codeUnits));
    print('Amount sent: $amount');

    // Show success dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Transaction Complete'),
        content: Text('Funds sent successfully!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Send Amount')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Enter amount to send:', style: TextStyle(fontSize: 16)),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Amount'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _sendAmount,
              child: Text('Send'),
            ),
          ],
        ),
      ),
    );
  }
}
