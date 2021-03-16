import 'package:flutter/material.dart';
import 'package:workout_flutter/widget/sign_in_button.dart';

class UserActivity extends StatefulWidget {
  static const routeName = '/activity_page';

  @override
  _UserActivityState createState() => _UserActivityState();
}

class _UserActivityState extends State<UserActivity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Activity'),
      ),
      body: Column(
        children: [
          Text('This is user activity'),
          signInButton(),
        ],
      ),
    );
  }
}
