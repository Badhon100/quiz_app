import 'package:quiz_app/data/datasource/local/leaderboard_local_data_source.dart';
import 'package:quiz_app/data/datasource/local/questions_local_data_source.dart';

import '../../domain/entities/leaderboard_entry.dart';
import '../../domain/entities/questions.dart';
import '../../domain/repositories/quiz_repository.dart';

class QuizRepositoryImpl implements QuizRepository {
  final QuestionsLocalDataSource questionsDs;
  final LeaderboardLocalDataSource leaderboardDs;

  QuizRepositoryImpl({required this.questionsDs, required this.leaderboardDs});

  @override
  Future<List<Question>> getQuestions() => questionsDs.loadQuestions();

  @override
  Future<List<LeaderboardEntry>> getLeaderboard() => leaderboardDs.getAll();

  @override
  Future<void> saveScore(LeaderboardEntry entry) => leaderboardDs.add(entry);
}
