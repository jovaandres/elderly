import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:workout_flutter/common/navigation.dart';
import 'package:workout_flutter/data/model/medical.dart';

final selectNotificationSubject = BehaviorSubject<String?>();

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingAndroid =
        AndroidInitializationSettings('app_icon');

    var initializationSettingIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSettings = InitializationSettings(
        android: initializationSettingAndroid, iOS: initializationSettingIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      selectNotificationSubject.add(payload);
    });
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      Medical medical) async {
    var _channelId = '1';
    var _channelName = 'channel_01';
    var _channelDescription = 'restaurant_channel';

    var _remindedMedical = medical.name;

    var androidPlatformChannelSpesifics = AndroidNotificationDetails(
        _channelId, _channelName, _channelDescription,
        importance: Importance.max, priority: Priority.high, ticker: 'ticker');

    var iOSPlatformChannelSpesifics = IOSNotificationDetails();

    var platformChannelSpesifics = NotificationDetails(
        android: androidPlatformChannelSpesifics,
        iOS: iOSPlatformChannelSpesifics);

    var titleNotification = 'Recommended restaurant';
    var titleRestaurant = _remindedMedical;

    await flutterLocalNotificationsPlugin.show(
        0, titleNotification, titleRestaurant, platformChannelSpesifics,
        payload: _remindedMedical);
  }

  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen((String? payload) async {
      Navigation.intentWithData(route, payload as String);
    });
  }
}
