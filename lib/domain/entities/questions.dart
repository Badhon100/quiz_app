import 'package:equatable/equatable.dart';

class Question extends Equatable {
  final String question;
  final List<String> options;
  final int answerIndex;

  const Question({
    required this.question,
    required this.options,
    required this.answerIndex,
  });

  @override
  List<Object?> get props => [question, options, answerIndex];
}
