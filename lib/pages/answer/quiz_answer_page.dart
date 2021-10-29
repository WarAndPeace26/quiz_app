import 'package:flutter/material.dart';
import 'package:quiz_app/pages/answer/answer_forms.dart';
import 'package:quiz_app/utilities/data-classes/quiz.dart';

class QuizAnswerPage extends StatefulWidget {
  const QuizAnswerPage({
    Key? key,
    required this.quiz
  }) : super(key: key);

  final Quiz quiz;

  @override
  _QuizAnswerPageState createState() => _QuizAnswerPageState();
}

class _QuizAnswerPageState extends State<QuizAnswerPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.quiz.title
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 40,
            ),
            Text(
              widget.quiz.title,
              style: const TextStyle(
                fontSize: 60,
              ),
            ),
            Text(
              "${widget.quiz.timeInSeconds} seconds",
              style: const TextStyle(
                fontSize: 30,
              ),
            ),
            Text(
              "${widget.quiz.questions.length} questions",
              style: const TextStyle(
                fontSize: 30,
              ),
            ),
            const Expanded(child: SizedBox()),
            ElevatedButton(
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context){
                          return AnswerForm(quiz: widget.quiz);
                        }
                      ),
                  );
                },
                child: const Text(
                  "Start Quiz",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
