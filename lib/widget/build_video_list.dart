import 'package:flutter/material.dart';
import 'package:workout_flutter/common/constant.dart';
import 'package:workout_flutter/common/navigation.dart';
import 'package:workout_flutter/ui/excercise_player.dart';

Widget buildVideoList(BuildContext context, String name, String title,
    String description, String link) {
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
      width: MediaQuery.of(context).size.width * 0.95,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: ListTile(
          leading: Image(
            image: AssetImage('assets/yoga.jpg'),
            width: 75,
            height: 75,
          ),
          title: Text(
            title,
            style: textStyle,
          ),
          subtitle: Text(
            description,
            style: textStyle,
          ),
          onTap: () {
            Navigation.intentWithData(ExcercisePlayer.routeName, [name, link]);
          },
        ),
      ),
    ),
  );
}
