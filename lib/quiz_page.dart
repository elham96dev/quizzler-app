import 'package:flutter/material.dart';

import 'main.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final List<Icon> scoreKeeper = [];

  void checkAnswer(bool userChoice) {
    final bool correctAnswer = quizList.getQuestionAnswer();

    setState(() {
      scoreKeeper.add(
        Icon(
          userChoice == correctAnswer ? Icons.check : Icons.close,
          color: userChoice == correctAnswer ? Colors.green : Colors.red,
        ),
      );

      if (quizList.isFinished()) {
        _showFinishDialog();
      } else {
        quizList.nextQuestion();
      }
    });
  }

  void _showFinishDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Quiz Finished'),
        content: const Text('What would you like to do?'),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                quizList.reset();
                scoreKeeper.clear();
              });
            },
          ),
          TextButton(
            child: const Text('Restart'),
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                quizList.reset();
                scoreKeeper.clear();
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// QUESTION
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Text(
                quizList.getQuestionText(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),

        /// TRUE BUTTON
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () => checkAnswer(true),
              child: const Text(
                'True',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ),

        /// FALSE BUTTON
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () => checkAnswer(false),
              child: const Text(
                'False',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ),

        /// SCORE ICONS
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: scoreKeeper),
        ),
      ],
    );
  }
}
