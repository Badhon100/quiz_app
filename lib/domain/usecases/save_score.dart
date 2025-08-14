import '../entities/leaderboard_entry.dart';
import '../repositories/quiz_repository.dart';

class SaveScore {
  final QuizRepository repo;
  SaveScore(this.repo);

  Future<void> call(LeaderboardEntry entry) => repo.saveScore(entry);
}
