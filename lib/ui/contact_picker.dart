import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:workout_flutter/common/constant.dart';
import 'package:workout_flutter/common/navigation.dart';
import 'package:workout_flutter/main.dart';
import 'package:workout_flutter/provider/contact_provider.dart';
import 'package:workout_flutter/util/cryptojs_aes_encryption_helper.dart';
import 'package:workout_flutter/util/result_state.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactPciker extends StatefulWidget {
  static const routeName = '/contact_picker';

  @override
  _ContactPcikerState createState() => _ContactPcikerState();
}

class _ContactPcikerState extends State<ContactPciker> {
  Iterable<Contact> contacts = [];

  @override
  void initState() {
    _askPermissions();
    super.initState();
  }

  Future<void> _askPermissions() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus != PermissionStatus.granted) {
      _handleInvalidPermissions(permissionStatus);
    } else {
      Provider.of<ContactProvider>(context, listen: false).getContactList();
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
      Provider.of<ContactProvider>(context, listen: false).getContactList();
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
      body: _buildList(),
    );
  }

  void saveContact(String name, String number) {
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
          flex: 1,
          child: Consumer<ContactProvider>(
            builder: (context, provider, _) {
              if (provider.state == ResultState.Loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (provider.state == ResultState.HasData) {
                final contacts = provider.contacts;
                return ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(Icons.people),
                      title: Text(contacts.elementAt(index).displayName ?? ''),
                      subtitle: Text(
                          (contacts.elementAt(index).phones?.isNotEmpty == true)
                              ? contacts.elementAt(index).phones?.first.value
                                  as String
                              : '-'),
                      onLongPress: () {
                        showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Pin Contact?'),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[
                                      Text(
                                          'Add this contact to your main family?'),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('Cancel'),
                                    onPressed: () {
                                      Navigation.back();
                                    },
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      saveContact(
                                          contacts
                                                  .elementAt(index)
                                                  .displayName ??
                                              'Anonim',
                                          (contacts
                                                      .elementAt(index)
                                                      .phones
                                                      ?.isNotEmpty ==
                                                  true)
                                              ? contacts
                                                  .elementAt(index)
                                                  .phones
                                                  ?.first
                                                  .value as String
                                              : '-');
                                      Navigation.back();
                                    },
                                    child: Text('OK'),
                                  )
                                ],
                              );
                            });
                      },
                    );
                  },
                );
              } else if (provider.state == ResultState.NoData) {
                return Center(
                  child: Text('No Contacts Data'),
                );
              } else {
                return Center(
                  child: Text('Error showing data, ${provider.message}'),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
