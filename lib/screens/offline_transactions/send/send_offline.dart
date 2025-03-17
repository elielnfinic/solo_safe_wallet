import 'dart:io';

import 'package:flutter/material.dart';

class SendOfflinePage extends StatefulWidget {
  const SendOfflinePage({super.key});

  @override
  State<SendOfflinePage> createState() => _SendOfflinePageState();
}

class _SendOfflinePageState extends State<SendOfflinePage> {
  String? ipAddress;
  int? port;
  bool isConnecting = false;
  bool isConnected = false;
  Socket? socket;

  @override
  void dispose() {
    _disconnectSocket();
    super.dispose();
  }

  Future<void> _connectToServer(String ip, int port) async {
    setState(() {
      isConnecting = true;
    });

    try {
      socket = await Socket.connect(ip, port, timeout: Duration(seconds: 5));
      if (mounted) {
        setState(() {
          isConnected = true;
          isConnecting = false;
        });
      }
    } catch (e) {
      print('Error connecting to server: $e');
      if (mounted) {
        setState(() {
          isConnecting = false;
          isConnected = false;
        });
      }
    }
  }

  Future<void> _disconnectSocket() async {
    await socket?.close();
    if (mounted) {
      setState(() {
        isConnected = false;
      });
    }
  }

  Future<void> _scanQRCode() async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('QR Code scanning feature is coming soon')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Send Offline'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'WiFi'),
              Tab(text: 'Bluetooth'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // WiFi Tab
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _scanQRCode,
                    child: Text('Scan QR Code'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ManualInputPage(
                            onSubmit: (ip, port) {
                              ipAddress = ip;
                              this.port = port;
                              _connectToServer(ip, port);
                            },
                          ),
                        ),
                      );
                    },
                    child: Text('Enter IP & Port Manually'),
                  ),
                  SizedBox(height: 20),
                  if (isConnecting)
                    CircularProgressIndicator()
                  else if (isConnected) ...[
                    Icon(Icons.check_circle, color: Colors.green, size: 60),
                    SizedBox(height: 20),
                    Text('Connected to server! Ready to send funds.'),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SendAmountPage(
                              socket: socket!,
                            ),
                          ),
                        );
                      },
                      child: Text('Send Money'),
                    ),
                  ] else ...[
                    Text('Not connected'),
                  ],
                ],
              ),
            ),
            // Bluetooth Tab (Placeholder)
            Center(
              child: Text(
                'Bluetooth feature is under development.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
