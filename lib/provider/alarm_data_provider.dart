import 'package:flutter/material.dart';
import 'package:workout_flutter/data/model/alarm.dart';
import 'package:workout_flutter/main.dart';
import 'package:workout_flutter/util/result_state.dart';

class AlarmDataProvider extends ChangeNotifier {
  ResultState? _state;

  ResultState? get state => _state;

  String? _message;

  String? get message => _message;

  List<AlarmData> _alarmData = [];

  List<AlarmData> get alarmData => _alarmData;

  bool _isReminderActive = false;

  bool get isReminderActive => _isReminderActive;

  late AlarmData _getAlrm;

  AlarmData get getAlrm => _getAlrm;

  Future<void> isAlarmScheduled(String docId) async {
    final alarmData = await firestore
        .collection("medicine_bi13rb8")
        .doc(docId)
        .get()
        .then((value) => value.data()?['isScheduled']);
    _isReminderActive = alarmData as bool;
  }

  Future<void> updateSchedule(String docId, bool value) async {
    await firestore
        .collection("medicine_bi13rb8")
        .doc(docId)
        .update({'isScheduled': !_isReminderActive});
  }
}
