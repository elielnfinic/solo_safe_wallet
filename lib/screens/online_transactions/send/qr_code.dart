import 'package:flutter/material.dart';

class QRScannerPage extends StatelessWidget {
  const QRScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Scan QR Code')),
      // body: MobileScanner(
      //   // onDetect: (barcode, args) {
      //   //   if (barcode.rawValue != null) {
      //   //     Navigator.pop(context, barcode.rawValue); // Return scanned value
      //   //   }
      //   // },
      // ),
      body: Center(
        child: Text('QR Scanner not available'),
      ),
    );
  }
}
