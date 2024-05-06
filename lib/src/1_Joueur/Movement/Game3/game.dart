import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

void main() {
  runApp(AirHockey());
}

class AirHockey extends StatefulWidget {
  @override
  _AirHockeyState createState() => _AirHockeyState();
}

class _AirHockeyState extends State<AirHockey> {
  double playerOneXOffset = 0;
  double playerTwoXOffset = 0;
  Alignment ballDirection = Alignment.topRight;
  double speed = 0.03; // Initial speed
  late Offset ballPosition = Offset.zero;
  late Timer timer;
  late Size size;
  int player1points = 0;
  int player2points = 0;
  bool _disposed = false;

  void timerFunction(Timer t) {
    if (_disposed) return;

    Offset moveOffset = Offset(
      speed * size.width * ballDirection.x,
      speed * size.width * ballDirection.y,
    );
    Offset endOffset = ballPosition + moveOffset;
    if (endOffset.dx < 20) {
      ballDirection = Alignment(1, ballDirection.y);
      endOffset = Offset(20 + (20 - endOffset.dx), endOffset.dy);
      speed *= 1.05;
    } else if (endOffset.dx + 40 > size.width) {
      ballDirection = Alignment(-1, ballDirection.y);
      endOffset = Offset(
        size.width - (endOffset.dx - size.width),
        endOffset.dy,
      );
      speed *= 1.05;
    }
    if (endOffset.dy < 70) {
      double temp = (ballPosition.dy - 70) / (ballPosition.dy - endOffset.dy);
      Offset tempOffset = ballPosition + moveOffset.scale(temp, temp);
      if (playerOneXOffset < tempOffset.dx &&
          playerOneXOffset + size.width / 3 > tempOffset.dx) {
        ballDirection = Alignment(ballDirection.x, 1);
        endOffset = Offset(endOffset.dx, 70 + (70 - endOffset.dy));
        speed *= 1.025;
      } else {
        player2points += 1;
        speed = 0.02;
        if (player2points == 5) {
          timer.cancel();
          showGameOverDialog();
          return;
        }
        ballPosition = Offset(size.width / 2, size.height / 2);
        speed = 0.02; // Reset speed
        Future.delayed(Duration(seconds: 4), initTimer);
      }
    } else if (endOffset.dy > size.height - 70) {
      double temp = (size.height - 70 - ballPosition.dy) /
          (endOffset.dy - ballPosition.dy);
      Offset tempOffset = ballPosition + moveOffset.scale(temp, temp);

      if (playerTwoXOffset < tempOffset.dx &&
          playerTwoXOffset + size.width / 3 > tempOffset.dx) {
        ballDirection = Alignment(ballDirection.x, -1);
        endOffset = Offset(
          endOffset.dx,
          size.height - 70 - (size.height - 70 + endOffset.dy),
        );
        speed *= 1.025;
      } else {
        player1points += 1;
        speed = 0.02;
        if (player1points == 5) {
          timer.cancel();
          showGameOverDialog();
          return;
        }
        ballPosition = Offset(size.width / 2, size.height / 2);
        speed = 0.02; // Reset speed
        Future.delayed(Duration(seconds: 4), initTimer);
      }
    }
    if (!_disposed) {
      setState(() {
        ballPosition += moveOffset;
      });
    }
  }

  void showGameOverDialog() {
    String winner;
    if (player1points == player2points) {
      winner = "It's a tie!";
    } else if (player1points > player2points) {
      winner = "Player 1 wins!";
    } else {
      winner = "Player 2 wins!";
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Game Over'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Player 1: $player1points points'),
              Text('Player 2: $player2points points'),
              Text(winner),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Restart'),
              onPressed: () {
                if (!_disposed) {
                  Navigator.of(context).pop();
                  restartGame();
                }
              },
            ),
            ElevatedButton(
              child: Text('Go back'),
              onPressed: () {
                if (!_disposed) {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop(); // Dismiss the dialog
                }
              },
            ),
          ],
        );
      },
    );
  }

  void restartGame() {
    setState(() {
      player1points = 0;
      player2points = 0;
      playerOneXOffset = 0;
      playerTwoXOffset = 0;
      ballPosition = Offset(size.width / 2, size.height / 2);
      ballDirection = Alignment.topRight;
      speed = 0.02;
    });
    initTimer();
  }

  void initTimer() {
    if (!_disposed) {
      timer = Timer.periodic(Duration(milliseconds: 50), timerFunction);
    }
  }

  @override
  void initState() {
    super.initState();
    initTimer();
  }

  @override
  void dispose() {
    _disposed = true;
    timer.cancel();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
    double screenWidth = size.width;
    double screenHeight = size.height;
    if (ballPosition == null) {
      ballPosition = Offset(screenWidth / 2, screenHeight / 2);
    }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment(0, -0.5),
            child: Transform.rotate(
              angle: math.pi,
              child: Text(
                '$player1points',
                style: TextStyle(fontSize: 60, color: Colors.yellow),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, 0.5),
            child: Text(
              '$player2points',
              style: TextStyle(fontSize: 60, color: Colors.yellow),
            ),
          ),
          Positioned(
            width: size.width / 3,
            height: 30,
            left: playerOneXOffset,
            top: 40,
            child: GestureDetector(
              child: Container(
                color: Colors.red,
              ),
            ),
          ),
          Positioned(
            width: size.width / 3,
            height: 30,
            left: playerTwoXOffset,
            bottom: 40,
            child: GestureDetector(
              child: Container(
                color: Colors.red,
              ),
            ),
          ),
          Positioned(
            left: ballPosition.dx - 20,
            top: ballPosition.dy - 20,
            width: 40,
            height: 40,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            height: size.height / 2,
            child: GestureDetector(
              onHorizontalDragUpdate: (dragUpdateDetails) {
                setState(() {
                  playerOneXOffset += dragUpdateDetails.delta.dx;
                });
              },
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: size.height / 2,
            child: GestureDetector(
              onHorizontalDragUpdate: (dragUpdateDetails) {
                setState(() {
                  playerTwoXOffset += dragUpdateDetails.delta.dx;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
