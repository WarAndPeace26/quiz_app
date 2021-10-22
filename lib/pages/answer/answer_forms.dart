import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/utilities/data-classes/quiz.dart';

class AnswerForm extends StatefulWidget {
  const AnswerForm({
    Key? key,
    required this.quiz
  }) : super(key: key);

  final Quiz quiz;
  @override
  _AnswerFormState createState() => _AnswerFormState();
}

class _AnswerFormState extends State<AnswerForm> {
  int _pageNum = 0;
  UniqueKey _formKey = UniqueKey();
  List<String> answers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
            child: showQuestion(widget.quiz.questions[_pageNum])
        ),
      ),
    );
  }

  Widget showQuestion(Question question){
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            question.statement,
            style: const TextStyle(
              fontSize: 30,
            ),
          ),

        ],
      ),
    );
  }
}
