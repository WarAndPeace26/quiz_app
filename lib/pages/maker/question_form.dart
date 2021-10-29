import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:quiz_app/firebase_interaction/write.dart';
import 'package:quiz_app/utilities/data-classes/quiz.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:quiz_app/utilities/widgets.dart';

String? title;
String? timeInSeconds;
List<Question> questions = [];
String? maker;
List<QuestionWidget> questionWidgets = [];


class QuizForm extends StatefulWidget {
  const QuizForm({Key? key}) : super(key: key);

  @override
  _QuizFormState createState() => _QuizFormState();
}

class _QuizFormState extends State<QuizForm> {
  @override
  Widget build(BuildContext context) {
    UniqueKey _quizFormKey = UniqueKey();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
              onPressed: (){
                initiateSave();
                Navigator.pop(context);
              },
              icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints){
          return Form(
            key: _quizFormKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                    initialValue: title,
                    decoration: const InputDecoration(
                      label: Text(
                          "Quiz Title"
                      ),
                    ),
                    onChanged: (value){
                      title = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    style: Theme.of(context).textTheme.caption,
                    initialValue: title,
                    decoration: const InputDecoration(
                      label: Text(
                          "Quiz maker"
                      ),
                    ),
                    onChanged: (value){
                      maker = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    initialValue: timeInSeconds,
                    decoration: const InputDecoration(
                      label: Text(
                          "Time in seconds"
                      ),
                    ),
                    onChanged: (value){
                      timeInSeconds = value;
                    },
                  ),
                ),
                addVerticalSpace(20),
                ElevatedButton(
                    onPressed: (){
                      Navigator.push(
                          context,
                        MaterialPageRoute(
                            builder: (context){
                              return const IndividualQuestionForm();
                            }
                        )
                      );
                    },
                    child: const Text(
                      "Add Questions",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void initiateSave(){
    for(QuestionWidget i in questionWidgets){
      if(i.questionStatement!=null){
        questions.add(Question(
            statement: i.questionStatement!,
            options: i.questionOptions,
            answer: i.questionAnswer!)
        );
      }
    }
    Quiz quiz = Quiz(
        title: title!,
        maker: maker!,
        questions: questions,
        timeInSeconds: int.parse(timeInSeconds!),
    );
    Writer.upQuiz(quiz);
  }
}

class IndividualQuestionForm extends StatefulWidget {
  const IndividualQuestionForm({Key? key}) : super(key: key);

  @override
  _IndividualQuestionFormState createState() => _IndividualQuestionFormState();
}

class _IndividualQuestionFormState extends State<IndividualQuestionForm> {
  List<Widget> formList = [];

  @override
  void initState() {
    addForm();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Number of questions: ${formList.length}"
        ),
      ),
      body: CarouselSlider(
        items: formList,
        options: CarouselOptions(
          enableInfiniteScroll: false,
        ),
      ),
    );
  }



  void addForm(){
    int index = formList.length;
    QuestionWidget question = QuestionWidget();
    questionWidgets.add(question);

    formList.add(
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
              child: Column(
                children: [
                  SizedBox(
                    height: 500,
                    child: Stack(
                      children: [
                        question,
                        Align(
                          alignment: const Alignment(0.5,0.4),
                          child: ClipOval(
                            child: Container(
                              color: Colors.lightGreen,
                              child: IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  setState(() {
                                    addForm();
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: const Alignment(-0.5,0.4),
                          child: ClipOval(
                            child: Container(
                              color: Colors.red,
                              child: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  setState(() {
                                    formList.removeAt(index);
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
          ),
        ),
    );
  }
}

class QuestionWidget extends StatelessWidget {
  QuestionWidget({Key? key}) : super(key: key);
  String? questionStatement;
  String? questionAnswer;
  List<String> questionOptions = ["","",""];

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextFormField(
                    initialValue: questionStatement,
                    decoration: const InputDecoration(
                      label: Text(
                          "Question Statement"
                      ),
                    ),
                    onChanged: (value){
                      questionStatement = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35.0),
                  child: TextFormField(
                    initialValue: questionOptions[0],
                    decoration: const InputDecoration(
                      label: Text(
                          "Option 1"
                      ),
                    ),
                    onChanged: (value){
                      questionOptions[0] = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35.0),
                  child: TextFormField(
                    initialValue: questionOptions[1],
                    decoration: const InputDecoration(
                      label: Text(
                          "Option 2"
                      ),
                    ),
                    onChanged: (value){
                      questionOptions[1] = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35.0),
                  child: TextFormField(
                    initialValue: questionOptions[2],
                    decoration: const InputDecoration(
                      label: Text(
                          "Option 3"
                      ),
                    ),
                    onChanged: (value){
                      questionOptions[2] = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35.0),
                  child: TextFormField(
                    initialValue: questionAnswer,
                    decoration: const InputDecoration(
                      label: Text(
                          "Answer",
                        style: TextStyle(
                          color: Colors.yellow,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    onChanged: (value){
                      questionAnswer = value;
                    },
                  ),
                ),
              ],
            ),
          ],
        )
    );
  }
}


