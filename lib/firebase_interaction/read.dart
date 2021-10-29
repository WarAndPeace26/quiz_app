import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_app/utilities/data-classes/quiz.dart';

class Reader{

  static late Map<String, dynamic> allQuizzes;


  static Future<Map<String, dynamic>> readAllQuizzes() async {

    await FirebaseFirestore
        .instance
        .collection('quizzes')
        .doc("questions")
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        allQuizzes = documentSnapshot.data() as Map<String,dynamic>;
      }
    });
    return allQuizzes;
  }

  static Future<List<Map<String, dynamic>>> readForWriting() async{
    List<Map<String, dynamic>> quizList = [];
    Map<String,dynamic> mapOfQuizzes = {};
    await readAllQuizzes().then(
            (value) {
          mapOfQuizzes = value;
        }
    );
    for(var i in mapOfQuizzes["questions"]){
      quizList.add(i);
    }
    return quizList;
  }

  static Future<List<Quiz>> getQuizzes() async {
    Map<String,dynamic> mapOfQuizzes = {};
    await readAllQuizzes().then(
            (value) {
              mapOfQuizzes = value;
        }
    );
    List<Quiz> quizzes = <Quiz>[];
    for(var i in mapOfQuizzes["questions"]){
      quizzes.add(Quiz.fromJson(i));
    }
    return quizzes;
  }
}
