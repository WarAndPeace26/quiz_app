import 'package:flutter/material.dart';
import 'package:quiz_app/pages/answer/quiz_answer_page.dart';
import 'package:quiz_app/utilities/data-classes/quiz.dart';

class AnswerPage extends StatefulWidget {
  AnswerPage({Key? key}) : super(key: key);
  static Quiz quiz = Quiz(
      title: "Biology",
      maker: "Gaji Ajmol",
      questions: questions,
      timeInSeconds: 30,
  );

  static List<Question> questions = <Question>[
    const Question(
        statement: "What is the biggest bone of the body?",
        options: <String>[
          "Tibia",
          "Fibula",
          "Femur"
        ],
        answer: "Femur"),
    const Question(
        statement: "What is the biggest bone of the body?",
        options: <String>[
          "Tibia",
          "Fibula",
          "Femur"
        ],
        answer: "Femur"),
    const Question(
        statement: "What is the biggest bone of the body?",
        options: <String>[
          "Tibia",
          "Fibula",
          "Femur"
        ],
        answer: "Femur"),
  ];

  @override
  State<AnswerPage> createState() => _AnswerPageState();
}

class _AnswerPageState extends State<AnswerPage> {
  final List<Quiz> listOfQuizzes = <Quiz>[AnswerPage.quiz];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Available Quizzes"),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index){
                    return GestureDetector(
                      child: showQuizListTile(listOfQuizzes[index]),
                    );
                  },
                childCount: listOfQuizzes.length,
              ),
          ),
        ],
      ),
    );
  }

  Widget showQuizListTile(Quiz quiz){
    return GestureDetector(
      child: Container(
        color: Colors.grey,
        height: 50,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                quiz.title,
                style: const TextStyle(
                  fontSize: 30,
                ),
              ),
              const Expanded(child: SizedBox()),
              Text(
                quiz.maker,
                style: const TextStyle(
                  fontSize: 30,
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context){
                return QuizAnswerPage(quiz: quiz);
              }
          ),
        );
      },
    );
  }
}
