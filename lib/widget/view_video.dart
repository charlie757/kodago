import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class ViewVideo extends StatefulWidget {
  final String videoUrl;

  const ViewVideo({
    super.key,
    required this.videoUrl,
  });

  @override
  _ViewVideoState createState() => _ViewVideoState();
}

class _ViewVideoState extends State<ViewVideo> {
  // late VideoPlayerController _controller;
  late FlickManager flickManager;

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(widget.videoUrl),
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  Future setLandscape() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Center(
        child: FlickVideoPlayer(
          flickManager: flickManager,
          flickVideoWithControls: FlickVideoWithControls(
            videoFit: BoxFit.cover,
            willVideoPlayerControllerChange: true,
            controls: IconTheme(
                data: const IconThemeData(color: Colors.black87),
                child: Container(
                  child: FlickPortraitControls(
                    progressBarSettings: FlickProgressBarSettings(
                      bufferedColor: Colors.black87.withOpacity(0.2),
                      playedColor: Colors.black87,
                      handleColor: Colors.black87,
                    ),
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
