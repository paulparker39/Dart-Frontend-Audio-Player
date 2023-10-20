import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String audio; // Audio source, can be a URL or local file path
  final AudioPlayer audioPlayer; // Pass in an AudioPlayer instance

  const AudioPlayerWidget({
    Key? key,
    required this.audio,
    required this.audioPlayer,
  }) : super(key: key);

  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.replay_10),
                onPressed: () {
                  _seekRelative(-15); // Skip backward by 15 seconds
                },
              ),
              IconButton(
                icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                onPressed: () {
                  _togglePlayback();
                },
              ),
              IconButton(
                icon: Icon(Icons.forward_10),
                onPressed: () {
                  _seekRelative(15); // Skip forward by 15 seconds
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _togglePlayback() {
    if (isPlaying) {
      widget.audioPlayer.pause();
    } else {
      widget.audioPlayer.play(widget.audio);
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  void _seekRelative(int seconds) {
    int currentPosition = widget.audioPlayer.position.inSeconds;
    int newPosition = currentPosition + seconds;
    widget.audioPlayer.seek(Duration(seconds: newPosition));
  }
}

