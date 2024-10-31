import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const MyTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 235,
      height: 25,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(color: Color.fromARGB(255, 130, 61, 37)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(color: Color.fromARGB(255, 130, 61, 37)),
            ),
            fillColor: Color.fromARGB(255, 105, 41, 19),
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.white60, fontSize: 13),
            contentPadding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10), // Adjust the vertical padding as needed
          ),
        ),
      ),
    );
  }
}
