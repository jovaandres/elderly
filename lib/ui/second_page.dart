import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:workout_flutter/common/constant.dart';
import 'package:workout_flutter/common/navigation.dart';
import 'package:workout_flutter/data/model/family_number.dart';
import 'package:workout_flutter/provider/contact_provider.dart';
import 'package:workout_flutter/util/result_state.dart';
import 'package:workout_flutter/widget/build_contact_list.dart';

class SecondPage extends StatefulWidget {
  static const routeName = '/second_page';

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final _nameFieldController = TextEditingController();
  final _reviewFieldController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameFieldController.dispose();
    _reviewFieldController.dispose();
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
                    'Review Restaurant',
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
                            hintText: 'Nama Kamu',
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Tulis Review Sedikitnya Satu Kata';
                              }
                              return null;
                            },
                            controller: _reviewFieldController,
                            decoration: InputDecoration(
                              hintText: 'Tulis Review',
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        RaisedButton(
                          color: Theme.of(context).accentColor,
                          child: Text(
                            'SEND',
                            style: textStyle.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          onPressed: () {
                            saveContact(_nameFieldController.text,
                                _reviewFieldController.text);
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
    var contact = FamilyNumber(name: name, number: number);
    Provider.of<ContactProvider>(context, listen: false).addContact(contact);
  }
}

Widget _buildList() {
  return Column(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Expanded(
        child: Consumer<ContactProvider>(
          builder: (context, state, _) {
            final contact = state.contact;
            if (state.state == ResultState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.state == ResultState.HasData) {
              return AnimationLimiter(
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: contact.length,
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: Dismissible(
                            key: Key(contact[index].name),
                            child: buildContactList(context, contact[index]),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              state.removeContact(contact[index].id);
                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                      'Deleted from favorite',
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
            } else if (state.state == ResultState.NoData) {
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
