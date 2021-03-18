import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:workout_flutter/data/model/medical.dart';
import 'package:workout_flutter/util/background_service.dart';
import 'package:workout_flutter/util/date_time_helper.dart';

class SchedulingProvider extends ChangeNotifier {
  Future<bool> scheduleNotification(
      int id, String time, Medical medical) async {
    notifyListeners();
    print('Start Alarm');
    return await AndroidAlarmManager.periodic(
      Duration(hours: 24),
      id,
      BackgroundService.callback,
      startAt: DateTimeHelper.format(time),
      exact: true,
      wakeup: true,
    );
  }

  Future<bool> cancelNotification(int id) async {
    notifyListeners();
    print('Cancel Alarm');
    return await AndroidAlarmManager.cancel(id);
  }
}
