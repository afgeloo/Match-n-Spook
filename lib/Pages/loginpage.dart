import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:appdev1/Pages/mainpage.dart';
import 'package:appdev1/Pages/signuppage.dart';
import 'package:appdev1/Pages/mytextfield.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _login(BuildContext context) {
    String username = usernameController.text;
    String password = passwordController.text;

    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: username,
      password: password,
    ).then((userCredential) {
      // Login successful, navigate to MainPage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage(),
        ),
      );
    }).catchError((error) {
      // Handle authentication errors
      showDialog(
  context: context,
  builder: (context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0), // Customize border radius here
      ),
      child: Container(
        width: 100.0, // Customize dialog width here
        height: 180.0, // Customize dialog height here
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 250, 145, 47), // Customize background color
          borderRadius: BorderRadius.circular(10.0), // Same as shape's borderRadius for consistency
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'LOGIN ERROR',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 201, 21, 8),
                  fontSize: 20.0, // Customize title font size
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Invalid Credentials. Please try again.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0, // Customize content font size
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text(
                'OK',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 255, 255, 255),
                  fontSize: 18.0, // Customize button text font size
                ),
              ),
            ),
          ],
        ),
      ),
    );
  },
);

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image with color filter
          ColorFiltered(
            colorFilter: ColorFilter.matrix([
              0.5, 0, 0, 0, 0,
              0, 0.5, 0, 0, 0,
              0, 0, 0.5, 0, 0,
              0, 0, 0, 1, 0,
            ]),
            child: Image.asset(
              'assets/images/play again (1).png',
              fit: BoxFit.cover,
            ),
          ),
          // Content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 300,
                color: Colors.transparent,
                child: Center(
                  child: Stack(
                    children: [
                      Image.asset('assets/images/loginpic.png', fit: BoxFit.fill),
                      Positioned(
                        top: 145,
                        left: 125,
                        child: GestureDetector(
                          onTap: () {
                            _login(context); // Call login function
                          },
                          child: Image.asset(
                            'assets/images/loginbutton.png',
                            fit: BoxFit.fill,
                            width: 70,
                            height: 35,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 160,
                        left: 226,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpPage(),
                              ),
                            );
                          },
                          child: Image.asset(
                            'assets/images/signupbutton.png',
                            fit: BoxFit.fill,
                            width: 70,
                            height: 35,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 78,
                        left: 135,
                        child: MyTextField(
                          controller: usernameController,
                          hintText: 'Username',
                          obscureText: false,
                        ),
                      ),
                      Positioned(
                        top: 112,
                        left: 135,
                        child: MyTextField(
                          controller: passwordController,
                          hintText: 'Password',
                          obscureText: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

