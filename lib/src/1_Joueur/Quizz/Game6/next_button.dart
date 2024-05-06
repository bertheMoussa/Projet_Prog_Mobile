import 'package:flutter/material.dart';
import 'package:projet_dev_mobile/src/1_Joueur/Quizz/Game6/constant.dart';

class NextButton extends StatelessWidget {
  const NextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: neutral,
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: const Text(
        'Next Question',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18.0),
      ),
    );
  }
}