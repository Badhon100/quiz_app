import 'package:flutter/material.dart';
import 'package:quiz_app/presentation/screens/homescreen.dart';
import 'package:quiz_app/presentation/screens/question_answer_page.dart';

class AppRoute {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );
      case '/question_answer_screen':
        return MaterialPageRoute(
          builder: (_) => const QuestionAnswerScreen(),
        );
      default:
        return null;
    }
  }
}
