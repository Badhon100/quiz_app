part  of 'quiz_bloc.dart';

class QuizState extends Equatable {
  final List<Question> questions;
  final int currentIndex;
  final int? selectedIndex;
  final int score;
  final bool isFinished;
  final bool loading;
  final String? error;

  const QuizState({
    required this.questions,
    required this.currentIndex,
    required this.selectedIndex,
    required this.score,
    required this.isFinished,
    required this.loading,
    required this.error,
  });

  factory QuizState.initial() => const QuizState(
    questions: [],
    currentIndex: 0,
    selectedIndex: null,
    score: 0,
    isFinished: false,
    loading: false,
    error: null,
  );

  QuizState copyWith({
    List<Question>? questions,
    int? currentIndex,
    int? selectedIndex,
    int? score,
    bool? isFinished,
    bool? loading,
    String? error,
  }) {
    return QuizState(
      questions: questions ?? this.questions,
      currentIndex: currentIndex ?? this.currentIndex,
      selectedIndex: selectedIndex,
      score: score ?? this.score,
      isFinished: isFinished ?? this.isFinished,
      loading: loading ?? this.loading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
    questions,
    currentIndex,
    selectedIndex,
    score,
    isFinished,
    loading,
    error,
  ];
}
