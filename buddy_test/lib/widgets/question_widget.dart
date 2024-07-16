import 'package:flutter/material.dart';
import '../models/question.dart';

class QuestionWidget extends StatelessWidget {
  final Question question;
  final TextEditingController controller;

  QuestionWidget({required this.question, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Question #' + question.number.toString() + ': ' + question.question,
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 20),
          Container(
            width: 270,
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Your Answer',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
