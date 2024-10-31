import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LeaderboardEntry {
  final String email;
  final int secondsLeft;
  final String difficulty;

  LeaderboardEntry({
    required this.email,
    required this.secondsLeft,
    required this.difficulty,
  });
}

class LeaderboardPage extends StatefulWidget {
  @override
  _LeaderboardPageState createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leaderboard'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to the main page
            Navigator.pop(context);
          },
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Container(
            color: Colors.grey[200],
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.directions_run),
                  label: 'Beginner',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.directions_transit),
                  label: 'Intermediate',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.directions_bike),
                  label: 'Difficult',
                ),
              ],
            ),
          ),
        ),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          LeaderboardTab(difficulty: 'Beginner'),
          LeaderboardTab(difficulty: 'Intermediate'),
          LeaderboardTab(difficulty: 'Difficult'),
        ],
      ),
    );
  }
}

class LeaderboardTab extends StatelessWidget {
  final String difficulty;

  LeaderboardTab({required this.difficulty});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: FutureBuilder<List<LeaderboardEntry>>(
        future: fetchLeaderboard(difficulty),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          List<LeaderboardEntry>? leaderboard = snapshot.data;
          if (leaderboard == null || leaderboard.isEmpty) {
            return Center(child: Text('No leaderboard data available'));
          }
          return ListView.builder(
            itemCount: leaderboard.length,
            itemBuilder: (context, index) {
              LeaderboardEntry entry = leaderboard[index];
              return ListTile(
                title: Text(entry.email),
                subtitle: Text('Remaining Time: ${entry.secondsLeft} seconds'),
              );
            },
          );
        },
      ),
    );
  }

  Future<List<LeaderboardEntry>> fetchLeaderboard(String difficulty) async {
    List<LeaderboardEntry> leaderboard = [];
    Map<String, LeaderboardEntry> emailEntries = {};
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('leaderboard')
        .where('difficulty', isEqualTo: difficulty)
        .orderBy('secondsLeft', descending: true)
        .get();

    snapshot.docs.forEach((doc) {
      final email = doc['email'] as String;
      final secondsLeft = doc['secondsLeft'] as int;
      final difficulty = doc['difficulty'] as String;

      if (emailEntries.containsKey(email)) {
        if (secondsLeft > emailEntries[email]!.secondsLeft) {
          emailEntries[email] = LeaderboardEntry(
            email: email,
            secondsLeft: secondsLeft,
            difficulty: difficulty,
          );
        }
      } else {
        emailEntries[email] = LeaderboardEntry(
          email: email,
          secondsLeft: secondsLeft,
          difficulty: difficulty,
        );
      }
    });

    leaderboard.addAll(emailEntries.values);
    return leaderboard;
  }
}