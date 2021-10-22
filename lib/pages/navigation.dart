import 'package:flutter/cupertino.dart';

enum SelectedPage{
  home,
  quizMaker,
  answer
}

class NavigationModel extends ChangeNotifier{
  SelectedPage _selectedPage = SelectedPage.home;

  get selectedPage => _selectedPage;

  switchToQuizMaker(){
    _selectedPage = SelectedPage.quizMaker;
    notifyListeners();
  }
  switchToAnswer(){
    _selectedPage = SelectedPage.answer;
    notifyListeners();
  }
  switchToHome(){
    _selectedPage = SelectedPage.home;
    notifyListeners();
  }
}