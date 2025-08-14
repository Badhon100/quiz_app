import '../entities/leaderboard_entry.dart';
import '../entities/questions.dart';

abstract class QuizRepository {
  Future<List<Question>> getQuestions();
  Future<List<LeaderboardEntry>> getLeaderboard();
  Future<void> saveScore(LeaderboardEntry entry);
}
