import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:appdev1/Pages/beginner.dart';
import 'package:appdev1/Pages/intermediate.dart';
import 'package:appdev1/Pages/difficult.dart';
import 'package:appdev1/Pages/loginpage.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/images/opening screen (2).png', // Update with your image asset path
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width, // Match screen width
            height: MediaQuery.of(context).size.height,
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 380),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BeginnerPage(),
                      ),
                    );
                  },
                  child: Container(
                    height: 80,
                    width: 200,
                    child: Image.asset(
                      'assets/images/Beginner.png',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => IntermediatePage(),
                      ),
                    );
                  },
                  child: Container(
                    height: 100,
                    width: 200,
                    child: Image.asset(
                      'assets/images/Intermediate.png',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DifficultPage(),
                      ),
                    );
                  },
                  child: Container(
                    height: 80,
                    width: 200,
                    child: Image.asset(
                      'assets/images/Difficult.png',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 750,
            left: 365,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
              child: Icon(
                Icons.logout,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: 750,
            left: 25,
            child: GestureDetector(
              onTap: () {
                // Handle music note icon tap
              },
              child: Icon(
                Icons.music_note,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
          if (user != null)
            Positioned(
              top: 20,
              left: 10,
              child: Text(
                "LOGGED IN AS: ${user.email}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
