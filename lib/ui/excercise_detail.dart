import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:workout_flutter/data/model/excercise.dart';
import 'package:workout_flutter/widget/build_video_list.dart';

class ExcerciseDetail extends StatefulWidget {
  static const routeName = '/excercise_detail_page';
  final Exercise exercise;

  ExcerciseDetail({@required this.exercise});

  @override
  _ExcerciseDetailState createState() => _ExcerciseDetailState();
}

class _ExcerciseDetailState extends State<ExcerciseDetail> {
  Exercise _exercise;

  @override
  void initState() {
    _exercise = widget.exercise;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_exercise.name),
      ),
      body: SingleChildScrollView(
        child: AnimationLimiter(
          child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),
            itemCount: _exercise.video.description.length,
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: buildVideoList(
                      context,
                      'Video ${index + 1}',
                      _exercise.video.description[index],
                      _exercise.video.link[index]),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
