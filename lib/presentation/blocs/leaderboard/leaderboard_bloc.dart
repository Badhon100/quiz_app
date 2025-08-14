import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/domain/entities/leaderboard_entry.dart';


import '../../../domain/usecases/get_leaderboard.dart';
import '../../../domain/usecases/save_score.dart';

part 'leaderboard_event.dart';
part 'leaderboard_state.dart';

class LeaderboardBloc extends Bloc<LeaderboardEvent, LeaderboardState> {
  final GetLeaderboard getLeaderboard;
  final SaveScore saveScore;

  LeaderboardBloc(this.getLeaderboard, this.saveScore)
    : super(LeaderboardState.initial()) {
    on<LoadLeaderboard>(_onLoad);
    on<SaveLeaderboardScore>(_onSave);
  }

  Future<void> _onLoad(
    LoadLeaderboard event,
    Emitter<LeaderboardState> emit,
  ) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      final list = await getLeaderboard();
      emit(state.copyWith(entries: list, loading: false));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  Future<void> _onSave(
    SaveLeaderboardScore event,
    Emitter<LeaderboardState> emit,
  ) async {
    try {
      await saveScore(event.entry);
      add(LoadLeaderboard());
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }
}
