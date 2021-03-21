import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_flutter/ui/main_page/medicine_page.dart';
import 'package:workout_flutter/ui/main_page/hospital_nearby_page.dart';
import 'package:workout_flutter/ui/main_page/family_contact_page.dart';
import 'package:workout_flutter/ui/main_page/exercise_page.dart';
import 'package:workout_flutter/ui/user_profile.dart';
import 'package:workout_flutter/util/background_service.dart';
import 'package:workout_flutter/util/notification_helper.dart';
import 'package:workout_flutter/widget/platform_widget.dart';

class MyHomePage extends StatefulWidget {
  static const routeName = '/home_page';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _bottomNavIndex = 0;
  late PageController _pageController;

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  List<Widget> _listWidget = [
    HospitalNearbyPage(),
    FamilyContactPage(),
    ExercisePage(),
    UserProfile(),
    MedicinePage(),
  ];

  List<BottomNavigationBarItem> _bottomBarItem = [
    BottomNavigationBarItem(
      icon: Icon(Icons.local_hospital),
      label: 'Hospital',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.contact_phone),
      label: 'Contact',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.explore_rounded),
      label: 'Exercise',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.medical_services),
      label: 'Medicine',
    )
  ];

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        currentIndex: _bottomNavIndex,
        onTap: (index) {
          _pageController.animateToPage(index,
              duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
        },
        items: _bottomBarItem,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (newIndex) {
          setState(() {
            this._bottomNavIndex = newIndex;
          });
        },
        children: _listWidget,
      ),
    );
  }

  Widget _buildIOS(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: _bottomBarItem,
      ),
      tabBuilder: (context, index) {
        return _listWidget[index];
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _bottomNavIndex);
    port.listen((_) async => await _service.someTask());
    _notificationHelper
        .configureSelectNotificationSubject(MyHomePage.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iOSBuilder: _buildIOS,
    );
  }
}
