import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:appdev1/Pages/mainpage.dart';
import 'package:appdev1/Pages/mytextfield.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  void signUpUser(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    try {
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);

        // Navigate to the main page after successful signup
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
        );
      } else {
        showErrorMessage("Passwords don't match!");
      }
    } on FirebaseAuthException catch (e) {
      showErrorMessage(e.code);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 250, 145, 47),
          title: Center(
            child: Text(
              message,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
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
              0.5,
              0,
              0,
              0,
              0,
              0,
              0.5,
              0,
              0,
              0,
              0,
              0,
              0.5,
              0,
              0,
              0,
              0,
              0,
              1,
              0,
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
              // Add your login form or other content here
              Container(
                height: 300,
                color: Colors.transparent, // Adjust opacity if needed
                child: Center(
                  child: Stack(
                    children: [
                      // Image
                      Image.asset('assets/images/signuppic.png',
                          fit: BoxFit.fill),

                      // Signup Button
                      Positioned(
                        top: 160,
                        left: 180,
                        child: SignupButton(
                          onPressed: () {
                            signUpUser(context);
                          },
                        ),
                      ),
                      Positioned(
                        top: 72,
                        left: 135,
                        child: MyTextField(
                          controller: emailController,
                          hintText: 'Email',
                          obscureText: false,
                        ),
                      ),
                      Positioned(
                        top: 101,
                        left: 135,
                        child: MyTextField(
                          controller: passwordController,
                          hintText: 'Password',
                          obscureText: true,
                        ),
                      ),
                      Positioned(
                        top: 131,
                        left: 135,
                        child: MyTextField(
                          controller: confirmPasswordController,
                          hintText: 'Confirm Password',
                          obscureText: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Go Back Button 
          Positioned(
            top: 20,
            left: 20,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                // Add your logic to go back here, e.g., Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ),
          // Loading indicator
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}

class SignupButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SignupButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Image.asset(
        'assets/images/signupbutton.png', // Your image asset path
        fit: BoxFit.fill,
        width: 70,
        height: 35,
      ),
    );
  }
}
