import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/utilities/consts.dart';
import 'login/firebase_login/login_model.dart';
import 'login/login_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            textTheme: defaultText,
          primaryColor: Colors.green
        ),
        debugShowCheckedModeBanner: false,
        home: ChangeNotifierProvider(
          create: (context)=>LoginState(),
          builder: (context,_) => const LoginWidget(),
        )
    );
  }
}
