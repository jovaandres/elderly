import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:workout_flutter/common/constant.dart';
import 'package:workout_flutter/common/navigation.dart';
import 'package:workout_flutter/main.dart';
import 'package:workout_flutter/util/cryptojs_aes_encryption_helper.dart';

Widget contactPickerList(BuildContext context, Contact contact) {
  return Center(
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
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
      height: 75,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: ListTile(
          enabled: contact.phones?.isNotEmpty == true,
          leading: Icon(
            Icons.people,
          ),
          title: Text(
            contact.displayName ?? '',
            style: textStyle,
          ),
          subtitle: Text(
            (contact.phones?.isNotEmpty == true)
                ? contact.phones?.first.value as String
                : '-',
            style: textStyle,
          ),
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
                          Text('Add this contact to your main family?'),
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
                              contact.displayName ?? 'Anonim',
                              (contact.phones?.isNotEmpty == true)
                                  ? contact.phones?.first.value as String
                                  : '-');
                          Navigation.back();
                        },
                        child: Text('OK'),
                      )
                    ],
                  );
                });
          },
        ),
      ),
    ),
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
