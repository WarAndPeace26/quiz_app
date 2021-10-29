import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/pages/answer/results.dart';
import 'package:quiz_app/utilities/data-classes/quiz.dart';
import 'package:quiz_app/utilities/widgets.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:intl/intl.dart';

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
  bool isTimeLeft = true;

  @override
  Widget build(BuildContext context) {
    print(_pageNum);
    if ((_pageNum<widget.quiz.questions.length && isTimeLeft)) {
      return SafeArea(
        child: Scaffold(
        body: Column(
          children: [
            addVerticalSpace(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: SfLinearGauge(
                markerPointers: [
                  LinearShapePointer(value: (_pageNum+1.0))
                ],
                minimum: 1,
                maximum: widget.quiz.questions.length+0.0,
                interval: 1.0,
                numberFormat: NumberFormat(
                    "####", "en_US"
                ),
              ),
            ),
            addVerticalSpace(50),
            CircularCountDownTimer(
              isTimerTextShown: true,
                strokeWidth: 20,
                width: 150,
                height: 150,
                duration: widget.quiz.timeInSeconds,
                fillColor: Colors.grey,
                ringColor: Colors.black,
              isReverseAnimation: true,
              isReverse: true,
              backgroundGradient: const RadialGradient(
                  colors: [
                    Colors.green,
                    Colors.yellow
                  ]
              ),
              onComplete: (){
                setState(() {
                  isTimeLeft = false;
                });
              },
            ),
            Center(
              child: showQuestion(widget.quiz.questions[_pageNum]),
            ),
          ],
        ),
    ),
      );
    } else {
      while(widget.quiz.questions.length!=answers.length){
        answers.add("");
      }
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
              fontSize: 20,
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
