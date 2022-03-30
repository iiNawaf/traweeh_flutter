
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:jeddah_mosques/models/District.dart';

class DistrictProvider with ChangeNotifier{
  final districtCollection = FirebaseFirestore.instance.collection('districts');
  final mosquesCollection = FirebaseFirestore.instance.collection("mosques");
  List<District> districtList = [];

  Future<void> fetchDistricts() async{
    final districtSnapshot = await districtCollection.get();
    List<DocumentSnapshot> result = districtSnapshot.docs;
    districtSnapshot.docs.forEach((dis) {
      districtList.add(
        District(
          districtID: dis.data()['district_id'],
          districtName: dis.data()['district_name'],
        )
      );
    });
    notifyListeners();
  }
}