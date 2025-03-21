import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:solosafe/start/solosafe.dart';
import 'package:wallet_kit/wallet_kit.dart';

Future main() async {
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();
  await WalletKit().init(
    accountClassHash: dotenv.env['OZ_STARKNET_ACCOUNT_CLASSHASH'] as String,
    rpc: dotenv.env['STRK_RPC_SERVER'] as String,
  );
  // await getSecureStore(type: );
  await Hive.initFlutter();
  runApp(ProviderScope(child:SoloSafe()));

}
