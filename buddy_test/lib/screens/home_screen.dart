import 'package:flutter/material.dart';
import '../models/question.dart';
import '../widgets/question_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Question> myQuestions = [
    Question(question: "What is your favorite food?", number: 1),
    Question(question: "What is your favorite startup?", number: 2),
    Question(question: "What is your favorite student?", number: 3),
    Question(question: "What is your favorite game?", number: 4),
  ];

  int currentIndex = 0;
  bool showAnswers = false;
  List<TextEditingController> controllers = [];

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _addListenersToControllers();
  }

  void _initializeControllers() {
    controllers = myQuestions.map((_) => TextEditingController()).toList();
  }

  void _addListenersToControllers() {
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
    _disposeControllers();
    super.dispose();
  }

  void _disposeControllers() {
    for (var controller in controllers) {
      controller.dispose();
    }
  }

  void _nextQuestion() {
    if (currentIndex < myQuestions.length - 1) {
      setState(() {
        currentIndex++;
      });
    } else {
      setState(() {
        showAnswers = true;
      });
    }
  }

  void _previousQuestion() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
    }
  }

  void _backToQuestions() {
    setState(() {
      showAnswers = false;
      currentIndex = 0;
    });
  }

  Widget _questionView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        QuestionWidget(
          question: myQuestions[currentIndex],
          controller: controllers[currentIndex],
        ),
        _buildNavigationButtons(),
      ],
    );
  }

  Widget _buildNavigationButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: _previousQuestion,
          child: Text('Previous'),
        ),
        ElevatedButton(
          onPressed: _nextQuestion,
          child: Text(currentIndex == myQuestions.length - 1 ? 'See result' : 'Next'),
        ),
      ],
    );
  }

  Widget _displayAnswers() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: myQuestions.length,
            itemBuilder: (context, index) {
              final question = myQuestions[index];
              return ListTile(
                title: Text('Question #' + question.number.toString() + ': ' + question.question),
                subtitle: Text('Answer: ' + (question.answer ?? 'No answer')),
              );
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: ElevatedButton(
            onPressed: _backToQuestions,
            child: Text('Back to Questions'),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Questionnaire Buddy'),
      ),
      body: showAnswers ? _displayAnswers() : _questionView(),
    );
  }
}
