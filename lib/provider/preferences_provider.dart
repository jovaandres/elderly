import 'package:flutter/material.dart';
import 'package:workout_flutter/data/model/user_data.dart';
import 'package:workout_flutter/data/preferences/preferences_helper.dart';
import 'package:workout_flutter/main.dart';
import 'package:workout_flutter/util/result_state.dart';

class PreferencesProvider extends ChangeNotifier {
  final PreferencesHelper preferencesHelper;

  PreferencesProvider({@required this.preferencesHelper}) {
    _getDailyNewsPreferences();
    _getThemePreferences();
    fetchUserData();
  }
  UserData _userData;
  String _message;
  ResultState _state;

  UserData get userData => _userData;

  String get message => _message;

  ResultState get state => _state;

  bool _isDailyReminderActive = false;

  bool get isDailyReminderActive => _isDailyReminderActive;

  bool _isDarkTheme = true;

  bool get isDarkTheme => _isDarkTheme;

  void _getDailyNewsPreferences() async {
    _isDailyReminderActive = await preferencesHelper.isDailyReminderActive;
    notifyListeners();
  }

  void enableDailyReminder(bool value) {
    preferencesHelper.setDailyReminder(value);
    _getDailyNewsPreferences();
  }

  void _getThemePreferences() async {
    _isDarkTheme = await preferencesHelper.isDarkTheme;
    notifyListeners();
  }

  void enableDarkTheme(bool value) {
    preferencesHelper.setDarkTheme(value);
    _getThemePreferences();
  }

  Future<dynamic> fetchUserData() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      firestore
          .collection('user_account_bi13rb8')
          .where('email', isEqualTo: auth.currentUser.email)
          .limit(1)
          .snapshots()
          .listen((querySnapshot) {
        final data = querySnapshot.docs.first;
        final age = data.data()['age'];
        final email = data.data()['email'];
        final height = data.data()['height'];
        final name = data.data()['name'];
        final role = data.data()['role'];
        final weight = data.data()['weight'];
        _userData = UserData(
            age: age,
            email: email,
            height: height,
            name: name,
            role: role,
            weight: weight);
      });
      _state = ResultState.HasData;
      notifyListeners();
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error->>$e';
    }
  }
}
