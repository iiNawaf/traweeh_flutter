import 'package:flutter/material.dart';
import 'package:jeddah_mosques/models/Mosque.dart';
import 'package:jeddah_mosques/widgets/audio_play.dart';
import 'package:url_launcher/url_launcher.dart';

class MosqueInfo extends StatelessWidget {
  Mosque mosque;
  MosqueInfo({required this.mosque});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 70,
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Color(0xfff8ecdc),
                border: Border.all(color: Colors.white, width: 2)
              ),
              child: Center(
                child: SelectableText("${mosque.mosqueName}")
                )
                ),
          ),
          Expanded(
            child: Container(
              height: 70,
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Color(0xfff8ecdc),
                border: Border.all(color: Colors.white, width: 2)
              ),
              child: Center(child: SelectableText("${mosque.mosqueDistrict}"))),
          ),
          Expanded(
            child: Container(
              height: 70,
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Color(0xfff8ecdc),
                border: Border.all(color: Colors.white, width: 2)
              ),
              child: Center(child: SelectableText("${mosque.imamName}"))),
          ),
          Expanded(
            child: Container(
              height: 70,
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Color(0xfff8ecdc),
                border: Border.all(color: Colors.white, width: 2)
              ),
              child: AudioPlay(url: mosque.imamVoice),
              ),
          ),
          Expanded(
            child: Container(
              height: 70,
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Color(0xfff8ecdc),
                border: Border.all(color: Colors.white, width: 2)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('././assets/man.png', height: 30,),
                  mosque.isWomenAllowed ? Image.asset('././assets/woman.png', height: 30) : Container()
                ],
              )
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () async {
                final url = mosque.mosqueLocation;
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  print("cannot open link.");
                }
              },
              child: Container(
              height: 70,
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Color(0xfff8ecdc),
                border: Border.all(color: Colors.white, width: 2)
              ),
                child: Icon(Icons.location_on, size: 30)),
            ),
          ),
        ],
      ),
    );
  }
}
