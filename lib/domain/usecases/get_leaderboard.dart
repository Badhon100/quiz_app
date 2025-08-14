import '../entities/leaderboard_entry.dart';
import '../repositories/quiz_repository.dart';

class GetLeaderboard {
  final QuizRepository repo;
  GetLeaderboard(this.repo);

  Future<List<LeaderboardEntry>> call() => repo.getLeaderboard();
}
