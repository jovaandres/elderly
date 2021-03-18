import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_flutter/ui/fifth_page.dart';
import 'package:workout_flutter/ui/first_page.dart';
import 'package:workout_flutter/ui/fourth_page.dart';
import 'package:workout_flutter/ui/second_page.dart';
import 'package:workout_flutter/ui/third_page.dart';
import 'package:workout_flutter/widget/platform_widget.dart';

class MyHomePage extends StatefulWidget {
  static const routeName = '/home_page';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _bottomNavIndex = 0;
  late PageController _pageController;

  List<Widget> _listWidget = [
    FirstPage(),
    SecondPage(),
    ThirdPage(),
    FourthPage(),
    FifthPage(),
  ];

  List<BottomNavigationBarItem> _bottomBarItem = [
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.house_fill), label: 'First'),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.heart_fill), label: 'Second'),
    BottomNavigationBarItem(
        icon: Icon(Platform.isIOS ? CupertinoIcons.settings : Icons.settings),
        label: 'Third'),
    BottomNavigationBarItem(
        icon: Icon(Icons.medical_services), label: 'Fourth'),
    BottomNavigationBarItem(icon: Icon(Icons.album), label: 'Fith')
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
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iOSBuilder: _buildIOS,
    );
  }
}
