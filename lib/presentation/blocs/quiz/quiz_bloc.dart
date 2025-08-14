import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/domain/entities/questions.dart';
import '../../../domain/usecases/get_questions.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final GetQuestions getQuestions;

  QuizBloc(this.getQuestions) : super(QuizState.initial()) {
    on<StartQuiz>(_onStart);
    on<SelectAnswer>(_onSelect);
    on<NextQuestion>(_onNext);
    on<ResetQuiz>((e, emit) => emit(QuizState.initial()));
  }

  Future<void> _onStart(StartQuiz event, Emitter<QuizState> emit) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      final qs = await getQuestions();
      emit(QuizState.initial().copyWith(questions: qs));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  void _onSelect(SelectAnswer event, Emitter<QuizState> emit) {
    if (state.selectedIndex != null) return; // locked after selection
    final isCorrect =
        state.questions[state.currentIndex].answerIndex == event.index;
    emit(
      state.copyWith(
        selectedIndex: event.index,
        score: isCorrect ? state.score + 1 : state.score,
      ),
    );
  }

  void _onNext(NextQuestion event, Emitter<QuizState> emit) {
    if (state.currentIndex + 1 < state.questions.length) {
      emit(
        state.copyWith(
          currentIndex: state.currentIndex + 1,
          selectedIndex: null,
        ),
      );
    } else {
      emit(state.copyWith(isFinished: true));
    }
  }
}
