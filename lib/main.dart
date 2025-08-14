import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/core/utils/dependency/di.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/blocs/quiz/quiz_bloc.dart';
import 'presentation/blocs/leaderboard/leaderboard_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDI(); // Initialize DI

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<QuizBloc>(create: (_) => sl<QuizBloc>()),
        BlocProvider<LeaderboardBloc>(create: (_) => sl<LeaderboardBloc>()),
      ],
      child: MaterialApp(
        title: 'Quiz App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.deepPurple,
          brightness: Brightness.light,
          cardTheme: CardThemeData(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),

        darkTheme: ThemeData(
          brightness: Brightness.dark,
          colorSchemeSeed: Colors.deepPurple,
          useMaterial3: true,
        ),
        themeMode: ThemeMode.system,
        home: const HomePage(),
      ),
    );
  }
}
