import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:workout_flutter/common/constant.dart';
import 'package:workout_flutter/common/navigation.dart';
import 'package:workout_flutter/data/model/medical.dart';
import 'package:workout_flutter/main.dart';
import 'package:workout_flutter/widget/build_medicine_list.dart';

class FifthPage extends StatefulWidget {
  static const routeName = '/fifth_page';

  @override
  _FifthPageState createState() => _FifthPageState();
}

class _FifthPageState extends State<FifthPage> {
  final _nameFieldController = TextEditingController();
  final _rulesFieldController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameFieldController.dispose();
    _rulesFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fifth"),
      ),
      body: _buildList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return SimpleDialog(
                  title: Text(
                    'Add Medicine',
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
                                return 'Rules must not be null';
                              }
                              return null;
                            },
                            controller: _rulesFieldController,
                            decoration: InputDecoration(
                              hintText: 'Rules',
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        RaisedButton(
                          color: Theme.of(context).accentColor,
                          child: Text(
                            'SAVE',
                            style: textStyle.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          onPressed: () {
                            saveContact(_nameFieldController.text,
                                _rulesFieldController.text);
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

  void saveContact(String name, String rules) {
    _nameFieldController.clear();
    _rulesFieldController.clear();
    firestore.collection('medicine_bi13rb8').add({
      'id': "abcdef",
      'name': name,
      'rules': rules,
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
                .collection('medicine_bi13rb8')
                .where('id', isEqualTo: 'abcdef')
                .orderBy('name', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                final medicines = snapshot.data.docs;
                List<Medical> medicals = [];
                for (var medicine in medicines) {
                  final name = medicine.data()['name'];
                  final rules = medicine.data()['rules'];
                  final docId = medicine.id;

                  final medical =
                      Medical(name: name, rules: rules, docId: docId);
                  medicals.add(medical);
                }
                return AnimationLimiter(
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                    itemCount: medicals.length,
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: Dismissible(
                              key: Key(medicals[index].name),
                              child: buildMedicine(context, medicals[index]),
                              direction: DismissDirection.endToStart,
                              onDismissed: (direction) {
                                firestore
                                    .collection("medicine_bi13rb8")
                                    .doc(medicals[index].docId)
                                    .delete();
                                Scaffold.of(context).showSnackBar(
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