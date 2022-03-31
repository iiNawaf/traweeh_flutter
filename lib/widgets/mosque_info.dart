import 'package:flutter/material.dart';
import 'package:jeddah_mosques/models/Mosque.dart';
import 'package:jeddah_mosques/shared/styles.dart';
import 'package:jeddah_mosques/widgets/audio_play.dart';
import 'package:url_launcher/url_launcher.dart';

class MosqueInfo extends StatelessWidget {
  Mosque mosque;
  MosqueInfo({required this.mosque});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
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
                child: SelectableText("${mosque.imamName}",style: ktextStyle.copyWith(fontSize: width> 412 ? 14.0:10.0))
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
              child: Center(child: SelectableText("${mosque.mosqueName}",style: ktextStyle.copyWith(fontSize: width> 412 ? 14.0:10.0)))),
          ),
          Expanded(
            child: Container(
              height: 70,
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Color(0xfff8ecdc),
                border: Border.all(color: Colors.white, width: 2)
              ),
              child: Center(child: SelectableText("${mosque.mosqueDistrict}",style: ktextStyle.copyWith(fontSize: width> 412 ? 14.0:10.0),))),
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
                  Image.asset('././assets/man.png', height: width > 500? 30 : 20,),
                  mosque.isWomenAllowed ? Image.asset('././assets/woman.png', height: width > 500? 30 : 20,) : Container()
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
