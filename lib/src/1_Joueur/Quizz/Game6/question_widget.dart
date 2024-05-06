import 'package:flutter/material.dart';
import 'package:projet_dev_mobile/src/1_Joueur/Quizz/Game6/constant.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget(
      {super.key,
      required this.question,
      required this.indexAction,
      required this.totalQuestions});
  // here we need the question title and the total number of questions, and also the index

  final String question;
  final int indexAction;
  final int totalQuestions;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        'Question: $question',
        style: const TextStyle(
          fontSize: 24.0,
          color: neutral,
        ),
      ),
    );
  }
}