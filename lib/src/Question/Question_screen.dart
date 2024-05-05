import 'package:flutter/material.dart';
import 'package:projet_dev_mobile/src/Question/Question_Model.dart';
import 'package:projet_dev_mobile/src/Question/db_connect.dart';
import 'package:projet_dev_mobile/src/Question/next_button.dart';
import 'package:projet_dev_mobile/src/Question/option_card.dart';
import 'package:projet_dev_mobile/src/Question/question_widget.dart';
import 'package:projet_dev_mobile/src/Question/result_box.dart';
import 'package:projet_dev_mobile/src/constant.dart';
import 'dart:math'; // Importez la classe Random
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  int index = 0;
  int score = 0;
  int iter=0;
  bool isPressed = false;
  bool isAlreadySelected = false;

  
List<Question> _getRandomQuestions(List<Question> allQuestions, int count) {
    List<Question> randomQuestions = [];
    List<int> indexes = [];

    while (randomQuestions.length < count) {
      int randomIndex = Random().nextInt(allQuestions.length);
      if (!indexes.contains(randomIndex)) {
        indexes.add(randomIndex);
        randomQuestions.add(allQuestions[randomIndex]);
      }
    }

    return randomQuestions;
  }

  void nextQuestion(int questionLength) {
    if (index == questionLength - 1) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => ResultBox(
          result: score,
          questionLength: questionLength,
          onPressed: startOver,
        ),
      );
    } else {
      setState(() {
        index++; // Mettez à jour l'index avec l'index aléatoire
        isPressed = false;
        isAlreadySelected = false;
      });
    }
  }

  void checkAnswerAndUpdate(bool value) {
    if (isAlreadySelected) {
      return;
    } else {
      if (value == true) {
        score++;
      }
      setState(() {
        isPressed = true;
        isAlreadySelected = true;
      });
    }
  }

  void startOver() {
    setState(() {
      index = 0;
      score = 0;
      isPressed = false;
      isAlreadySelected = false;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    List<Question> randomQuestions = _getRandomQuestions(questions, 10);    
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text('Quiz App'),
        backgroundColor: background,
        shadowColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              'Score: $score',
              style: const TextStyle(fontSize: 18.0),
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            QuestionWidget(
              indexAction: index,
              question: questions[index].title,
              totalQuestions: questions.length,
            ),
            const Divider(color: neutral),
            const SizedBox(height: 25.0),
            for (int i = 0; i < questions[index].options.length; i++)
              GestureDetector(
                onTap: () =>
                    checkAnswerAndUpdate(questions[index].options.values.toList()[i]),
                child: OptionCard(
                  option: questions[index].options.keys.toList()[i],
                  color: isPressed
                      ? questions[index].options.values.toList()[i] == true
                          ? correct
                          : incorrect
                      : neutral,
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () => nextQuestion(10),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: NextButton(),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
