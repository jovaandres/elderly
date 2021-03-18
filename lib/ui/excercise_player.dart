import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:workout_flutter/common/constant.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ExcercisePlayer extends StatefulWidget {
  static const routeName = '/excercise_player_page';
  final String link;

  ExcercisePlayer({required this.link});

  @override
  _ExcercisePlayerState createState() => _ExcercisePlayerState();
}

class _ExcercisePlayerState extends State<ExcercisePlayer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.link),
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
    );
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
      onExitFullScreen: () {
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      },
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blueAccent,
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
                  _controller.metadata.title,
                  style: textStyle.copyWith(
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  _controller.metadata.author,
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
          child: Icon(
            Icons.keyboard_arrow_right,
          ),
        ),
      ),
    );
  }
}
