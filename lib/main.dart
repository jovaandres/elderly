import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workout_flutter/common/navigation.dart';
import 'package:workout_flutter/data/db/database_helper.dart';
import 'package:workout_flutter/data/preferences/preferences_helper.dart';
import 'package:workout_flutter/provider/contact_provider.dart';
import 'package:workout_flutter/provider/preferences_provider.dart';
import 'package:workout_flutter/provider/scheduling_provider.dart';
import 'package:workout_flutter/ui/home_page.dart';
import 'package:workout_flutter/ui/intro_screen.dart';
import 'package:workout_flutter/ui/login_page.dart';
import 'package:workout_flutter/ui/registration_page.dart';
import 'package:workout_flutter/util/background_service.dart';
import 'package:workout_flutter/util/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotification(flutterLocalNotificationsPlugin);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ContactProvider>(
          create: (_) => ContactProvider(
            databaseHelper: DatabaseHelper(),
          ),
        ),
        ChangeNotifierProvider<PreferencesProvider>(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider<SchedulingProvider>(
          create: (_) => SchedulingProvider(),
        )
      ],
      child: Consumer<PreferencesProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            title: 'Workout Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            initialRoute: (!provider.isUserLoggedIn)
                ? MyHomePage.routeName
                : IntroScreen.routeName,
            routes: {
              IntroScreen.routeName: (context) => IntroScreen(),
              LoginPage.routeName: (context) => LoginPage(),
              RegistrationPage.routeName: (context) => RegistrationPage(),
              MyHomePage.routeName: (context) => MyHomePage(
                    title: "This Is Home Page",
                  )
            },
          );
        },
      ),
    );
  }
}
