
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:jeddah_mosques/models/District.dart';

class DistrictProvider with ChangeNotifier{
  final districtCollection = FirebaseFirestore.instance.collection('districts');
  List<District> districtList = [];
  late District district;

  Future<void> fetchDistricts(BuildContext context) async{
    final assetBundle = DefaultAssetBundle.of(context);
    final data = await assetBundle.loadString('./districts.json');
    final body = json.decode(data);

    districtList = body.map<District>(District.fromJson).toList();
  }
}