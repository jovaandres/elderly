import 'package:flutter/material.dart';
import 'package:workout_flutter/common/constant.dart';

class UserProfile extends StatefulWidget {
  static const routeName = '/profile_page';

  @override
  State<StatefulWidget> createState() => UserProfileState();
}

class UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Icon(
                  Icons.people,
                  size: 20,
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Text(
                      'Name',
                      style: textStyle,
                    ),
                    Text(
                      'Point',
                      style: textStyle,
                    ),
                    Text(
                      'Weight',
                      style: textStyle,
                    ),
                    Text(
                      'Heoght',
                      style: textStyle,
                    ),
                  ],
                ),
              )
            ],
          ),
          Text(
            'Today:',
            style: textStyle,
          ),
          ListTile(
            title: Text(
              'Activity',
              style: textStyle,
            ),
            subtitle: Text(
              'Description',
              style: textStyle,
            ),
          ),
          ListTile(
            title: Text(
              'Activity',
              style: textStyle,
            ),
            subtitle: Text(
              'Description',
              style: textStyle,
            ),
          ),
        ],
      ),
    );
  }
}
