import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/leaderboard_entry_model.dart';
import '../../../domain/entities/leaderboard_entry.dart';

class LeaderboardLocalDataSource {
  static const _key = 'leaderboard';

  Future<List<LeaderboardEntry>> getAll() async {
    final prefs = await SharedPreferences.getInstance();
    final str = prefs.getString(_key);
    if (str == null || str.isEmpty) return [];
    final rawList = json.decode(str) as List<dynamic>;
    final entries = rawList
        .map(
          (e) => LeaderboardEntryModel.fromJson(
            e as Map<String, dynamic>,
          ).toEntity(),
        )
        .toList();

    // Highest score first, then newest first
    entries.sort((a, b) {
      final scoreCmp = b.score.compareTo(a.score);
      if (scoreCmp != 0) return scoreCmp;
      return b.createdAt.compareTo(a.createdAt);
    });
    return entries;
  }

  Future<void> add(LeaderboardEntry entry) async {
    final prefs = await SharedPreferences.getInstance();
    final current = await getAll();
    current.add(entry);

    // Keep only top 50 to avoid unbounded growth
    current.sort((a, b) {
      final scoreCmp = b.score.compareTo(a.score);
      if (scoreCmp != 0) return scoreCmp;
      return b.createdAt.compareTo(a.createdAt);
    });
    final trimmed = current.take(50).toList();

    final jsonList = trimmed
        .map((e) => LeaderboardEntryModel.fromEntity(e).toJson())
        .toList();
    await prefs.setString(_key, json.encode(jsonList));
  }
}
