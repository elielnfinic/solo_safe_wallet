import 'package:flutter/material.dart';
import 'package:solosafe/routes/app_routes.dart';
import 'package:solosafe/start/check_private_key.dart';

class SoloSafe extends StatelessWidget {
  const SoloSafe({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SoloSafe Wallet',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: CheckPrivateKeyExists(),
        routes: AppRoutes.routes);
  }
}
