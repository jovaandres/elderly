import 'dart:isolate';

import 'dart:ui';

import 'package:workout_flutter/data/model/medical.dart';
import 'package:workout_flutter/main.dart';
import 'package:workout_flutter/util/notification_helper.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _service;
  static String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._createObject();

  factory BackgroundService() {
    if (_service == null) {
      _service = BackgroundService._createObject();
    }
    return _service as BackgroundService;
  }

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    final NotificationHelper _notificationHelper = NotificationHelper();
    await _notificationHelper.showNotification(
      flutterLocalNotificationsPlugin,
      Medical(),
    );

    _uiSendPort ??=
        IsolateNameServer.lookupPortByName(_isolateName) as SendPort;
    _uiSendPort?.send(null);
  }

  Future<void> someTask() async {
    print('Some Process');
  }
}
