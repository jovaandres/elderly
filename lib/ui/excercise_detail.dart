import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:workout_flutter/widget/build_video_list.dart';

class ExcerciseDetail extends StatefulWidget {
  static const routeName = '/excercise_detail_page';

  @override
  _ExcerciseDetailState createState() => _ExcerciseDetailState();
}

class _ExcerciseDetailState extends State<ExcerciseDetail> {
  List<String> videoList = ['Video 1', 'Video 2', 'Video 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Third"),
      ),
      body: SingleChildScrollView(
        child: AnimationLimiter(
          child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),
            itemCount: videoList.length,
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: buildVideoList(context, videoList[index]),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
