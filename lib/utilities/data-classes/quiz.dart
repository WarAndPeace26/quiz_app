class Question{
  const Question({
    required this.statement,
    required this.options,
    required this.answer,
  });
  final String statement;
  final List<String> options;
  final String answer;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
      answer: json["answer"],
      statement: json["statement"],
      options: optionsFromJson(json["options"]),
  );

  static List<String> optionsFromJson(List<dynamic> json){
    List<String> optionsFromJ = [];
    for(var i in json){
      optionsFromJ.add(i);
    }
    return optionsFromJ;
  }

  Map<String, dynamic> toJson() => {
    "answer": answer,
    "statement": statement,
    "options": options,
  };
}

class Quiz{
  const Quiz({
    required this.title,
    required this.maker,
    required this.questions,
    required this.timeInSeconds,
  });

  final String title;
  final String maker;
  final List<Question> questions;
  final int timeInSeconds;

  factory Quiz.fromJson(Map<String, dynamic> json){
    List<Question> questionsFromJson = <Question>[];
    for(var i in json["questions"]){
      questionsFromJson.add(Question.fromJson(i));
    }
    return Quiz(
        title: json["title"],
        maker: json["maker"],
        timeInSeconds: json["timeInSeconds"],
        questions: questionsFromJson
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String,dynamic>> questionsToJson = [];
    for(Question i in questions){
      questionsToJson.add(i.toJson());
    }
    return {
      "title": title,
      "timeInSeconds": timeInSeconds,
      "questions": questionsToJson,
      "maker": maker,
    };
  }
}