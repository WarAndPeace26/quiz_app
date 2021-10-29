import 'package:flutter/material.dart';
import 'package:quiz_app/firebase_interaction/read.dart';
import 'package:quiz_app/pages/answer/quiz_answer_page.dart';
import 'package:quiz_app/utilities/data-classes/quiz.dart';

class AnswerPage extends StatefulWidget {
  const AnswerPage({Key? key, required this.drawer}) : super(key: key);

  final Drawer drawer;
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


  @override
  Widget build(BuildContext context) {
    Future<List<Quiz>> futureListOfQuizzes = Reader.getQuizzes();

    return FutureBuilder(
      future: futureListOfQuizzes,
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            List<Quiz> listOfQuizzes = snapshot.data! as List<Quiz>;
            return SafeArea(
              child: Scaffold(
                drawer: widget.drawer,
                appBar: AppBar(
                  title: const Text("Available Quizzes"),
                  centerTitle: true,
                ),
                body: CustomScrollView(
                  slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (context, index) {
                          return GestureDetector(
                            child: showQuizListTile(listOfQuizzes[index]),
                          );
                        },
                        childCount: listOfQuizzes.length,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }else{
            return const Text('Something went wrong');
          }
        }
    );
  }

  Widget showQuizListTile(Quiz quiz){
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(bottom: 2),
        color: Colors.teal[700],
        height: 60,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0, left: 10, right: 10),
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
