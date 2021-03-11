import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:video_player/video_player.dart';
import 'package:workout_flutter/common/constant.dart';

class ExcercisePlayer extends StatefulWidget {
  static const routeName = '/excercise_player_page';

  @override
  _ExcercisePlayerState createState() => _ExcercisePlayerState();
}

class _ExcercisePlayerState extends State<ExcercisePlayer> {
  final VideoPlayerController videoPlayerController =
      VideoPlayerController.network(
          'https://www.radiantmediaplayer.com/media/big-buck-bunny-360p.mp4');
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: videoPlayerController.value.aspectRatio,
      autoInitialize: true,
      autoPlay: true,
      looping: false,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (videoPlayerController.value.isPlaying) {
          videoPlayerController.pause();
        }
        return new Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Medicine Detail"),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 400,
                  child: Chewie(
                    controller: _chewieController,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'This is title',
                  style: textStyle.copyWith(
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'This is description',
                  style: textStyle.copyWith(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.keyboard_arrow_right),
        ),
      ),
    );
  }
}
