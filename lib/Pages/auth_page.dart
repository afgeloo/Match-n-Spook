import 'package:appdev1/Pages/loginpage.dart';
import 'package:appdev1/Pages/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return MainPage();
            } else {
              return LoginPage();
            }
          }),
    );
  }
}
