import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class GamePlayingScreen extends StatefulWidget {
  final List<String> selectedGames;
  final BluetoothDevice device;

  const GamePlayingScreen({super.key, required this.selectedGames, required this.device});

  @override
  _GamePlayingScreenState createState() => _GamePlayingScreenState();
}

class _GamePlayingScreenState extends State<GamePlayingScreen> {
  int currentGameIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Playing Game ${currentGameIndex + 1}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Playing ${widget.selectedGames[currentGameIndex]}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Simulate playing the current game
                _simulateGame();
              },
              child: const Text('Next Game'),
            ),
          ],
        ),
      ),
    );
  }

  void _simulateGame() {
    // Simulate playing the current game
    if (currentGameIndex < widget.selectedGames.length - 1) {
      setState(() {
        currentGameIndex++;
      });
    } else {
      // All games have been played, navigate back to the home screen
      Navigator.popUntil(context, ModalRoute.withName('/'));
    }
  }
}
