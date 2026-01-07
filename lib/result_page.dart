import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final int trueCount;
  final int falseCount;
  final double avgCount;

  const ResultPage({
    super.key,
    required this.trueCount,
    required this.falseCount,
    required this.avgCount,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade900,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade900,
          elevation: 10.0,
          shadowColor: Colors.black,
          title: Text(
            'Result',
            style: TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.bold,
              fontSize: 26,
            ),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.white70,
            size: 26,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _tile(
                Icons.check_circle,
                'Correct Answers',
                trueCount,
                Colors.green,
              ),
              const SizedBox(height: 20),
              _tile(
                Icons.cancel,
                'Wrong Answers',
                falseCount,
                Colors.red,
              ),
              const SizedBox(height: 20),
              _tile(
                Icons.star,
                'Average',
                avgCount,
                Colors.yellow,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tile(
    IconData icon,
    String title,
    dynamic value,
    Color color,
  ) {
    return Card(
      color: Colors.grey.shade800,
      child: ListTile(
        leading: Icon(
          icon,
          color: color,
          size: 30,
        ),
        title: Text(title,
            style: TextStyle(
              color: Colors.white,
            )),
        trailing: Text(
          value.toString(),
          style: TextStyle(
            color: color,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
