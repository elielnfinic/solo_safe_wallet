import 'package:flutter/material.dart';
import 'package:solosafe/routes/app_routes.dart';
import 'package:solosafe/screens/home_page/widgets/latest_transactions.dart';
import 'package:solosafe/screens/home_page/widgets/token_list.dart';
import 'package:solosafe/screens/home_page/widgets/wallet.dart';
import 'package:solosafe/services/device_ids.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SoloSafe Wallet'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.settings);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Network Toggle
            // MainnetTestnet(),
            TokenListWidget(tokens: ['USDT', 'STRK', 'ETH', 'BTC']),
            SizedBox(height: 10),
            Wallet(),
            FutureBuilder(
                future: getDeviceId(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text('Device ID: ${snapshot.data}');
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
            SizedBox(height: 30),
            // Tabs for Online and Offline Transactions
            LatestTransactions()
          ],
        ),
      ),
    );
  }
}
