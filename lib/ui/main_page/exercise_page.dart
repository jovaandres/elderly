import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:workout_flutter/common/constant.dart';
import 'package:workout_flutter/data/model/excercise.dart';
import 'package:workout_flutter/main.dart';
import 'package:workout_flutter/widget/build_excercise_list.dart';

class ExercisePage extends StatefulWidget {
  static const routeName = '/exercise_page';

  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(4),
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
                          "AeraHealth",
                          style: textStyle.copyWith(
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Let\'s do some excercise',
                          style: textStyle,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: StreamBuilder<QuerySnapshot>(
                stream: firestore
                    .collection('exercise_bi13rb8')
                    .orderBy('name')
                    .snapshots(),
                builder: (context, snapshot) {
                  List<Exercise> exerciseList = [];
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData) {
                    final exercises =
                        snapshot.data?.docs as List<QueryDocumentSnapshot>;
                    for (var exercise in exercises) {
                      final name = exercise.data()?['name'];
                      final Video video =
                          Video.fromJson(exercise.data()?['video']);
                      exerciseList.add(
                        Exercise(name: name, video: video),
                      );
                    }
                  }
                  return AnimationLimiter(
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8),
                      itemCount: exerciseList.length,
                      itemBuilder: (context, index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: buildExcercise(context, exerciseList[index]),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
