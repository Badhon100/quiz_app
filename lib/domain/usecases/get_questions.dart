import '../entities/questions.dart';
import '../repositories/quiz_repository.dart';

class GetQuestions {
  final QuizRepository repo;
  GetQuestions(this.repo);

  Future<List<Question>> call() => repo.getQuestions();
}
