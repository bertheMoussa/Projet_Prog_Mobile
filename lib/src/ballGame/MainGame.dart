import 'dart:async';

import 'package:flutter/material.dart';
import 'package:projet_dev_mobile/src/ballGame/Bounderies.dart';
import 'package:sensors_plus/sensors_plus.dart';

class MyGame extends StatefulWidget {
  const MyGame({super.key});

  @override
  _MyGameState createState() => _MyGameState();
}

class _MyGameState extends State<MyGame> {
  double _ballPositionX = 0.0; // Initialize ball positions
  final double _ballPositionY = 0.0; // Initialize ball positions
  late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;

  @override
  void initState() {
    super.initState();

    // Start listening to accelerometer events
    _accelerometerSubscription = accelerometerEvents.listen((event) {
      setState(() {
        // Update ball position based on accelerometer data (adjust sensitivity as needed)
        _ballPositionX += event.x * 0.1; // Example: move ball 0.1 units on X-axis per unit of acceleration
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _accelerometerSubscription.cancel(); // Stop listening to events when widget is disposed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accelerometer Game'),
      ),
      body: Center(
        child: BoundariesWidget(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - kToolbarHeight,
          xPosition: _ballPositionX,
          yPosition: _ballPositionY,
        ),
      ),
    );
  }
}
