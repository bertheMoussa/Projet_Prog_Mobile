import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:projet_dev_mobile/src/GamePlaying2.dart';

class GameSelectionScreen extends StatefulWidget {
  final BluetoothDevice device;

  const GameSelectionScreen({super.key, required this.device});

  @override
  _GameSelectionScreenState createState() => _GameSelectionScreenState();
}

class _GameSelectionScreenState extends State<GameSelectionScreen> {
  List<String> selectedGames = [];
  Map<String, List<String>> gameCategories = {
    'Movement': ['Tic Tac Toe', 'Air Hockey'],
    'Sensor': ['Game 3', 'Game 4'],
    'Quizz': ['Game 5', 'Game 6']
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Selection'),
      ),
      body: ListView.builder(
        itemCount: gameCategories.length,
        itemBuilder: (context, index) {
          String category = gameCategories.keys.elementAt(index);
          List<String> categoryGames = gameCategories[category]!;
          return ExpansionTile(
            title: Text(category),
            children: _buildCategoryGames(category, categoryGames),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _startPlayingGames,
        child: const Icon(Icons.play_arrow),
      ),
    );
  }

  List<Widget> _buildCategoryGames(String category, List<String> categoryGames) {
    return categoryGames.map((game) {
      return CheckboxListTile(
        title: Text(game),
        value: selectedGames.contains(game),
        onChanged: (value) {
          setState(() {
            if (value!) {
              selectedGames.add(game);
            } else {
              selectedGames.remove(game);
            }
          });
        },
      );
    }).toList();
  }

  void _startPlayingGames() {
    // Navigate to the game playing screen with selected games and Bluetooth device
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => GamePlayingScreen(selectedGames: selectedGames, device: widget.device)),
    );
  }
}