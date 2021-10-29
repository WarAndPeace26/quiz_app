import 'package:flutter/material.dart';
import 'package:quiz_app/pages/maker/question_form.dart';
import 'package:quiz_app/utilities/widgets.dart';

class MakeAQuiz extends StatefulWidget {
  const MakeAQuiz({
    Key? key,
    required this.drawer
  }) : super(key: key);

  final Drawer drawer;
  @override
  _MakeAQuizState createState() => _MakeAQuizState();
}

class _MakeAQuizState extends State<MakeAQuiz> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          drawer: widget.drawer,
          appBar: AppBar(),
          body: Center(
            child: StyledButton(
              child: Text(
                "Start ",
                style: Theme.of(context).textTheme.headline6,
              ),
              onPressed: (){
                Navigator.push(
                    context,
                  MaterialPageRoute(
                      builder: (context){
                        return const QuizForm();
                      }
                  ),
                );
              },
            ),
          ),
        )
    );
  }
}
