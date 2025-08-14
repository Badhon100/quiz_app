import '../../domain/entities/leaderboard_entry.dart';

class LeaderboardEntryModel {
  final String name;
  final int score;
  final DateTime createdAt;

  LeaderboardEntryModel({
    required this.name,
    required this.score,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'score': score,
    'createdAt': createdAt.toIso8601String(),
  };

  factory LeaderboardEntryModel.fromJson(Map<String, dynamic> json) =>
      LeaderboardEntryModel(
        name: json['name'] as String,
        score: json['score'] as int,
        createdAt: DateTime.parse(json['createdAt'] as String),
      );

  LeaderboardEntry toEntity() =>
      LeaderboardEntry(name: name, score: score, createdAt: createdAt);

  factory LeaderboardEntryModel.fromEntity(LeaderboardEntry e) =>
      LeaderboardEntryModel(
        name: e.name,
        score: e.score,
        createdAt: e.createdAt,
      );
}
