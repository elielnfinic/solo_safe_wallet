// Generate the code for the StartAuthPage widget. On this page, there will be a svg image for log in and two main buttons saying "Create new wallet" and "Restore wallet"

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:solosafe/routes/app_routes.dart';

class StartAuthPage extends StatelessWidget {
  static const String routeName = '/start_auth';

  const StartAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    const double buttonWidth = 200.0;
    const double buttonHeight = 50.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20),
              Text(
                'Welcome to SoloSafe Wallet!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text('Manage your assets securely offline'),
              Text('SoloSafe uses zk to secure your assets'),
              SizedBox(height: 40),
              // SVG image for log in (replace with your actual asset path)
              SvgPicture.asset(
                'assets/together.svg',
                height: 200,
              ),
              SizedBox(height: 40),
              // Button to create a new wallet
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.createWallet);
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: Size(buttonWidth, buttonHeight),
                ),
                child: Text(
                  'Create new wallet',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.green[800],
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Button to restore an existing wallet
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.restoreWallet);
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: Size(buttonWidth, buttonHeight),
                ),
                child: Text(
                  'Restore your wallet',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
