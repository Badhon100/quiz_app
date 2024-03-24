import 'package:flutter/material.dart';
import 'package:quiz_app/data/model/question_model.dart';
import 'package:quiz_app/data/service/question_service.dart';

class QuestionAnswerProvider extends ChangeNotifier {
  QuestionModel? _questionModel;

  QuestionModel? get questionModel => _questionModel;
  bool isLoading = false;

  Future<void> fetchQuestions() async {
    isLoading = true;
    notifyListeners();
    try {
      _questionModel = await QuestinService.fetchQuestions();
      isLoading = false;
      notifyListeners();
            print(questionModel!.questions.length);

    } catch (e) {
      isLoading = false;
      notifyListeners();
      throw Exception('Failed to load questions');
    }
  }
}
