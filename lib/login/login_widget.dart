import 'package:quiz_app/pages/navigation.dart';

import '../pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'firebase_login/login_model.dart';
import '../utilities/consts.dart';
import 'package:provider/provider.dart';


class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginState>(
        builder: (context, appLoginState, _){
          if(appLoginState.loginState == AppLoginState.loggedOut){
            return FlutterLogin(
              title: name,
              titleTag: "Test",
              theme: LoginTheme(
                pageColorLight: Colors.green[400],
                pageColorDark: Colors.green[900],
                titleStyle: Theme.of(context).textTheme.headline1,
              ),
              loginAfterSignUp: false,
              onSubmitAnimationCompleted: (){
                setState(() {

                });
              },
              onSignup: (loginData) {
                context.read<LoginState>().registerAccount(loginData.name, loginData.password, (e) { });
              },
              onLogin: (loginData) {
                context.read<LoginState>().verifyEmailAndPassword(loginData.name, loginData.password, (e) { });
              },
              onRecoverPassword: (loginData) {},
            );
          }
          else{
            return ChangeNotifierProvider(
              create: (_)=> NavigationModel(),
              child: QuizApp(signOut: appLoginState.signOut),
            );
          }
        }
    );
  }
}
