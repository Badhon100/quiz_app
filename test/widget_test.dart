import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_app/presentation/blocs/quiz/quiz_bloc.dart';

void main() {
  test('score increments correctly', () {
    var state = QuizState.initial().copyWith(score: 0);
    state = state.copyWith(score: state.score + 1);
    expect(state.score, 1);
  });
}
