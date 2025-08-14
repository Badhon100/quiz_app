part of 'leaderboard_bloc.dart';

class LeaderboardState extends Equatable {
  final List<LeaderboardEntry> entries;
  final bool loading;
  final String? error;

  const LeaderboardState({
    required this.entries,
    required this.loading,
    required this.error,
  });

  factory LeaderboardState.initial() =>
      const LeaderboardState(entries: [], loading: false, error: null);

  LeaderboardState copyWith({
    List<LeaderboardEntry>? entries,
    bool? loading,
    String? error,
  }) => LeaderboardState(
    entries: entries ?? this.entries,
    loading: loading ?? this.loading,
    error: error,
  );

  @override
  List<Object?> get props => [entries, loading, error];
}
