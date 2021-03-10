import 'package:flutter/material.dart';
import 'package:workout_flutter/data/preferences/preferences_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  final PreferencesHelper preferencesHelper;

  PreferencesProvider({@required this.preferencesHelper}) {
    _getDailyNewsPreferences();
    _getThemePreferences();
    _getLoginPreferences();
  }

  bool _isDailyReminderActive = false;

  bool get isDailyReminderActive => _isDailyReminderActive;

  bool _isDarkTheme = true;

  bool get isDarkTheme => _isDarkTheme;

  bool _isUserLoggedIn = false;

  bool get isUserLoggedIn => _isUserLoggedIn;

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

  void _getLoginPreferences() async {
    _isUserLoggedIn = await preferencesHelper.isUserLoggedIn;
    notifyListeners();
  }

  void readNotice() {
    preferencesHelper.login();
    _getLoginPreferences();
  }
}
