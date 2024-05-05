import 'package:flutter/material.dart';

class BallWidget extends StatelessWidget {
  final double xPosition;
  final double yPosition;
  final double radius;

  const BallWidget({
    super.key,
    required this.xPosition,
    required this.yPosition,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 2 * radius,
      height: 2 * radius,
      decoration: const BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
      ),
      child: const Center(
        child: Text(
          'Ball',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}