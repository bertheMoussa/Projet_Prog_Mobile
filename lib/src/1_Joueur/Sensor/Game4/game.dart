import 'dart:async';
import 'dart:math' as math;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

void main() {
  runApp(const MaterialApp(
    home: Accel(),
  ));
}

class Accel extends StatelessWidget {
  const Accel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accelerometer Ball Game'),
      ),
      body: AccelerometerBallGame(),
    );
  }
}

class AccelerometerBallGame extends StatefulWidget {
  const AccelerometerBallGame({Key? key}) : super(key: key);

  @override
  _AccelerometerBallGameState createState() => _AccelerometerBallGameState();
}

class _AccelerometerBallGameState extends State<AccelerometerBallGame> {
  late math.Point<double> ballPosition = math.Point<double>(0, 0);
  late StreamSubscription<AccelerometerEvent> _streamSubscription;
  static const double ballRadius = 20.0;
  late math.Point<double> blackSpotPosition = _generateRandomBlackSpot();

  int score = 0;
  Stopwatch stopwatch = Stopwatch();
  late Timer timer;
  int remainingTime = 30;
  int passedBlackSpots = 0;

  @override
  void initState() {
    super.initState();
    // Initialize ballPosition at the center of the screen
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {
        final screenWidth = MediaQuery.of(context).size.width;
        final screenHeight = MediaQuery.of(context).size.height;
        ballPosition = math.Point(screenWidth / 2, screenHeight / 2);
      });
    });

    _startAccelerometerUpdates();

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingTime > 0) {
          remainingTime--;
        } else {
          timer.cancel();
          _streamSubscription.cancel();
          _showGameOverDialog();
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Stack(
            children: [
              if (ballPosition != null)
                Positioned(
                  left: ballPosition.x - ballRadius,
                  top: ballPosition.y - ballRadius,
                  child: Container(
                    width: ballRadius * 2,
                    height: ballRadius * 2,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                  ),
                ),
              if (blackSpotPosition != null)
                Positioned(
                  left: blackSpotPosition.x - ballRadius,
                  top: blackSpotPosition.y - ballRadius,
                  child: Container(
                    width: ballRadius * 2,
                    height: ballRadius * 2,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.yellow,
                    ),
                  ),
                ),
            ],
          ),
        ),
        Text(
          'Score: $passedBlackSpots',
          style: TextStyle(fontSize: 20),
        ),
        Text(
          'Time Left: $remainingTime',
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }

  math.Point<double> _constrainBallPosition(
      math.Point<double> position, BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    // Ensure the ball stays within the screen boundaries
    double x = position.x.clamp(ballRadius, screenWidth - ballRadius);
    double y = position.y.clamp(ballRadius, screenHeight - ballRadius) / 1.10;
    return math.Point(x, y);
  }

  bool _checkCollision() {
    double distance = math.sqrt(math.pow(ballPosition.x - blackSpotPosition.x, 2) +
        math.pow(ballPosition.y - blackSpotPosition.y, 2));
    return distance <= (ballRadius + ballRadius); // Sum of ball radius and black spot radius
  }

  static math.Point<double> _generateRandomBlackSpot() {
    final Random random = Random();
    final screenWidth = 400.0; // Change this to your screen width
    final screenHeight = 600.0; // Change this to your screen height
    double x = random.nextDouble() * screenWidth;
    double y = random.nextDouble() * screenHeight;
    return math.Point(x, y);
  }

  void _showGameOverDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Game Over'),
          content: Text('You passed $passedBlackSpots black spots.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _restartGame();
              },
              child: Text('Restart'),
            ),
            TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop(); // Pop twice to go to the previous page
            },
            child: Text('Go Back'),
          ),
          ],
        );
      },
    );
  }

  void _restartGame() {
    setState(() {
      passedBlackSpots = 0;
      remainingTime = 30;
      blackSpotPosition = _generateRandomBlackSpot();
    });

    _startAccelerometerUpdates();

    // Restart the timer
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingTime > 0) {
          remainingTime--;
        } else {
          timer.cancel();
          _streamSubscription.cancel();
          _showGameOverDialog();
        }
      });
    });
  }

  void _startAccelerometerUpdates() {
    _streamSubscription = accelerometerEvents.listen((event) {
      setState(() {
        // Update ball position based on accelerometer input
        const double velocity = 10; // Adjust the velocity as needed
        ballPosition += math.Point(-event.x * velocity, event.y * velocity);
        // Ensure the ball stays within the screen boundaries
        ballPosition = _constrainBallPosition(ballPosition, context);

        // Check if the ball passes over the black spot
        if (_checkCollision()) {
          // Calculate the time taken by the player
          passedBlackSpots++;
          // Generate a new random black spot
          blackSpotPosition = _generateRandomBlackSpot();
        }
      });
    });
  }
}
