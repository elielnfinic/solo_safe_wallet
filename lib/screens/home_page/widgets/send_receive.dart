import 'package:flutter/material.dart';

class SendReceive extends StatelessWidget {
  final String sendType;

  const SendReceive({super.key, required this.sendType});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              if (sendType == 'online') {
                Navigator.pushNamed(context, '/send_online');
              } else {
                Navigator.pushNamed(context, '/send_offline');
              }
            },
            child: Text('Send', style: TextStyle(color: Colors.black87)),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              if (sendType == 'online') {
                Navigator.pushNamed(context, '/receive_online');
              } else {
                Navigator.pushNamed(context, '/receive_offline');
              }
            },
            child: Text('Receive', style: TextStyle(color: Colors.black87)),
          ),
        ),
      ],
    );
  }
}
