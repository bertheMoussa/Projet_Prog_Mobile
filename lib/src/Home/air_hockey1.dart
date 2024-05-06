import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

class AirHockey extends StatefulWidget {
  @override
  _AirHockeyState createState() => _AirHockeyState();
}

class _AirHockeyState extends State<AirHockey> {
  double playerOneXOffset = 0;
  double playerTwoXOffset = 0;
  Alignment ballDirection = Alignment.topRight;
  double speed = 3;
  Offset ballPosition = Offset(0, 0);
  Size size = Size(0, 0);
  int player1points = 0;
  int player2points = 0;
  int timerSeconds = 60;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    // Set initial ball position
    ballPosition = Offset(size.width / 2, size.height / 2);
    // Set both players' scores to 0
    player1points = 0;
    player2points = 0;

    timer = Timer.periodic(Duration(milliseconds: 16), (timer) {
      setState(() {
        moveBall();
        handleCollisions();
        updateTimer();
      });
    });
  }

  void moveBall() {
    ballPosition += Offset(speed * ballDirection.x, speed * ballDirection.y);
  }

  void handleCollisions() {
    if (ballPosition.dx < 20 || ballPosition.dx > size.width - 20) {
      ballDirection = Alignment(-ballDirection.x, ballDirection.y);
    }

    if (ballPosition.dy < 70 || ballPosition.dy > size.height - 70) {
      ballDirection = Alignment(ballDirection.x, -ballDirection.y);
    }

    if (ballPosition.dy < 70 &&
        ballPosition.dx >= playerOneXOffset &&
        ballPosition.dx <= playerOneXOffset + size.width / 6) {
      ballDirection = Alignment(ballDirection.x, -ballDirection.y);
    }

    if (ballPosition.dy > size.height - 100 &&
        ballPosition.dx >= playerTwoXOffset &&
        ballPosition.dx <= playerTwoXOffset + size.width / 6) {
      ballDirection = Alignment(ballDirection.x, -ballDirection.y);
    }
  }

  void updateTimer() {
    if (timerSeconds > 0) {
      timerSeconds--;
    } else {
      endGame();
    }
  }

  void endGame() {
    timer.cancel();
    String winner = player1points > player2points ? 'Player 1' : 'Player 2';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Game Over'),
          content: Text('$winner Wins!'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 5,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              right: 0,
              child: Text(
                'Time: $timerSeconds',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
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
              width: size.width / 6 * 1.25,
              height: 30 * 1.25,
              left: playerOneXOffset,
              top: 40,
              child: GestureDetector(
                onHorizontalDragUpdate: (details) {
                  setState(() {
                    playerOneXOffset += details.delta.dx;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            Positioned(
              width: size.width / 6 * 1.25,
              height: 30 * 1.25,
              left: playerTwoXOffset,
              bottom: 40,
              child: GestureDetector(
                onHorizontalDragUpdate: (details) {
                  setState(() {
                    playerTwoXOffset += details.delta.dx;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 70,
              child: Container(
                height: 5,
                color: Colors.black,
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 70,
              child: Container(
                height: 5,
                color: Colors.black,
              ),
            ),
            Positioned(
              left: 0,
              top: 70,
              child: Container(
                width: size.width,
                height: 20,
                color: Colors.black,
                child: Center(
                  child: Container(
                    width: size.width - 40,
                    height: 5,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              bottom: 70,
              child: Container(
                width: size.width,
                height: 20,
                color: Colors.black,
                child: Center(
                  child: Container(
                    width: size.width - 40,
                    height: 5,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 20,
                height: size.height,
                color: Colors.black,
                child: Center(
                  child: Container(
                    width: 5,
                    height: size.height - 140,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                width: 20,
                height: size.height,
                color: Colors.black,
                child: Center(
                  child: Container(
                    width: 5,
                    height: size.height - 140,
                    color: Colors.white,
                  ),
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
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AirHockey(),
  ));
}
