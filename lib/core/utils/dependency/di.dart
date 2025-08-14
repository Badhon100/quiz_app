import 'package:get_it/get_it.dart';
import 'package:quiz_app/data/datasource/local/leaderboard_local_data_source.dart';
import 'package:quiz_app/data/datasource/local/questions_local_data_source.dart';
import 'package:quiz_app/data/repositories_impl/quiz_repository_impl.dart';
import 'package:quiz_app/domain/repositories/quiz_repository.dart';
import 'package:quiz_app/domain/usecases/get_leaderboard.dart';
import 'package:quiz_app/domain/usecases/get_questions.dart';
import 'package:quiz_app/domain/usecases/save_score.dart';
import 'package:quiz_app/presentation/blocs/leaderboard/leaderboard_bloc.dart';
import 'package:quiz_app/presentation/blocs/quiz/quiz_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initDI() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // Data sources
  sl.registerLazySingleton(() => QuestionsLocalDataSource());
  sl.registerLazySingleton(() => LeaderboardLocalDataSource());

  // Repository
  sl.registerLazySingleton<QuizRepository>(
    () => QuizRepositoryImpl(questionsDs: sl(), leaderboardDs: sl()),
  );
  sl.registerLazySingleton(
    () => QuizRepositoryImpl(questionsDs: sl(), leaderboardDs: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetQuestions(sl()));
  sl.registerLazySingleton(() => GetLeaderboard(sl()));
  sl.registerLazySingleton(() => SaveScore(sl()));

  // Blocs
  sl.registerFactory(() => QuizBloc(sl())); // no event added here
  sl.registerFactory(
    () => LeaderboardBloc(sl(), sl()),
  ); // events added when using BlocProvider
}
