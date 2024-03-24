class QuestionModel {
  List<Question> questions;

  QuestionModel({required this.questions});

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> questionList = json['questions'];
    List<Question> parsedQuestions =
        questionList.map((question) => Question.fromJson(question)).toList();

    return QuestionModel(questions: parsedQuestions);
  }
}

class Question {
  String question;
  Map<String, String> answers;
  String? questionImageUrl;
  String correctAnswer;
  int score;

  Question({
    required this.question,
    required this.answers,
    this.questionImageUrl,
    required this.correctAnswer,
    required this.score,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> answersMap = json['answers'];

    return Question(
      question: json['question'],
      answers: Map<String, String>.from(answersMap),
      questionImageUrl: json['questionImageUrl'],
      correctAnswer: json['correctAnswer'],
      score: json['score'],
    );
  }
}
