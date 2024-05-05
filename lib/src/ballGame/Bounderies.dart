import 'package:flutter/material.dart';
import 'package:projet_dev_mobile/src/ballGame/BallWidget.dart';

class BoundariesWidget extends StatelessWidget {
  final double width;
  final double height;
  final double xPosition; // Added argument
  final double yPosition; // Added argument


  const BoundariesWidget({
    super.key,
   required this.width,
    required this.height,
    required this.xPosition, // Pass arguments to constructor
    required this.yPosition, // Pass arguments to constructor
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        ),
      ),
      child: Stack(
  children: [
    BallWidget(
      xPosition: xPosition, // Use passed arguments
      yPosition: yPosition, // Use passed arguments
      radius: 20.0,
    ),
  ],
),
    );
  }
}