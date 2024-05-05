import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

void main() {
  runApp(Tap());
}

class Tap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Color Tapping Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ColorTappingGame(),
    );
  }
}

class ColorTappingGame extends StatefulWidget {
  @override
  _ColorTappingGameState createState() => _ColorTappingGameState();
}

class _ColorTappingGameState extends State<ColorTappingGame> {
  List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.pink,
    Colors.indigo,
    Colors.amber,
  ];

  List<Color> displayedColors = [];
  Color targetColor = Colors.white;
  int score = 0;
  int startingPoints = 10;
  int maxColors = 35;
  int timerDuration = 5;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startGame() {
    setState(() {
      score = 0;
      startingPoints = 10;
      timerDuration = 5;
      displayedColors = [];
    });
    _timer?.cancel();
    generateColors();
    startTimer();
  }

  void generateColors() {
    displayedColors.clear();
    Random random = Random();
    int colorsCount = min(score + 2, maxColors);
    for (int i = 0; i < colorsCount; i++) {
      int index = random.nextInt(colors.length);
      displayedColors.add(colors[index]);
    }
    targetColor = displayedColors[random.nextInt(displayedColors.length)];
  }

  void onTapColor(Color color) {
    if (color == targetColor) {
      setState(() {
        score++;
      });
      generateColors();
    } else {
      setState(() {
        startingPoints--;
        if (startingPoints <= 0) {
          _timer?.cancel();
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Game Over"),
                content: Text("Your score: $score"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      startGame();
                    },
                    child: Text("Play Again"),
                  ),
                ],
              );
            },
          );
        }
      });
    }
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (timerDuration > 0 && startingPoints > 0) {
          timerDuration--;
        } else {
          timer.cancel();
          if (timerDuration <= 0 || startingPoints <= 0) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Game Over"),
                  content: Text("Your score: $score"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        startGame();
                      },
                      child: Text("Play Again"),
                    ),
                  ],
                );
              },
            );
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Color Tapping Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Tap on: ',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(10),
              color: targetColor,
              child: Text(
                '${targetColor.toString().split('(0x')[1].split(')')[0]}',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: displayedColors
                  .map(
                    (color) => GestureDetector(
                      onTap: () => onTapColor(color),
                      child: Container(
                        width: 50,
                        height: 50,
                        color: color,
                      ),
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: 20),
            Text(
              'Score: $score',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'Starting Points: $startingPoints',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'Time left: $timerDuration seconds',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
