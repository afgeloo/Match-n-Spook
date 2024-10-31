// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:appdev1/Pages/aboutpage.dart';
import 'package:appdev1/Pages/homepage.dart';
import 'package:appdev1/Pages/leaderboard.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int intSelectedIndex = 0;

  void navigateBottomBar(int index) {
    setState(() {
      intSelectedIndex = index;
    });
  }

  final List pages = [
    HomePage(),
    LeaderboardPage(),
    AboutPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[intSelectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: intSelectedIndex,
        backgroundColor: const Color.fromARGB(221, 30, 29, 29),
        onTap: navigateBottomBar,
        color: Color.fromARGB(255, 250, 145, 47),
        buttonBackgroundColor: Color.fromARGB(255, 250, 145, 47),
        height: 50, // Set the height of the navigation bar
        items: [
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.leaderboard, color: Colors.white),
          Icon(Icons.person, color: Colors.white)
        ],
      ),
    );
  }
}
