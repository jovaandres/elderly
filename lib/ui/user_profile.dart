import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:workout_flutter/common/constant.dart';
import 'package:workout_flutter/common/navigation.dart';
import 'package:workout_flutter/data/model/activity.dart';
import 'package:workout_flutter/data/model/notification.dart';
import 'package:workout_flutter/data/model/user_data.dart';
import 'package:workout_flutter/main.dart';
import 'package:workout_flutter/ui/authentication/login_page.dart';
import 'package:workout_flutter/widget/build_activity_list.dart';

class UserProfile extends StatefulWidget {
  static const routeName = '/profile_page';

  @override
  State<StatefulWidget> createState() => UserProfileState();
}

class UserProfileState extends State<UserProfile> {
  final String profileImage = '';
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 22,
                        color: Colors.grey,
                      )
                    ],
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Text(
                          'User Profile',
                          style: textStyle.copyWith(
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Your Progress and Todos',
                          style: textStyle,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: firestore
                    .collection('user_account_bi13rb8')
                    .where('email', isEqualTo: auth.currentUser?.email)
                    .limit(1)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData) {
                    final userDocs =
                        snapshot.data?.docs.first as QueryDocumentSnapshot;
                    final email = userDocs.data()?['email'];
                    final age = userDocs.data()?['age'];
                    final name = userDocs.data()?['name'];
                    final role = userDocs.data()?['role'];
                    final height = userDocs.data()?['height'];
                    final weight = userDocs.data()?['weight'];
                    final family = userDocs.data()?['family'];
                    final point = userDocs.data()?['point'];
                    final docId = userDocs.id;
                    final userDatas = UserData(
                      age: age,
                      email: email,
                      height: height,
                      name: name,
                      weight: weight,
                      role: role,
                      docId: docId,
                      family: family,
                      point: point,
                    );
                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0, 0),
                                        blurRadius: 22,
                                        color: Colors.grey,
                                      )
                                    ],
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: StreamBuilder<String>(
                                      stream: storage
                                          .ref()
                                          .child(
                                              '${auth.currentUser?.email}/profile.jpg')
                                          .getDownloadURL()
                                          .asStream(),
                                      builder: (context, snapshot) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            GestureDetector(
                                              child: Tooltip(
                                                child: Container(
                                                  height: 80,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                      fit: (snapshot.hasData)
                                                          ? BoxFit.cover
                                                          : BoxFit.fill,
                                                      image: NetworkImage(
                                                        snapshot.data ??
                                                            'https://www.searchpng.com/wp-content/uploads/2019/02/Profile-PNG-Icon-715x715.png',
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                message:
                                                    'People vector created by pch.vector - www.freepik.com',
                                              ),
                                              onTap: () async {
                                                await getImage();
                                              },
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              userDatas.name
                                                      ?.split(' ')
                                                      .first ??
                                                  userData?.name
                                                      ?.split(' ')
                                                      .first as String,
                                              style: textStyle,
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0, 0),
                                        blurRadius: 22,
                                        color: Colors.grey,
                                      )
                                    ],
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                  'Height',
                                                  style: textStyle.copyWith(
                                                      fontSize: 18),
                                                ),
                                                SizedBox(height: 4),
                                                Text(
                                                  (userDatas.height ??
                                                          userData?.height
                                                              as String) +
                                                      ' cm',
                                                  style: textStyle.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  'Weight',
                                                  style: textStyle.copyWith(
                                                      fontSize: 18),
                                                ),
                                                SizedBox(height: 4),
                                                Text(
                                                  (userDatas.weight ??
                                                          userData?.weight
                                                              as String) +
                                                      ' kg',
                                                  style: textStyle.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 4),
                                        Divider(color: Colors.blueAccent),
                                        SizedBox(height: 4),
                                        Column(
                                          children: [
                                            Text(
                                              'Point',
                                              style: textStyle.copyWith(
                                                  fontSize: 18),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              '${userDatas.point ?? 0}',
                                              style: textStyle.copyWith(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 36),
                        Text(
                          'Progress:',
                          style: textStyle,
                        ),
                        Expanded(
                          child: StreamBuilder<QuerySnapshot>(
                            stream: firestore
                                .collection('user_activity_bi13rb8')
                                .where('id', isEqualTo: userData?.family)
                                .orderBy('time')
                                .snapshots(),
                            builder: (context, snapshot) {
                              print(userData?.toJson());
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (snapshot.hasData) {
                                final datas = snapshot.data?.docs
                                    as List<QueryDocumentSnapshot>;
                                List<Activity> listActivity = [];
                                for (var data in datas) {
                                  final id = data.data()?['id'];
                                  final activity = data.data()?['activity'];

                                  final activityData =
                                      Activity(id: id, activity: activity);
                                  listActivity.add(activityData);
                                }
                                return AnimationLimiter(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.all(8),
                                    itemCount: listActivity.length,
                                    itemBuilder: (context, index) {
                                      return AnimationConfiguration
                                          .staggeredList(
                                        position: index,
                                        duration:
                                            const Duration(milliseconds: 375),
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
                        ),
                        SizedBox(height: 8),
                        Center(
                          child: StreamBuilder<QuerySnapshot>(
                            stream: firestore
                                .collection('user_notification_bi13rb8')
                                .where('id', isEqualTo: auth.currentUser?.email)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasData) {
                                final List<NotificationModel> notifs = [];
                                final notifications = snapshot.data?.docs
                                    as List<QueryDocumentSnapshot>;
                                for (var notification in notifications) {
                                  final id = notification.data()?['id'];
                                  final name = notification.data()?['name'];
                                  final message =
                                      notification.data()?['message'];
                                  final sender = notification.data()?['sender'];
                                  final docId = notification.id;
                                  final userDocId =
                                      notification.data()?['userDocId'];
                                  notifs.add(NotificationModel(
                                    id: id,
                                    name: name,
                                    message: message,
                                    sender: sender,
                                    docId: docId,
                                    userDocId: userDocId,
                                  ));
                                }
                                return ListView.builder(
                                  itemCount: notifs.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Center(
                                        child: Text(
                                          notifs[index].sender as String,
                                          style: textStyle,
                                        ),
                                      ),
                                      subtitle: Column(
                                        children: [
                                          Text(
                                            '${notifs[index].name} ${notifs[index].message}',
                                            style: textStyle,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              TextButton(
                                                onPressed: () async {
                                                  await firestore
                                                      .collection(
                                                          'user_account_bi13rb8')
                                                      .doc(notifs[index]
                                                          .userDocId)
                                                      .update({
                                                    'family': auth.currentUser
                                                        ?.email as String
                                                  });
                                                  await firestore
                                                      .collection(
                                                          'user_notification_bi13rb8')
                                                      .doc(notifs[index].docId)
                                                      .delete();
                                                },
                                                child: Text(
                                                  'Confirm',
                                                  style: textStyle,
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  await firestore
                                                      .collection(
                                                          'user_notification_bi13rb8')
                                                      .doc(notifs[index].docId)
                                                      .delete();
                                                },
                                                child: Text(
                                                  'Remove',
                                                  style: textStyle,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                );
                              } else if (snapshot.hasError) {
                                return Text(
                                  'Error',
                                  style: textStyle,
                                );
                              } else {
                                return Text('No Data');
                              }
                            },
                          ),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error'),
                    );
                  } else {
                    return Center(
                      child: Text('No Data'),
                    );
                  }
                },
              ),
            ),
            Center(
              child: TextButton(
                child: Text('Sign Out'),
                onPressed: () {
                  auth.signOut();
                  Navigation.intentReplace(LoginPage.routeName);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    if (pickedFile != null) {
      await File(pickedFile.path).copy('$path/profile.jpg');
    }

    setState(() {
      if (pickedFile != null) {
        uploadImageToFirebase();
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadImageToFirebase() async {
    Reference firebaseStorageRef =
        storage.ref().child('${auth.currentUser?.email}/profile.jpg');
    await firebaseStorageRef.putFile(File('$path/profile.jpg'));
  }
}
