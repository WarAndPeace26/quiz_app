import 'package:flutter/material.dart';
import 'package:quiz_app/utilities/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
    required
    this.switchToQuizMaker,
    required this.switchToAnswer,
    required this.switchToHome
  }) : super(key: key);

  final Function() switchToQuizMaker;
  final Function() switchToAnswer;
  final Function() switchToHome;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            navButton(switchToQuizMaker, "Make a quiz"),
            navButton(switchToAnswer, "Answer quizzes"),
          ],
        ),
      ),
    );
  }
}
