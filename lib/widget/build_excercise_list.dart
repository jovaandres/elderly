import 'package:flutter/material.dart';
import 'package:workout_flutter/common/constant.dart';
import 'package:workout_flutter/common/navigation.dart';
import 'package:workout_flutter/data/model/excercise.dart';
import 'package:workout_flutter/main.dart';
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
      width: MediaQuery.of(context).size.width * 0.95,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Text(
              exercise.name as String,
              style: textStyle.copyWith(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            StreamBuilder<String>(
              stream: storage
                  .ref()
                  .child(
                      '${exercise.name?.trim().replaceAll(' ', '').toLowerCase()}.jpg')
                  .getDownloadURL()
                  .asStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                    padding: EdgeInsets.all(16),
                    child: Image(
                      image: NetworkImage(snapshot.data as String),
                    ),
                  );
                }
                return Container();
              },
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
