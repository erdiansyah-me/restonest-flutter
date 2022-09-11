import 'dart:isolate';
import 'dart:ui';
import 'package:restonest/data/notification/notif_helper.dart';
import 'package:restonest/main.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    print('alarm launch');
    final NotifHelper notifHelper = NotifHelper();
    await notifHelper.showNotif(flutterLocalNotificationsPlugin);
    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}