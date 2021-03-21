import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:workout_flutter/common/constant.dart';
import 'package:workout_flutter/common/navigation.dart';
import 'package:workout_flutter/data/model/family_number.dart';
import 'package:workout_flutter/main.dart';
import 'package:workout_flutter/ui/contact_picker.dart';
import 'package:workout_flutter/util/cryptojs_aes_encryption_helper.dart';
import 'package:workout_flutter/widget/build_contact_list.dart';

class FamilyContactPage extends StatefulWidget {
  static const routeName = '/family_contact_page';

  @override
  _FamilyContactPageState createState() => _FamilyContactPageState();
}

class _FamilyContactPageState extends State<FamilyContactPage> {
  Iterable<Contact> contacts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second"),
      ),
      body: _buildList(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        splashColor: Colors.blueAccent,
        onPressed: () {
          Navigation.intentNamed(ContactPicker.routeName);
        },
        tooltip: 'Add Contact',
        child: Icon(
          Icons.add_ic_call,
          color: Colors.blueAccent,
        ),
      ),
    );
  }

  Widget _buildList() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        Center(
          child: Text(
            'Family Contact',
            style: textStyle.copyWith(fontSize: 18),
          ),
        ),
        Expanded(
          flex: 1,
          child: StreamBuilder<QuerySnapshot>(
            stream: firestore
                .collection('family_contact_bi13rb8')
                .where('id', isEqualTo: auth.currentUser?.email)
                .orderBy('name')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                final contacts =
                    snapshot.data?.docs as List<QueryDocumentSnapshot>;
                List<FamilyNumber> familyNumbers = [];
                for (var contact in contacts) {
                  final name = decryptAESCryptoJS(
                    contact.data()?['name'],
                    passwordEncrypt,
                  );
                  final phone = decryptAESCryptoJS(
                    contact.data()?['phone'],
                    passwordEncrypt,
                  );
                  final docId = contact.id;

                  final familyNumber =
                      FamilyNumber(name: name, number: phone, docId: docId);
                  familyNumbers.add(familyNumber);
                }
                return AnimationLimiter(
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                    itemCount: familyNumbers.length,
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: Dismissible(
                              key: Key(familyNumbers[index].name as String),
                              child: buildContactList(
                                  context, familyNumbers[index]),
                              direction: DismissDirection.endToStart,
                              onDismissed: (direction) {
                                firestore
                                    .collection("family_contact_bi13rb8")
                                    .doc(familyNumbers[index].docId)
                                    .delete();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                        'Deleted from contact',
                                        style: textStyle.copyWith(
                                            color: Colors.white),
                                      ),
                                      backgroundColor: Colors.black45),
                                );
                              },
                              background: Container(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.all(12),
                                color: Colors.red,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'DELETE',
                                      style: textStyle.copyWith(fontSize: 14),
                                    )
                                  ],
                                ),
                              ),
                            ),
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
      ],
    );
  }
}
