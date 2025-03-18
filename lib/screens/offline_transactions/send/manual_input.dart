import 'package:flutter/material.dart';

class ManualInputPage extends StatefulWidget {
  final Function(String ip, int port) onSubmit;

  const ManualInputPage({super.key, required this.onSubmit});

  @override
  State<ManualInputPage> createState() => _ManualInputPageState();
}

class _ManualInputPageState extends State<ManualInputPage> {
  final _ipController = TextEditingController();
  final _portController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enter IP & Port')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _ipController,
              decoration: InputDecoration(labelText: 'IP Address'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _portController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Port'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final ip = _ipController.text;
                final port = int.tryParse(_portController.text) ?? 0;
                widget.onSubmit(ip, port);
                Navigator.pop(context);
              },
              child: Text('Connect'),
            ),
          ],
        ),
      ),
    );
  }
}
