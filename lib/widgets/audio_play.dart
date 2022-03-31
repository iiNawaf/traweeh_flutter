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
  Color color = Colors.green;

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
                  color = Colors.black;
                });
                audioPlayer.play(widget.url);
              }           
            },
            child:  Icon(Icons.play_arrow,color: color, size: 30)
          ) : Container(),

          hasPlayed ? GestureDetector(
            onTap: (){
              if(canBeResumed){
                setState(() {
                  canBeResumed = false;
                  color= Colors.black;
                });
                audioPlayer.resume();
              }else{
                setState(() {
                  canBeResumed = true;
                  color= Colors.green;
                });
                audioPlayer.pause();
              }
            },
            child: Icon(canBeResumed ? Icons.play_arrow : Icons.pause,color: color, size: 30)
          ) : Container(),
      ],
    );
  }
}
