import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/utilities/data-classes/quiz.dart';
import 'package:quiz_app/utilities/widgets.dart';

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
      body: ListView(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: [
                DataTable(
                    columns: [
                      DataColumn(label: Text("Question", style: Theme.of(context).textTheme.headline6,)),
                      DataColumn(label: Text("Your answer", style: Theme.of(context).textTheme.headline6,)),
                      DataColumn(label: Text("Right answer", style: Theme.of(context).textTheme.headline6,)),
                      DataColumn(label: Text("Correct?", style: Theme.of(context).textTheme.headline6,)),
                    ],
                    rows: [
                      for(var i = 0; i<=counter;i++) DataRow(
                          cells: [
                            DataCell(Text("${i + 1}", textAlign: TextAlign.center,)),
                            DataCell(Text(answers[i], textAlign: TextAlign.center,)),
                            DataCell(Text(quiz.questions[i].answer, textAlign: TextAlign.center,)),
                            DataCell(Icon((correct[i])?Icons.check:Icons.close)),
                          ],
                      )
                    ]
                ),
                addVerticalSpace(50),
                Text(
                    "The Score is: $score",
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
// for(var i = 0; i<=counter;i++) Row(
//   children: [
//     Text(
//       "Question ${i+1}"
//     ),
//     const SizedBox(
//       width: 30,
//     ),Text(
//       answers[i]
//     ),
//     const SizedBox(
//       width: 30,
//     ),Text(
//       quiz.questions[i].answer
//     ),
//     const SizedBox(
//       width: 30,
//     ),
//     Icon(
//         (correct[i])?Icons.check:Icons.close
//     ),
//   ],
// ),
// Text(
//   "Score $score",
// ),