import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';

enum AppLoginState{
  loggedOut,
  loggedIn,
}


class LoginState extends ChangeNotifier {
  LoginState() {
    init();
  }

  Future<void> init() async {
    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loginState = AppLoginState.loggedIn;
      } else {
        _loginState = AppLoginState.loggedOut;
      }
      notifyListeners();
    });
  }

  AppLoginState _loginState = AppLoginState.loggedOut;

  AppLoginState get loginState => _loginState;

  String? _email;

  String? get email => _email;

  Future<void> verifyEmailAndPassword(
      String email,
      String password,
      void Function(FirebaseAuthException e) errorCallback,
      ) async {
    try{
      var methods =
      await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (methods.contains('password')){
        try{
          await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: email,
              password: password
          );
          _loginState = AppLoginState.loggedIn;
        } on FirebaseAuthException catch (e) {
          errorCallback(e);
        }
      }
      _email = email;
      notifyListeners();
    } on FirebaseAuthException catch (e){
      errorCallback(e);
    }
  }


  Future<void> registerAccount(
      String email,
      //String displayName,
      String password,
      void Function(FirebaseAuthException e) errorCallback
      ) async {
    try{
      var credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      //await credential.user!.updateDisplayName(displayName);
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void signOut(){
    FirebaseAuth.instance.signOut();
    _loginState = AppLoginState.loggedOut;
    notifyListeners();
  }

}