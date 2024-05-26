import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:turf_nest/SplashScreen.dart';
import 'package:turf_nest/firebase_helper/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    var nothing = 0;
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}
