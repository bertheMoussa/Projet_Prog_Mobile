import 'dart:math';

import 'package:flutter/material.dart';
import 'package:projet_dev_mobile/src/1_Joueur/Movement/Game3/game.dart';
import 'package:projet_dev_mobile/src/1_Joueur/Quizz/Game5/game.dart';
import 'package:projet_dev_mobile/src/1_Joueur/Quizz/Game6/Question_screen.dart';
import 'package:projet_dev_mobile/src/1_Joueur/Sensor/Game4/game.dart';
import 'package:projet_dev_mobile/src/multiJoueurs/Bluetooth/BluetoothDiscovery.dart';
import 'package:projet_dev_mobile/src/GameSelection2.dart';
import 'package:projet_dev_mobile/src/Home/Morpion.dart';
import 'package:projet_dev_mobile/src/1_Joueur/Movement/Game1/game.dart';
import 'package:projet_dev_mobile/src/multiJoueurs/Bluetooth/BluetoothSelectionScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mysterius',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple.shade900),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AnotherScreen()),
                );
              },
              child: const Text('1 Player'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Launch Bluetooth discovery for 2 players
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => BluetoothSelectionScreen()),
                );
              },
              child: const Text('2 Players'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MoreOptionsScreen()),
                );
              },
              child: const Text('All Games'),
            ),
          ],
        ),
      ),
    );
  }
}


class AnotherScreen extends StatelessWidget {
  const AnotherScreen({Key? key});
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('1 Joueur'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TicTacToeDisplay()),
                );
              },
              child: const Text('Tic Tac Toe'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Tap()), 
                );
              },
              child: const Text('Color Tap '),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  AirHockey()), 
                );
              },
              child: const Text('Angle Tilt'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Accel()), 
                );
              },
              child: const Text('Accel'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  Math()), 
                );
              },
              child: const Text('Math Quiz'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  HomeQuizzScreen()), 
                );
              },
              child: const Text('General Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}

// New class for "More Options" buttons
class MoreOptionsScreen extends StatelessWidget {
  const MoreOptionsScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('1 Joueur'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                startGameSequence(context);
              },
              child: const Text('Start Games Sequence'),
            ),
          ],
        ),
      ),
    );
  }
}

void startGameSequence(BuildContext context) {
  String game1 = getRandomGame1();
  String game2 = getRandomGame2();
  String game3 = getRandomGame3();

  // Launch the games in sequence
  navigateToGame(context, game1, () {
    navigateToGame(context, game2, () {
      navigateToGame(context, game3, () {
        // After all games are completed, navigate back to the Home screen
        Navigator.popUntil(context, ModalRoute.withName('/'));
      });
    });
  });
}

void navigateToGame(BuildContext context, String gameName, Function() onComplete) {
  Widget gameWidget = getGameWidget(gameName);
  Navigator.push(context, MaterialPageRoute(builder: (context) => gameWidget))
    .then((_) {
      // Execute the onComplete callback when the game is completed
      onComplete();
    });
}

Widget getGameWidget(String gameName) {
  switch (gameName) {
    case 'Tic':
      return TicTacToeDisplay();
    case 'Air':
      return AirHockey();
    case 'Color':
      return Tap();
    case 'Math':
      return Math();
    case 'General':
      return HomeQuizzScreen();
    case 'Accel':
      return Accel();
    default:
      throw Exception('Invalid game name');
  }
}

String getRandomGame1() {
  List<String> movementGames = ['Tic', 'Air'];
  if (movementGames.isNotEmpty) {
    return movementGames[Random().nextInt(movementGames.length)];
  } else {
    throw Exception('No movement games available');
  }
}

String getRandomGame2() {
  List<String> sensorGames = ['Accel'];
  if (sensorGames.isNotEmpty) {
    return sensorGames[Random().nextInt(sensorGames.length)];
  } else {
    throw Exception('No sensor games available');
  }
}

String getRandomGame3() {
  List<String> quizGames = ['Math', 'General'];
  if (quizGames.isNotEmpty) {
    return quizGames[Random().nextInt(quizGames.length)];
  } else {
    throw Exception('No quiz games available');
  }
}
