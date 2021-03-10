import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:workout_flutter/common/navigation.dart';
import 'package:workout_flutter/ui/home_page.dart';
import 'package:workout_flutter/ui/intro_screen.dart';
import 'package:workout_flutter/ui/login_page.dart';
import 'package:workout_flutter/ui/registration_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Workout Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: IntroScreen.routeName,
      routes: {
        IntroScreen.routeName: (context) => IntroScreen(),
        LoginPage.routeName: (context) => LoginPage(),
        RegistrationPage.routeName: (context) => RegistrationPage(),
        MyHomePage.routeName: (context) => MyHomePage(
              title: "This Is Home Page",
            )
      },
    );
  }
}
