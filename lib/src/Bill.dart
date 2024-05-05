import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const LabyrinthTilt());
}

class LabyrinthTilt extends StatelessWidget {
  const LabyrinthTilt({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: LabyrinthGame(),
      ),
    );
  }
}

class LabyrinthGame extends StatefulWidget {
  const LabyrinthGame({super.key});

  @override
  _LabyrinthGameState createState() => _LabyrinthGameState();
}

class _LabyrinthGameState extends State<LabyrinthGame> {
  double ballX = 0;
  double ballY = 0;
  double holeX = 0;
  double holeY = 0;
  int score = 0;

  @override
  void initState() {
    super.initState();
    resetGame();
  }

  void resetGame() {
    setState(() {
      ballX = Random().nextDouble() * 400;
      ballY = Random().nextDouble() * 400;
      holeX = Random().nextDouble() * 400;
      holeY = Random().nextDouble() * 400;
      score = 0;
    });
  }

  void moveBall(double x, double y) {
    setState(() {
      ballX += x * 10;
      ballY += y * 10;

      if (ballX < 0) ballX = 0;
      if (ballX > 400) ballX = 400;
      if (ballY < 0) ballY = 0;
      if (ballY > 400) ballY = 400;

      if ((ballX - holeX).abs() < 20 && (ballY - holeY).abs() < 20) {
        score++;
        holeX = Random().nextDouble() * 400;
        holeY = Random().nextDouble() * 400;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        moveBall(details.delta.dx, details.delta.dy);
      },
      child: Stack(
        children: [
          Positioned(
            left: holeX,
            top: holeY,
            child: Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
            ),
          ),
          Positioned(
            left: ballX,
            top: ballY,
            child: Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: Text(
              'Score: $score',
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
