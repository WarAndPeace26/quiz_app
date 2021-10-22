class Question{
  const Question({
    required this.statement,
    required this.options,
    required this.answer,
  });
  final String statement;
  final List<String> options;
  final String answer;
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
}