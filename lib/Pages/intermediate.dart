import 'package:appdev1/Pages/mainpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

class IntermediatePage extends StatefulWidget {
  const IntermediatePage({Key? key}) : super(key: key);

  @override
  _IntermediatePageState createState() => _IntermediatePageState();
}

class _IntermediatePageState extends State<IntermediatePage> {
  List<String> imageAssets = [
    'characters/pics/devil.png',
    'characters/pics/ghost.png',
    'characters/pics/mummy.png',
    'characters/pics/pirate.png',
    'characters/pics/skull.png',
    'characters/pics/vampire.png',
    'characters/pics/witch.png',
    'characters/pics/wolf.png',
    'characters/pics/angel.png',
    'characters/pics/ghost (2).png',
  ];

  late List<String> gridImages;
  bool canFlip = false;
  List<int> flippedIndices = [];
  List<int> matchedIndices = [];
  bool showingCards = true;
  int score = 0;
  late Timer timer;
  int secondsElapsed = 0;
  bool gameOver = false;
  bool victory = false;

  @override
  void initState() {
    super.initState();
    gridImages = [...imageAssets, ...imageAssets]; // Duplicate the list
    gridImages.shuffle(); // Shuffle the list to randomize the order

    // Set initial time to 2 minutes (90 seconds)
    secondsElapsed = 90;

    // After 3 seconds, hide the cards and start the timer
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        showingCards = false;
        canFlip = true;
        startTimer(); // Start the timer
      });
    });
  }

  @override
  void dispose() {
    // Dispose the timer when the widget is disposed
    timer.cancel();
    super.dispose();
  }

  void startTimer() {
    const int totalSeconds = 90; // 2 minutes in seconds
    secondsElapsed = totalSeconds; // Initialize with the total seconds

    // Start the timer to update the elapsed seconds
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        if (secondsElapsed > 0) {
          secondsElapsed--; // Decrease the seconds elapsed
        } else {
          timer.cancel(); // Stop the timer when it reaches 0
          if (matchedIndices.length < gridImages.length) {
            // If there are still unmatched cards
            setState(() {
              gameOver = true;
            });
          }
        }
      });
    });
  }

  void _onCardTap(int index) {
    if (!canFlip ||
        matchedIndices.contains(index) ||
        showingCards ||
        gameOver ||
        victory) return;

    setState(() {
      if (!flippedIndices.contains(index)) {
        flippedIndices.add(index);
      }

      if (flippedIndices.length == 2) {
        canFlip = false;

        if (gridImages[flippedIndices[0]] != gridImages[flippedIndices[1]]) {
          Future.delayed(Duration(seconds: 1), () {
            setState(() {
              flippedIndices.clear();
              canFlip = true;
            });
          });
        } else {
          // Increase the score by 100 for each match
          score += 150;

          // Check for streaks
          if (matchedIndices.isNotEmpty &&
              matchedIndices.last == index - 1 &&
              index % 4 != 0) {
            score += 150; // Add 100 points for streaks
          }

          matchedIndices.addAll(flippedIndices);
          flippedIndices.clear();
          canFlip = true;

          // Check if all cards are matched
          if (matchedIndices.length == gridImages.length) {
            // All cards are matched, stop the timer or perform any other end game logic
            timer.cancel();
            setState(() {
              victory = true;
            });
            // Optionally, you can show a message or navigate to another screen to display the end game stats
          }
        }
      }
    });
  }

  void _restartGame() {
    setState(() {
      gridImages.shuffle();
      flippedIndices.clear();
      matchedIndices.clear();
      score = 0;
      secondsElapsed = 90;
      gameOver = false;
      victory = false;
      showingCards = true;

      // After 3 seconds, hide the cards and start the timer
      Future.delayed(Duration(seconds: 3), () {
        setState(() {
          showingCards = false;
          canFlip = true;
          startTimer(); // Start the timer
        });
      });
    });
  }

  void saveScoreAndTimeToFirestore(int score, int secondsLeft) {
    String userEmail = FirebaseAuth.instance.currentUser!.email!;
    FirebaseFirestore.instance.collection('leaderboard').add({
      'email': userEmail,
      'score': score,
      'secondsLeft': secondsLeft,
      'timestamp': Timestamp.now(),
    }).then((value) {
      print('Score and time saved successfully');
    }).catchError((error) {
      print('Failed to save score and time: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/IntermediatePage.png',
          height: 70,
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(221, 30, 29, 29),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        elevation: 0,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/play again (1).png',
            fit: BoxFit.fill,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Container for the scoreboard
              Container(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                color: Colors.black.withOpacity(0.5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Display the score
                    Text(
                      'Score: $score',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Display the time
                    Text(
                      'Time: $secondsElapsed s',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: GridView.builder(
                      itemCount: (gridImages.length).ceil(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => _onCardTap(index),
                          child: FlipCardWidget(
                            isFlipped: showingCards ||
                                flippedIndices.contains(index) ||
                                matchedIndices.contains(index),
                            front: Container(
                              color: Colors.blueGrey,
                              child: Image.asset(
                                'assets/images/front.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            back: Container(
                              child: Center(
                                child: Image.asset(
                                  gridImages[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (gameOver || victory)
            Center(
              child: Container(
                height: 200,
                width: 300,
                color: Colors.white.withOpacity(0.9),
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      gameOver ? 'GAME OVER' : 'VICTORY!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: gameOver ? Colors.red : Colors.green,
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _restartGame,
                      child: Text(
                        'Restart',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainPage(),
                            //goes to the SecondPage
                          ),
                        );
                      },
                      child: Text(
                        'Go Home',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class FlipCardWidget extends StatefulWidget {
  final Widget front;
  final Widget back;
  final bool isFlipped;

  const FlipCardWidget({
    Key? key,
    required this.front,
    required this.back,
    required this.isFlipped,
  }) : super(key: key);

  @override
  _FlipCardWidgetState createState() => _FlipCardWidgetState();
}

class _FlipCardWidgetState extends State<FlipCardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isFlipped = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _isFlipped = widget.isFlipped;
    if (_isFlipped) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void didUpdateWidget(covariant FlipCardWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isFlipped != _isFlipped) {
      _isFlipped = widget.isFlipped;
      if (_isFlipped) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final transform = Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY(_animation.value * pi);

        return Transform(
          transform: transform,
          alignment: Alignment.center,
          child: _animation.value <= 0.5 ? widget.front : widget.back,
        );
      },
    );
  }
}
