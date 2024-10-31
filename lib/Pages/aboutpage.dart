import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/images/play again (1).png',
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.22, // Set height based on screen size
                child: Image.asset(
                  'assets/images/transparentTitle.png',
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ),
          Positioned.fill(
            top: MediaQuery.of(context).size.height * 0.2, // Set top position based on screen size
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView(
                children: [
                  _buildItem(
                    'ANGELO REYES',
                    'Backend Developer',
                    '“If you think that Math is hard, try Backend Developing.”',
                    'assets/images/Angelo.jpg',
                    context,
                    nameFontSize: MediaQuery.of(context).size.width * 0.05, // Set font size based on screen width
                    roleFontSize: MediaQuery.of(context).size.width * 0.03, // Set font size based on screen width
                    quoteFontSize: MediaQuery.of(context).size.width * 0.03, // Set font size based on screen width
                  ),
                  _buildItem(
                    'CHRISTAL AGMATA',
                    'UI/UX Designer',
                    '“Design is not just what it looks like and feels like. Design is how it works.”',
                    'assets/images/Christal.jpg',
                    context,
                    nameFontSize: MediaQuery.of(context).size.width * 0.05, // Set font size based on screen width
                    roleFontSize: MediaQuery.of(context).size.width * 0.03, // Set font size based on screen width
                    quoteFontSize: MediaQuery.of(context).size.width * 0.03, // Set font size based on screen width
                  ),
                  _buildItem(
                    'JANELLE GALANG',
                    'UI/UX Designer',
                    '“A user interface is well-designed when the program behaves exactly how the user thought it would.”',
                    'assets/images/Janelle.jpg',
                    context,
                    nameFontSize: MediaQuery.of(context).size.width * 0.05, // Set font size based on screen width
                    roleFontSize: MediaQuery.of(context).size.width * 0.03, // Set font size based on screen width
                    quoteFontSize: MediaQuery.of(context).size.width * 0.03, // Set font size based on screen width
                  ),
                  _buildItem(
                    'HERMIONE MCBRIDE',
                    'Frontend Developer',
                    '“There are three responses to a piece of design - yes, no, and WOW! Wow is the one to aim for.”',
                    'assets/images/Hermione.jpg',
                    context,
                    nameFontSize: MediaQuery.of(context).size.width * 0.05, // Set font size based on screen width
                    roleFontSize: MediaQuery.of(context).size.width * 0.03, // Set font size based on screen width
                    quoteFontSize: MediaQuery.of(context).size.width * 0.03, // Set font size based on screen width
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(
    String name,
    String role,
    String quote,
    String imagePath,
    BuildContext context, {
    double? nameFontSize,
    double? roleFontSize,
    double? quoteFontSize,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.3, // Set size based on screen width
            width: MediaQuery.of(context).size.width * 0.3, // Set size based on screen width
            child: ClipOval(
              child: Image.asset(
                imagePath,
                height: MediaQuery.of(context).size.width * 0.3, // Set size based on screen width
                width: MediaQuery.of(context).size.width * 0.3, // Set size based on screen width
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5, // Set width based on screen width
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$name',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: nameFontSize ?? MediaQuery.of(context).size.width * 0.04, // Set font size based on screen width
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  role,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: roleFontSize ?? MediaQuery.of(context).size.width * 0.02, // Set font size based on screen width
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\n$quote',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: quoteFontSize ?? MediaQuery.of(context).size.width * 0.02, // Set font size based on screen width
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
