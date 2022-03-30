import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:jeddah_mosques/models/Mosque.dart';

class MosuqeProvider with ChangeNotifier {
  final mosquesCollection = FirebaseFirestore.instance.collection("mosques");
  List<Mosque> mosquesList = [];

  Future<void> fetchMosques() async {
    QuerySnapshot mosqueSnapshot = await mosquesCollection.get();
    List<DocumentSnapshot> result = mosqueSnapshot.docs;
    result.forEach((mos) {
      mosquesList.add(Mosque(
        mosqueID: (mos.data() as dynamic)['mosque_id'],
        mosqueName: (mos.data() as dynamic)['mosque_name'],
        mosqueDistrict: (mos.data() as dynamic)['mosque_district'],
        imamName: (mos.data() as dynamic)['imam_name'],
        imamVoice: (mos.data() as dynamic)['imam_voice'],
        mosqueLocation: (mos.data() as dynamic)['mosque_location'],
        districtID: (mos.data() as dynamic)['district_id'],
        isWomenAllowed: (mos.data() as dynamic)['is_women_allowed'],
      ));
    });
    notifyListeners();
  }
}
