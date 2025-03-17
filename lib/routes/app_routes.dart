import 'package:flutter/material.dart';
import 'package:solosafe/screens/offline_transactions/receive/receive_offline.dart';
import 'package:solosafe/screens/offline_transactions/send/send_offline.dart';
import 'package:solosafe/screens/online_transactions/receive/receive_online.dart';
import 'package:solosafe/screens/online_transactions/send/send_online.dart';
import 'package:solosafe/screens/settings/settings_page.dart';
import 'package:solosafe/screens/sync/download_asset.dart';
import 'package:solosafe/screens/sync/upload_asset.dart';
import '../screens/auth/auth.dart';

class AppRoutes {
  static const String startAuth = '/start_auth';
  static const String createWallet = '/create_wallet';
  static const String restoreWallet = '/restore_wallet';
  static const String settings = '/settings';
  static const String receiveOnline = '/receive_online';
  static const String sendOnline = '/send_online';
  static const String receiveOffline = '/receive_offline';
  static const String sendOffline = '/send_offline';
  static const String sendMessagePage = '/send_message_page';
  static const String downloadAssets = '/download_assets';
  static const String uploadAssets = '/upload_assets';

  static Map<String, WidgetBuilder> routes = {
    startAuth: (context) => StartAuthPage(),
    createWallet: (context) => CreateWalletPage(),
    restoreWallet: (context) => RestoreWalletPage(),
    settings: (context) => SettingsPage(),
    receiveOnline: (context) => ReceiveCryptoPage(),
    sendOnline: (context) => SendOnlinePage(),
    receiveOffline: (context) => ReceiveOfflinePage(),
    sendOffline: (context) => SendOfflinePage(),
    downloadAssets: (context) => DownloadAssetPage(),
    uploadAssets: (context) => UploadAssetPage()
  };
}
