import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:workout_flutter/common/constant.dart';
import 'package:workout_flutter/common/navigation.dart';
import 'package:workout_flutter/data/model/activity.dart';
import 'package:workout_flutter/ui/authentication/login_page.dart';
import 'package:workout_flutter/ui/family_role/search_elderly_page.dart';
import 'package:workout_flutter/widget/build_activity_list.dart';
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
        title: Text('Family Activity'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigation.intentNamed(SearchPage.routeName);
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore
            .collection('user_activity_bi13rb8')
            .where('id', isEqualTo: userData?.family)
            .orderBy('time')
            .snapshots(),
        builder: (context, snapshot) {
          print(userData?.toJson());
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            final datas = snapshot.data?.docs as List<QueryDocumentSnapshot>;
            List<Activity> listActivity = [];
            for (var data in datas) {
              final id = data.data()?['id'];
              final activity = data.data()?['activity'];

              final activityData = Activity(
                id: id,
                activity: activity,
              );
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
                        child: buildActivityList(context, listActivity[index]),
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
                          ? "Hello ${userData?.name?.split(" ").first}"
                          : "Hello User!",
                      style: TextStyle(fontSize: 18),
                    ),
                    Center(
                      child: TextButton(
                        child: Text(
                          'Sign Out',
                          style: textStyle.copyWith(color: Colors.white),
                        ),
                        onPressed: () {
                          auth.signOut();
                          Navigation.intentReplace(LoginPage.routeName);
                        },
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
