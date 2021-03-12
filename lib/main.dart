import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workout_flutter/common/navigation.dart';
import 'package:workout_flutter/data/api/api_service.dart';
import 'package:workout_flutter/data/preferences/preferences_helper.dart';
import 'package:workout_flutter/provider/detail_hospital_provider.dart';
import 'package:workout_flutter/provider/hospital_data_provider.dart';
import 'package:workout_flutter/provider/preferences_provider.dart';
import 'package:workout_flutter/provider/scheduling_provider.dart';
import 'package:workout_flutter/ui/excercise_detail.dart';
import 'package:workout_flutter/ui/excercise_player.dart';
import 'package:workout_flutter/ui/home_page.dart';
import 'package:workout_flutter/ui/hospital_detail.dart';
import 'package:workout_flutter/ui/intro_screen.dart';
import 'package:workout_flutter/ui/login_page.dart';
import 'package:workout_flutter/ui/medicine_detail.dart';
import 'package:workout_flutter/ui/registration_page.dart';
import 'package:workout_flutter/util/background_service.dart';
import 'package:workout_flutter/util/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

final firestore = FirebaseFirestore.instance;
String path;
final ApiService apiService = ApiService();
final auth = FirebaseAuth.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final Directory directory = await getApplicationDocumentsDirectory();
  path = directory.path;

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
        ChangeNotifierProvider<NearbyHostpitalProvider>(
          create: (_) => NearbyHostpitalProvider(
            apiService: apiService,
          ),
        ),
        ChangeNotifierProvider<DetailHospitalProvider>(
          create: (_) => DetailHospitalProvider(
            apiService: apiService,
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
            title: 'Elderly App',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            initialRoute: (auth.currentUser != null)
                ? MyHomePage.routeName
                : IntroScreen.routeName,
            routes: {
              IntroScreen.routeName: (context) => IntroScreen(),
              LoginPage.routeName: (context) => LoginPage(),
              RegistrationPage.routeName: (context) => RegistrationPage(),
              MyHomePage.routeName: (context) => MyHomePage(
                    title: "This Is Home Page",
                  ),
              MedicineDetail.routeName: (context) => MedicineDetail(
                    medicine: ModalRoute.of(context).settings.arguments,
                  ),
              ExcerciseDetail.routeName: (context) => ExcerciseDetail(),
              ExcercisePlayer.routeName: (context) => ExcercisePlayer(),
              DetailHospital.routeName: (context) => DetailHospital(
                    hospitalId: ModalRoute.of(context).settings.arguments,
                  )
            },
          );
        },
      ),
    );
  }
}
