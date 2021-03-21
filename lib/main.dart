import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workout_flutter/common/navigation.dart';
import 'package:workout_flutter/data/api/api_service.dart';
import 'package:workout_flutter/data/db/database_helper.dart';
import 'package:workout_flutter/data/model/excercise.dart';
import 'package:workout_flutter/data/model/medical.dart';
import 'package:workout_flutter/data/model/user_data.dart';
import 'package:workout_flutter/data/preferences/preferences_helper.dart';
import 'package:workout_flutter/provider/alarm_data_provider.dart';
import 'package:workout_flutter/provider/contact_provider.dart';
import 'package:workout_flutter/provider/detail_hospital_provider.dart';
import 'package:workout_flutter/provider/hospital_data_provider.dart';
import 'package:workout_flutter/provider/preferences_provider.dart';
import 'package:workout_flutter/provider/scheduling_provider.dart';
import 'package:workout_flutter/provider/search_user_provider.dart';
import 'package:workout_flutter/ui/contact_picker.dart';
import 'package:workout_flutter/ui/excercise_detail.dart';
import 'package:workout_flutter/ui/excercise_player.dart';
import 'package:workout_flutter/ui/home_page.dart';
import 'package:workout_flutter/ui/hospital_detail.dart';
import 'package:workout_flutter/ui/intro_screen.dart';
import 'package:workout_flutter/ui/login_page.dart';
import 'package:workout_flutter/ui/medicine_detail.dart';
import 'package:workout_flutter/ui/registration_page.dart';
import 'package:workout_flutter/ui/role_page.dart';
import 'package:workout_flutter/ui/search_elderly_page.dart';
import 'package:workout_flutter/ui/user_activity.dart';
import 'package:workout_flutter/ui/user_profile.dart';
import 'package:workout_flutter/util/background_service.dart';
import 'package:workout_flutter/util/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

final firestore = FirebaseFirestore.instance;
String? path;
final ApiService apiService = ApiService();
final auth = FirebaseAuth.instance;
final storage = FirebaseStorage.instance;
final databaseHelper = DatabaseHelper();
UserData? userData;

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

  if (auth.currentUser != null) {
    userData =
        await databaseHelper.getUserData(auth.currentUser?.email as String);
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
          create: (_) => ContactProvider(),
        ),
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
        ),
        ChangeNotifierProvider<AlarmDataProvider>(
          create: (_) => AlarmDataProvider(),
        ),
        ChangeNotifierProvider<SearchUserProvider>(
          create: (_) => SearchUserProvider(),
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
                ? (userData?.role == 'elderly')
                    ? MyHomePage.routeName
                    : UserActivity.routeName
                : IntroScreen.routeName,
            routes: {
              RolePage.routeName: (context) => RolePage(),
              IntroScreen.routeName: (context) => IntroScreen(),
              LoginPage.routeName: (context) => LoginPage(),
              RegistrationPage.routeName: (context) => RegistrationPage(
                    role: ModalRoute.of(context)?.settings.arguments as String,
                  ),
              MyHomePage.routeName: (context) => MyHomePage(),
              UserActivity.routeName: (context) => UserActivity(),
              ContactPicker.routeName: (context) => ContactPicker(),
              SearchPage.routeName: (context) => SearchPage(),
              UserProfile.routeName: (context) => UserProfile(),
              MedicineDetail.routeName: (context) => MedicineDetail(
                    medicine:
                        ModalRoute.of(context)?.settings.arguments as Medical,
                  ),
              ExcerciseDetail.routeName: (context) => ExcerciseDetail(
                    exercise:
                        ModalRoute.of(context)?.settings.arguments as Exercise,
                  ),
              ExcercisePlayer.routeName: (context) => ExcercisePlayer(
                    link: ModalRoute.of(context)?.settings.arguments as String,
                  ),
              DetailHospital.routeName: (context) => DetailHospital(
                    hospitalId:
                        ModalRoute.of(context)?.settings.arguments as String,
                  ),
            },
          );
        },
      ),
    );
  }
}
