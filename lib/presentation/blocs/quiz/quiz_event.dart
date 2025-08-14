part of 'quiz_bloc.dart';

abstract class QuizEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class StartQuiz extends QuizEvent {}

class SelectAnswer extends QuizEvent {
  final int index;
  SelectAnswer(this.index);

  @override
  List<Object?> get props => [index];
}

class NextQuestion extends QuizEvent {}

class ResetQuiz extends QuizEvent {}
