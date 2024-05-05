import 'package:flutter/material.dart';
import 'package:projet_dev_mobile/src/1_Joueur/Quizz/Game5/game.dart';
import 'package:projet_dev_mobile/src/1_Joueur/Sensor/Game3/game.dart';
import 'package:projet_dev_mobile/src/BluetoothDiscovery.dart';
import 'package:projet_dev_mobile/src/GameSelection2.dart';
import 'package:projet_dev_mobile/src/Home/Morpion.dart';
import 'package:projet_dev_mobile/src/1_Joueur/Movement/Game1/game.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
  const HomeScreen({super.key});

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
                  MaterialPageRoute(builder: (context) => BluetoothDiscovery(
                    onConnect: (device) {
                      // After connecting, navigate to game selection screen
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => GameSelectionScreen(device: device)),
                      );
                    },
                  )),
                );
              },
              child: const Text('2 Players'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to more options screen or perform any other action
              },
              child: const Text('More Options'),
            ),
          ],
        ),
      ),
    );
  }
}


class AnotherScreen extends StatelessWidget {
  const AnotherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More Options'),
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
                  MaterialPageRoute(builder: (context) =>  Tap()), // Launch AirHockey game
                );
              },
              child: const Text('Color Tap '),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add functionality for other buttons
              },
              child: const Text('Angle Tilt'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  Accel()), // Launch AirHockey game
                );
              },
              child: const Text('Accel'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  Math()), // Launch AirHockey game
                );
              },
              child: const Text('Math Quiz'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add functionality for other buttons
              },
             child: const Text('General Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}