import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:workout_flutter/data/model/activity.dart';
import 'package:workout_flutter/widget/build_activity_list.dart';
import 'package:workout_flutter/widget/menu_tile.dart';
import 'package:workout_flutter/widget/sign_in_button.dart';
import 'package:workout_flutter/main.dart';

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: firestore
                    .collection('user_activity_bi13rb8')
                    .where('id', isEqualTo: 'jovaandrea8721@gmail.com')
                    .orderBy('time')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData) {
                    final datas = snapshot.data.docs;
                    List<Activity> listActivity = [];
                    for (var data in datas) {
                      final id = data.data()['id'];
                      final activity = data.data()['activity'];

                      final activityData = Activity(id: id, activity: activity);
                      listActivity.add(activityData);
                    }
                    return AnimationLimiter(
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(8),
                        itemCount: listActivity.length,
                        itemBuilder: (context, index) {
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                child: buildActivityList(
                                    context, listActivity[index]),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text(''));
                  } else {
                    return Center(child: Text(''));
                  }
                },
              ),
            )
          ],
        ),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      (auth.currentUser != null)
                          ? "Hello ${auth.currentUser.email}"
                          : "Hello User!",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      width: 120,
                      height: 38,
                      child: signInButton(),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              MenuTile(title: 'Item 1'),
              MenuTile(title: 'Item 2'),
              MenuTile(title: 'Item 3'),
              MenuTile(title: 'Item 4'),
              MenuTile(title: 'Item 5'),
            ],
          ),
        ),
      ),
    );
  }
}
