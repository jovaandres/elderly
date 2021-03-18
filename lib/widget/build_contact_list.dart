import 'package:flutter/material.dart';
import 'package:workout_flutter/common/constant.dart';
import 'package:workout_flutter/data/model/family_number.dart';
import 'package:workout_flutter/util/phone_call.dart';

Widget buildContactList(BuildContext context, FamilyNumber familyNumber) {
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
          leading: Icon(Icons.people),
          title: Text(
            familyNumber.name as String,
            style: textStyle,
          ),
          subtitle: Text(
            familyNumber.number as String,
            style: textStyle,
          ),
          onTap: () {
            makingPhoneCall(familyNumber.number as String);
          },
        ),
      ),
    ),
  );
}
