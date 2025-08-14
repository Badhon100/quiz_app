part of 'leaderboard_bloc.dart';

abstract class LeaderboardEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadLeaderboard extends LeaderboardEvent {}

class SaveLeaderboardScore extends LeaderboardEvent {
  final LeaderboardEntry entry;
  SaveLeaderboardScore(this.entry);

  @override
  List<Object?> get props => [entry];
}
