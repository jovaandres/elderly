import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_flutter/common/navigation.dart';
import 'package:workout_flutter/data/db/database_helper.dart';
import 'package:workout_flutter/provider/contact_provider.dart';
import 'package:workout_flutter/ui/home_page.dart';
import 'package:workout_flutter/ui/intro_screen.dart';
import 'package:workout_flutter/ui/login_page.dart';
import 'package:workout_flutter/ui/registration_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ContactProvider>(
          create: (_) => ContactProvider(databaseHelper: DatabaseHelper()),
        )
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Workout Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: MyHomePage.routeName,
        routes: {
          IntroScreen.routeName: (context) => IntroScreen(),
          LoginPage.routeName: (context) => LoginPage(),
          RegistrationPage.routeName: (context) => RegistrationPage(),
          MyHomePage.routeName: (context) => MyHomePage(
                title: "This Is Home Page",
              )
        },
      ),
    );
  }
}
