import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MyVideoPlayer extends StatefulWidget {
  final String videoId;

  const MyVideoPlayer({super.key, required this.videoId});

  @override
  State<MyVideoPlayer> createState() => _MyVideoPlayerState();
}

class _MyVideoPlayerState extends State<MyVideoPlayer> {
  late YoutubePlayerController _controller;
  bool canShow = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );

    Future.delayed(const Duration(seconds: 1)).then(
      (v) => {
        setState(() {
          canShow = true;
        })
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return canShow
        ? YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
