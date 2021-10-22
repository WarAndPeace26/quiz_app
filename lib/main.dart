import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/pages/answer/answer_page.dart';
import 'package:quiz_app/pages/home/home.dart';
import 'package:quiz_app/pages/navigation.dart';

void main() {
  runApp(
      ChangeNotifierProvider(
        create: (context)=>NavigationModel(),
        child: const QuizApp()
      )
  );
}


class QuizApp extends StatefulWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {

  @override
  Widget build(BuildContext context) {
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
                  ),
                ),
              if (navigationModel.selectedPage == SelectedPage.quizMaker)
                const MaterialPage(
                  child: Center(
                    child: Text("quizMaker"),
                  ),
                ),
              if (navigationModel.selectedPage == SelectedPage.answer)
                MaterialPage(
                  child: AnswerPage(),
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

