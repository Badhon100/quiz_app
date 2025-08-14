import '../../domain/entities/questions.dart';

class QuestionModel {
  final String question;
  final List<String> options;
  final int answerIndex;

  QuestionModel({
    required this.question,
    required this.options,
    required this.answerIndex,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
    question: json['question'] as String,
    options: (json['options'] as List).map((e) => e.toString()).toList(),
    answerIndex: json['answer_index'] as int,
  );

  Question toEntity() =>
      Question(question: question, options: options, answerIndex: answerIndex);
}
