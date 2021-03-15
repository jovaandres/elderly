import 'package:flutter/material.dart';
import 'package:workout_flutter/common/constant.dart';
import 'package:workout_flutter/common/navigation.dart';
import 'package:workout_flutter/data/model/excercise.dart';
import 'package:workout_flutter/ui/excercise_detail.dart';

Widget buildExcercise(BuildContext context, Exercise exercise) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
    child: Container(
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
      width: MediaQuery.of(context).size.width * 0.9,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Text(
              exercise.name,
              style: textStyle.copyWith(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            Image(
              height: 80,
              image: AssetImage('assets/yoga.jpg'),
            ),
            TextButton(
              child: Text(
                'EXERCISE',
                style: textStyle.copyWith(
                  color: Colors.blue,
                ),
              ),
              onPressed: () {
                Navigation.intentWithData(ExcerciseDetail.routeName, exercise);
              },
            )
          ],
        ),
      ),
    ),
  );
}
