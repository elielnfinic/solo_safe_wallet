import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:solosafe/start/solosafe.dart';

Future main() async {
  await dotenv.load(fileName: '.env');
  runApp(SoloSafe());
}
