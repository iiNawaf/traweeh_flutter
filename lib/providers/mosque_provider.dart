import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jeddah_mosques/models/Mosque.dart';

class MosuqeProvider with ChangeNotifier {
  final mosquesCollection = FirebaseFirestore.instance.collection("mosques");
  List<Mosque> mosquesList = [];
  late List<DocumentSnapshot> result;

  Future<void> fetchMosques() async {
    QuerySnapshot mosqueSnapshot = await mosquesCollection.limit(10).get();
    result = mosqueSnapshot.docs;
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

  Future<void> fetchNextMosques(BuildContext context) async{
    try{
      QuerySnapshot mosqueSnapshot = await mosquesCollection.startAfterDocument(result[result.length - 1]).limit(10).get();
    result = mosqueSnapshot.docs;
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
    }catch(e){
      print("Error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("لا توجد نتائج"))
      );
    }
  }
}
