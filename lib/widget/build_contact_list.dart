import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:workout_flutter/data/model/family_number.dart';

Widget buildContactList(BuildContext context, FamilyNumber familyNumber) {
  return ListTile(
    leading: Icon(Icons.people),
    title: Text(familyNumber.name),
    subtitle: Text(familyNumber.number),
    onLongPress: () {
      _makingPhoneCall(familyNumber.number);
    },
  );
}

Future<dynamic> _makingPhoneCall(String number) async {
  String url = 'tel:$number';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $number';
  }
}
