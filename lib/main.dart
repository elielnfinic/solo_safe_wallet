import 'package:flutter/material.dart';
import 'package:solosafe/routes/app_routes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:solosafe/start/check_private_key.dart';

Future main() async {
  await dotenv.load(fileName: '.env');
  runApp(MyApp());
}

class SoloSafe extends StatelessWidget {
  const SoloSafe({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'SoloSafe Wallet',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: CheckPrivateKeyExists(),
        routes: AppRoutes.routes);
  }
}
