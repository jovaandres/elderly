import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:workout_flutter/common/constant.dart';
import 'package:workout_flutter/common/navigation.dart';
import 'package:workout_flutter/data/model/family_number.dart';
import 'package:workout_flutter/main.dart';
import 'package:workout_flutter/widget/build_contact_list.dart';

class SecondPage extends StatefulWidget {
  static const routeName = '/second_page';

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final _nameFieldController = TextEditingController();
  final _numberFieldController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameFieldController.dispose();
    _numberFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second"),
      ),
      body: _buildList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return SimpleDialog(
                  title: Text(
                    'Add Contact',
                    style: textStyle.copyWith(
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  contentPadding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextField(
                          controller: _nameFieldController,
                          decoration: InputDecoration(
                            hintText: 'Name',
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Phone must not be null';
                              }
                              return null;
                            },
                            controller: _numberFieldController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              hintText: 'Phone Number',
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          child: Text(
                            'SAVE',
                            style: textStyle.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          onPressed: () {
                            saveContact(_nameFieldController.text,
                                _numberFieldController.text);
                            Navigation.back();
                          },
                        )
                      ],
                    ),
                  ],
                );
              });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  void saveContact(String name, String number) {
    _nameFieldController.clear();
    _numberFieldController.clear();
    firestore.collection('family_contact_bi13rb8').add({
      'id': auth.currentUser.email,
      'name': name,
      'phone': number,
    });
  }

  Widget _buildList() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: firestore
                .collection('family_contact_bi13rb8')
                .where('id', isEqualTo: auth.currentUser.email)
                .orderBy('name', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                final contacts = snapshot.data.docs;
                List<FamilyNumber> familyNumbers = [];
                for (var contact in contacts) {
                  final name = contact.data()['name'];
                  final phone = contact.data()['phone'];
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
                              key: Key(familyNumbers[index].name),
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
        )
      ],
    );
  }
}
