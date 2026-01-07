import 'package:flutter/material.dart';
import 'package:quizzler/result_page.dart';

import 'main.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final List<Icon> scoreKeeper = [];
  int trueCount = 0;
  int falseCount = 0;

  void checkAnswer(bool userChoice) {
    final bool correctAnswer = quizList.getQuestionAnswer();

    setState(() {
      if (userChoice == correctAnswer) {
        trueCount++; // ✅ increment correct answers
      } else {
        falseCount++; // ✅ increment wrong answers
      }

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
      builder: (dialogContext) => AlertDialog(
        title: const Text('Quiz Finished'),
        content: const Text('What would you like to do?'),
        actions: [
          TextButton(
            child: const Text('Result'),
            onPressed: () {
              // 1️⃣ Close dialog
              Navigator.pop(dialogContext);

              // 2️⃣ Navigate with CORRECT values
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ResultPage(
                    trueCount: trueCount,
                    falseCount: falseCount,
                    avgCount: calculateAvg(
                        trueCount, falseCount, quizList.getQuestionCount()),
                  ),
                ),
              ).then((_) {
                // 3️⃣ Reset AFTER returning
                setState(() {
                  quizList.reset();
                  scoreKeeper.clear();
                  trueCount = 0;
                  falseCount = 0;
                });
              });
            },
          ),
          TextButton(
            child: const Text('Restart'),
            onPressed: () {
              Navigator.pop(dialogContext);
              setState(() {
                quizList.reset();
                scoreKeeper.clear();
                trueCount = 0;
                falseCount = 0;
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

double calculateAvg(int trueCount, int falseCount, int totalCount) {
  double avg = (trueCount - falseCount) / totalCount;
  return double.parse(avg.toStringAsFixed(1));
}
