import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioPlay extends StatefulWidget {
  String url;
  AudioPlay({required this.url});
  @override
  State<AudioPlay> createState() => _AudioPlayState();
}

class _AudioPlayState extends State<AudioPlay> {
  AudioPlayer audioPlayer = AudioPlayer();
  bool hasPlayed = false;
  bool isPaused = true;
  bool canBeResumed = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        !hasPlayed ? GestureDetector(
            onTap: () async {
              if(isPaused){
                setState(() {
                  hasPlayed = true;
                  isPaused = false;
                });
                audioPlayer.play(widget.url);
              }           
            },
            child: Container(child: Icon(Icons.play_arrow, size: 30))
          ) : Container(),

          hasPlayed ? GestureDetector(
            onTap: (){
              if(canBeResumed){
                setState(() {
                  canBeResumed = false;
                });
                audioPlayer.resume();
              }else{
                setState(() {
                  canBeResumed = true;
                });
                audioPlayer.pause();
              }
            },
            child: Icon(canBeResumed ? Icons.play_arrow : Icons.pause, size: 30)
          ) : Container(),
      ],
    );
  }
}
