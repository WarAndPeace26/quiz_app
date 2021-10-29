import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_app/firebase_interaction/read.dart';
import 'package:quiz_app/utilities/data-classes/quiz.dart';

class Writer{
  static CollectionReference tasks = FirebaseFirestore.instance.collection('quizzes');

  static List<Map<String, dynamic>> allQuestions = [];
  static Future<void> upQuiz(Quiz quiz) async{
    await Reader.readForWriting().then(
            (value){
              allQuestions = value;
            }
    );
    allQuestions.add(quiz.toJson());
    return tasks
        .doc("questions")
        .update({'questions': allQuestions})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
}