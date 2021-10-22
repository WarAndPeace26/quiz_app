import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/pages/answer/results.dart';
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
  List<String> answers = [];
  String? answer;

  @override
  Widget build(BuildContext context) {
    print(answers);
    if ((_pageNum<widget.quiz.questions.length)) {
      return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
            "Question ${_pageNum+1}"
        ),
        centerTitle: true,
      ),
      body: Center(
        child: showQuestion(widget.quiz.questions[_pageNum]),
      ),
    );
    } else {
      return ResultPage(quiz:widget.quiz, answers: answers);
    }
  }

  Widget showQuestion(Question question){

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text(
            question.statement,
            style: const TextStyle(
              fontSize: 30,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          for(String option in question.options) ListTile(
            leading: Radio<String>(
              groupValue: answer,
              value: option,
              onChanged: (value){
                setState(() {
                  answer = value;
                });
              },
            ),
            title: Text(
              option,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: (){
              answers.add((answer==null)?"":answer!);
              setState(() {
                _pageNum+=1;
                answer = "";
              });
            },
            child: const Text(
              "next"
            ),
          ),
        ],
      ),
    );
  }


}
