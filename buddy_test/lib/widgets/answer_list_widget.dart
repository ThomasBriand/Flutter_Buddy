import 'package:flutter/material.dart';
import '../models/question.dart';

class AnswerListWidget extends StatelessWidget {
  final List<Question> myQuestions;

  AnswerListWidget({required this.myQuestions});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: myQuestions.length,
      itemBuilder: (context, index) {
        final question = myQuestions[index];
        return ListTile(
          title: Text('Question #' + question.number.toString() + ': ' + question.question),
          subtitle: Text('Answer: ' + (question.answer ?? 'No answer')),
        );
      },
    );
  }
}
