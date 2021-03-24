import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:workout_flutter/common/constant.dart';
import 'package:workout_flutter/data/model/user_data.dart';
import 'package:workout_flutter/main.dart';

class UserProfile extends StatefulWidget {
  static const routeName = '/profile_page';

  @override
  State<StatefulWidget> createState() => UserProfileState();
}

class UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('User Profile'),
      // ),
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
              flex: 1,
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
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          height: 80,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSWuzX8xbUWWDaFoTE8M258wuLVD7OsCQQuWfDzklDRxQThbhft1YGYIvvs4JsZqMcJ-0k&usqp=CAU",
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          userDatas.name ?? 'Name',
                                          style: textStyle,
                                        ),
                                      ],
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
                                                  (userDatas.height ?? '0') +
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
                                                  (userDatas.weight ?? '0') +
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
                              width: MediaQuery.of(context).size.width * 0.95,
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  children: [
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
                              ),
                            ),
                          ),
                        ),
                        Center(
                            child: TextButton(
                          child: Text('Sign Out'),
                          onPressed: () {
                            auth.signOut();
                          },
                        ))
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
            )
          ],
        ),
      ),
    );
  }
}
