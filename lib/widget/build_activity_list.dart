import 'package:flutter/material.dart';
import 'package:workout_flutter/common/constant.dart';
import 'package:workout_flutter/data/model/activity.dart';
import 'package:workout_flutter/main.dart';

Widget buildActivityList(BuildContext context, Activity activity) {
  return Center(
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 0),
            blurRadius: 22,
            color: Colors.grey.shade50,
          )
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      height: 75,
      width: MediaQuery.of(context).size.width * 0.95,
      child: Padding(
        padding: EdgeInsets.all(4),
        child: ListTile(
          leading: Icon(Icons.people),
          title: Text(
            (userData?.role == 'family')
                ? activity.id as String
                : 'Your Activity',
            style: textStyle,
          ),
          subtitle: Text(
            activity.activity as String,
            style: textStyle,
          ),
        ),
      ),
    ),
  );
}
