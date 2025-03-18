import 'package:flutter/material.dart';
import 'package:solosafe/routes/app_routes.dart';
import 'package:solosafe/screens/home_page/widgets/latest_transactions.dart';
import 'package:solosafe/screens/home_page/widgets/token_list.dart';
import 'package:solosafe/screens/home_page/widgets/wallet.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // To toggle full address display

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
            SizedBox(height: 30),
            // Tabs for Online and Offline Transactions
            LatestTransactions()
          ],
        ),
      ),
    );
  }
}
