import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:workout_flutter/common/constant.dart';
import 'package:workout_flutter/common/navigation.dart';
import 'package:workout_flutter/data/model/family_number.dart';
import 'package:workout_flutter/main.dart';
import 'package:workout_flutter/util/cryptojs_aes_encryption_helper.dart';
import 'package:workout_flutter/widget/build_contact_list.dart';
import 'package:permission_handler/permission_handler.dart';

class SecondPage extends StatefulWidget {
  static const routeName = '/second_page';

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final _nameFieldController = TextEditingController();
  final _numberFieldController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Iterable<Contact> contacts = [];

  @override
  void initState() {
    _askPermissions();
    getContact();
    super.initState();
  }

  @override
  void dispose() {
    _nameFieldController.dispose();
    _numberFieldController.dispose();
    super.dispose();
  }

  Future<void> getContact() async {
    if (await Permission.contacts.status == PermissionStatus.granted) {
      contacts = await ContactsService.getContacts();
    } else {
      contacts = [];
    }
  }

  Future<void> _askPermissions() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus != PermissionStatus.granted) {
      _handleInvalidPermissions(permissionStatus);
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted ||
        permission != PermissionStatus.denied) {
      Map<Permission, PermissionStatus> permissionStatus =
          await [Permission.contacts].request();
      return permissionStatus[Permission.contacts] ?? PermissionStatus.denied;
    } else {
      setState(() {
        getContact();
      });
      return permission;
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      throw PlatformException(
        code: "PERMISSION_DENIED",
        message: "Access to contact data denied",
        details: null,
      );
    } else if (permissionStatus == PermissionStatus.restricted) {
      throw PlatformException(
        code: "PERMISSION_RESTRICTED",
        message: "Contact data restricted",
        details: null,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second"),
      ),
      body: ListView.builder(
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(Icons.people),
              title: Text(contacts.elementAt(index).displayName ?? ''),
              subtitle:
                  Text((contacts.elementAt(index).phones?.isNotEmpty == true) ? contacts.elementAt(index).phones?.first.value as String : '-'),
            );
          }),
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
                              if (value?.isEmpty == true) {
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
    final encryptedName = encryptAESCryptoJS(name, passwordEncrypt);
    final encryptedPhone = encryptAESCryptoJS(number, passwordEncrypt);
    firestore.collection('family_contact_bi13rb8').add({
      'id': auth.currentUser?.email,
      'name': encryptedName,
      'phone': encryptedPhone,
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
        )
      ],
    );
  }
}
