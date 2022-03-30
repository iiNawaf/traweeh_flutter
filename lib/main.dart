import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jeddah_mosques/providers/district_provider.dart';
import 'package:jeddah_mosques/providers/mosque_provider.dart';
import 'package:jeddah_mosques/views/home.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyAjPbyiCmlIccMtSz_N9BLDloqcTH5XVcg",
    appId: "1:540779853791:web:9ac7fdf785919092fc366a",
    messagingSenderId: "540779853791",
    projectId: "jeddahmosques-2ad5a",
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: MosuqeProvider()),
          ChangeNotifierProvider.value(value: DistrictProvider()),
        ],
        child: MaterialApp(
          scrollBehavior:MyCustomScrollBehavior(),
          title: 'Traweeh - تراويح',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: 'Cairo'
          ),
          home: Directionality(
            textDirection: TextDirection.rtl,
            child: HomePage()
          ),
        ));
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => { 
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    // etc.
  };
}
