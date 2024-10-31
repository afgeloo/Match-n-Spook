// ignore_for_file: prefer_const_constructors

import 'package:appdev1/Pages/beginner.dart';
import 'package:appdev1/Pages/difficult.dart';
import 'package:appdev1/Pages/intermediate.dart';
import 'package:appdev1/Pages/leaderboard.dart';
import 'package:appdev1/Pages/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

// void main() {
//   runApp(const MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainPage(),
        routes: {
          '/beginnerpage':(context) => BeginnerPage(),
          '/intermediatepage': (context) => IntermediatePage(),
          '/difficultpage': (context) => DifficultPage(),
          '/lbpage': (context) => LeaderboardPage(),
          '/mainpage': (context) => MainPage(),
        });
  }
}
