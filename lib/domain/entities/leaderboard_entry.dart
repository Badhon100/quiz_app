import 'package:equatable/equatable.dart';

class LeaderboardEntry extends Equatable {
  final String name;
  final int score;
  final DateTime createdAt;

  const LeaderboardEntry({
    required this.name,
    required this.score,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [name, score, createdAt];
}
