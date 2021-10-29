import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/pages/answer/answer_page.dart';
import 'package:quiz_app/pages/maker/quiz_maker.dart';
import 'package:quiz_app/utilities/widgets.dart';
import 'package:provider/provider.dart';

import '../navigation.dart';


class QuizApp extends StatefulWidget {
  const QuizApp({Key? key, required this.signOut}) : super(key: key);

  final Function signOut;

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {

  @override
  Widget build(BuildContext context) {
    Drawer createDrawer(Function signOut, Function quizMaker, Function answer) {
      return Drawer(
        child: Container(
          color: Colors.black,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.005, 145, 0.0),
                child: Text(
                  "QuizShare",
                  style: GoogleFonts.italianno(
                      color: Colors.deepPurple, fontSize: 20),
                ),
              ),
              addVerticalSpace(50),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 80, 0.0, 0.0),
                child: StyledButton(
                  child: const Text("Make A Quiz"),
                  onPressed: () {
                    quizMaker();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 10, 0.0, 0.0),
                child: StyledButton(
                  child: const Text("Answer quizzes"),
                  onPressed: () {
                    answer();
                  },
                ),
              ),
              Expanded(child: Container()),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 40),
                child: StyledButton(
                  child: Text(
                    "SignOut",
                    style: TextStyle(color: Colors.red[700]),
                  ),
                  onPressed: () => signOut(),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Consumer<NavigationModel>(
        builder: (context, navigationModel, child){
          return Navigator(
            pages: [
              if (navigationModel.selectedPage == SelectedPage.home)
                MaterialPage(
                  child: HomeScreen(
                    switchToHome: navigationModel.switchToHome,
                    switchToAnswer: navigationModel.switchToAnswer,
                    switchToQuizMaker: navigationModel.switchToQuizMaker,
                    signOut: widget.signOut,
                  ),
                ),
              if (navigationModel.selectedPage == SelectedPage.quizMaker)
                MaterialPage(
                  child: MakeAQuiz(
                    drawer: createDrawer(
                        widget.signOut,
                        navigationModel.switchToQuizMaker,
                        navigationModel.switchToAnswer),
                  ),
                ),
              if (navigationModel.selectedPage == SelectedPage.answer)
                MaterialPage(
                  child: AnswerPage(
                    drawer: createDrawer(
                        widget.signOut,
                        navigationModel.switchToQuizMaker,
                        navigationModel.switchToAnswer),
                  ),
                ),
            ],
            onPopPage: _handlePopPage,
          );
        },
      ),
    );
  }

  bool _handlePopPage(Route<dynamic> route, dynamic result){
    return true;
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
    required
    this.switchToQuizMaker,
    required this.switchToAnswer,
    required this.switchToHome,
    required this.signOut
  }) : super(key: key);

  final Function() switchToQuizMaker;
  final Function() switchToAnswer;
  final Function() switchToHome;
  final Function signOut;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  widget.signOut();
                },
                icon: const Icon(Icons.exit_to_app_outlined),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              navButton(widget.switchToQuizMaker, "Make a quiz"),
              navButton(widget.switchToAnswer, "Answer quizzes"),
            ],
          ),
        ),
      ),
    );
  }
}
