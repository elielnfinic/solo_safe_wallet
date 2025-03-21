import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:starknet/starknet.dart';
import 'package:wallet_kit/wallet_kit.dart';
import 'package:starknet_provider/starknet_provider.dart' as sp;

Future<double> getStrkAccountBalance(String accountAddress) async {
  final starknetProvider = sp.JsonRpcProvider(nodeUri: Uri.parse(dotenv.env['STRK_RPC_SERVER'] as String));
  final balance = getStrkBalance(provider: starknetProvider, accountAddress: Felt.fromHexString(accountAddress));
  return balance;
}