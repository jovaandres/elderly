import 'package:flutter/material.dart';
import 'package:workout_flutter/data/db/alarm_database.dart';
import 'package:workout_flutter/data/model/alarm.dart';
import 'package:workout_flutter/util/result_state.dart';

class AlarmDataProvider extends ChangeNotifier {
  final AlarmDatabase alarmDatabase;

  AlarmDataProvider({required this.alarmDatabase}) {
    _getAlarmData();
  }

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

  void _getAlarmData() async {
    _state = ResultState.Loading;
    _alarmData = await alarmDatabase.getAllAlarmData() as List<AlarmData>;
    if (_alarmData.length > 0) {
      _state = ResultState.HasData;
    } else {
      _state = ResultState.NoData;
      _message = 'Empty Data';
    }
    notifyListeners();
  }

  Future<void> getAlarmByName(String name) async {
    _state = ResultState.Loading;
    _getAlrm = await alarmDatabase.getAlarmDataByName(name) as AlarmData;
    if (_alarmData.length > 0) {
      _state = ResultState.HasData;
    } else {
      _state = ResultState.NoData;
      _message = 'Empty Data';
    }
    notifyListeners();
  }

  Future<bool> isAlarmExists(String name) async {
    return await alarmDatabase.isAlarmExists(name);
  }

  void addAlarm(AlarmData alarmData) async {
    try {
      await alarmDatabase.insertAlarm(alarmData);
      _getAlarmData();
      notifyListeners();
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error $e';
      notifyListeners();
    }
  }

  void isAlarmScheduled(String name) async {
    final alarmData = await alarmDatabase.getAlarmDataByName(name);
    _isReminderActive = alarmData?.isScheduled == 1;
  }

  void updateAlarm(int value, int id) async {
    await alarmDatabase.updateAlarm(value, id);
  }
}
