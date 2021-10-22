import 'package:flutter/material.dart';
import 'package:quiz_app/utilities/data-classes/quiz.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({Key? key, required this.quiz, required this.answers}) : super(key: key);
  final Quiz quiz;
  final List<String> answers;

  @override
  Widget build(BuildContext context) {
    List<bool> correct = [];
    int counter = 0;
    int score = 0;
    for(Question question in quiz.questions){
      correct.add(question.answer==answers[counter]);
      if(correct[counter]){
        score+=1;
      }
      counter+=1;
    }
    counter-=1;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Result of ${quiz.title}"
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            for(var i = 0; i<=counter;i++) Row(
              children: [
                Text(
                  "Question ${i+1}"
                ),
                const SizedBox(
                  width: 30,
                ),Text(
                  answers[i]
                ),
                const SizedBox(
                  width: 30,
                ),Text(
                  quiz.questions[i].answer
                ),
                const SizedBox(
                  width: 30,
                ),
                Icon(
                    (correct[i])?Icons.check:Icons.close
                ),
              ],
            ),
            Text(
              "Score $score",
            ),
          ],
        ),
      ),
    );
  }
}
