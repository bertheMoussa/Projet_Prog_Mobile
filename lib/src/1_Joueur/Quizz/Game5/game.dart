import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(Math());
}

class Math extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Math Quiz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentQuestion = 0;
  int _score = 0;
  int _lives = 5;
  TextEditingController _answerController = TextEditingController();
  late Timer _timer;
  int _secondsRemaining = 30;
  late Map<String, dynamic> _questionData;

  @override
  void initState() {
    super.initState();
    _generateNewQuestion();
    _startTimer();
  }

  @override
  void dispose() {
    _answerController.dispose();
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _timer.cancel();
          _endGame();
        }
      });
    });
  }

  void _generateNewQuestion() {
    _questionData = _generateQuestion();
  }

  void _nextQuestion() {
    _generateNewQuestion();
    setState(() {
      _currentQuestion++;
      if (_currentQuestion >= 5) {
        _currentQuestion = 0;
      }
    });
    _answerController.clear(); // Clear answer field
  }

  void _checkAnswer(int answer, int correctAnswer) {
    if (answer == correctAnswer) {
      setState(() {
        _score++;
      });
    } else {
      setState(() {
        _lives--;
      });
    }
    _nextQuestion();
  }

  void _endGame() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Game Over"),
          content: Text("Your final score: $_score"),
          actions: <Widget>[
            TextButton(
              child: Text("Restart"),
              onPressed: () {
                Navigator.of(context).pop();
                _resetGame();
              },
            ),
          ],
        );
      },
    );
  }

  void _resetGame() {
    setState(() {
      _currentQuestion = 0;
      _score = 0;
      _lives = 5;
      _secondsRemaining = 60;
    });
    _generateNewQuestion();
    _startTimer();
  }

  Map<String, dynamic> _generateQuestion() {
  int num1 = Random().nextInt(50) + 1;
  int num2 = Random().nextInt(50) + 1;
  int operation = Random().nextInt(4);
  String operationText = '';
  int correctAnswer = 0;

  switch (operation) {
    case 0:
      operationText = '+';
      correctAnswer = num1 + num2;
      break;
    case 1:
      operationText = '-';
      correctAnswer = num1 - num2;
      break;
    case 2:
      operationText = '×';
      correctAnswer = num1 * num2;
      break;
    case 3:
      operationText = '÷';
      // Ensure divisor is not 0
      while (num2 == 0) {
        num2 = Random().nextInt(50) + 1;
      }
      correctAnswer = (num1 ~/ num2); // Cast to integer
      break;
  }

  return {'question': 'What is $num1 $operationText $num2?', 'answer': correctAnswer};
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Math Quiz'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Time left: $_secondsRemaining seconds'),
            SizedBox(height: 20),
            Text('Lives: $_lives'),
            SizedBox(height: 20),
            Text('Question ${_currentQuestion + 1}'),
            SizedBox(height: 20),
            Text(_questionData['question']),
            SizedBox(height: 20),
            TextField(
              controller: _answerController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                // _checkAnswer(int.parse(value), 42); // Provide the correct answer here
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                int answer = _answerController.text.isEmpty ? 0 : int.parse(_answerController.text);
                _checkAnswer(answer, _questionData['answer']);
              },
              child: Text('Confirm'),
            ),
            SizedBox(height: 20),
            Text('Score: $_score'),
          ],
        ),
      ),
    );
  }
}