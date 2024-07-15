import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Question {
  String question;
  int number;
  String? answer;

  Question({required this.question, required this.number, this.answer});
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Question> myQuestions = [
    Question(question: "What is your favorite food?", number: 1),
    Question(question: "What is your favorite startup?", number: 2),
    Question(question: "What is your favorite student?", number: 3),
    Question(question: "What is your favorite game?", number: 4),
  ];

  bool showAnswers = false;
  List<TextEditingController> controllers = [];

  @override
  void initState() {
    super.initState();
    controllers = myQuestions.map((_) => TextEditingController()).toList();
    for (int i = 0; i < controllers.length; i++) {
      controllers[i].addListener(() {
        setState(() {
          myQuestions[i].answer = controllers[i].text;
        });
      });
    }
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Questionnaire Buddy'),
        ),
        body: showAnswers ? displayAnswers() : QandA(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              showAnswers = !showAnswers;
            });
          },
          child: Icon(Icons.refresh),
        ),
      ),
    );
  }

  Widget QandA() {
    List<Widget> questionWidgets = List.generate(myQuestions.length, (index) {
      return Column(
        children: <Widget>[
          Text('Question #' + myQuestions[index].number.toString() + ': ' + myQuestions[index].question),
          SizedBox(height: 20),
          Container(
            width: 200,
            child: TextField(
              controller: controllers[index],
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Your Answer',
              ),
            ),
          ),
          SizedBox(height: 40),
        ],
      );
    });

    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: questionWidgets,
        ),
      ),
    );
  }

  Widget displayAnswers() {
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
