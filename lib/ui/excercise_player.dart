import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:workout_flutter/common/constant.dart';
import 'package:workout_flutter/main.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ExcercisePlayer extends StatefulWidget {
  static const routeName = '/excercise_player_page';
  final List link;

  ExcercisePlayer({required this.link});

  @override
  _ExcercisePlayerState createState() => _ExcercisePlayerState();
}

class _ExcercisePlayerState extends State<ExcercisePlayer> {
  late String title;
  late YoutubePlayerController _controller;
  late YoutubeMetaData _videoMetaData;
  bool _isPlayerReady = false;
  int timeStamp = 0;
  int time = 0;

  @override
  void initState() {
    title = widget.link[0];
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.link[1]),
      flags: const YoutubePlayerFlags(
        hideControls: false,
        controlsVisibleAtStart: true,
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: true,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _videoMetaData = const YoutubeMetaData();
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _videoMetaData = _controller.metadata;
      });
    }
    if (_controller.value.isPlaying) {
      if (timeStamp == 0) {
        timeStamp = DateTime.now().millisecondsSinceEpoch;
      } else {
        time = DateTime.now().millisecondsSinceEpoch - timeStamp;
      }
    }
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      onEnterFullScreen: () {
        SystemChrome.setPreferredOrientations(
            [DeviceOrientation.landscapeLeft]);
      },
      onExitFullScreen: () {
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      },
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blueAccent,
        onReady: () {
          _isPlayerReady = true;
        },
        topActions: [
          SizedBox(height: 8.0),
          Expanded(
            child: Text(
              _controller.metadata.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
      builder: (context, player) => Scaffold(
        appBar: AppBar(
          title: Text("Medicine Detail"),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                player,
                SizedBox(height: 16),
                Text(
                  _videoMetaData.title,
                  style: textStyle.copyWith(
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  _videoMetaData.author,
                  style: textStyle.copyWith(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await firestore
                .collection('user_account_bi13rb8')
                .doc(userData?.docId)
                .update({'point': (time ~/ 60000)});
            await firestore.collection('user_activity_bi13rb8').add({
              "activity": 'Doing $title Exercise',
              "id": auth.currentUser?.email,
              "time": DateTime.now().toString()
            });
            final snackBar = SnackBar(content: Text('Your record saved'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
          child: Icon(
            Icons.check,
          ),
        ),
      ),
    );
  }
}
