import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz_app/data/model/question_model.dart';
import 'package:quiz_app/data/service/question_service.dart';

class QuestionAnswerProvider extends ChangeNotifier {
  QuestionModel? _questionModel;

  QuestionModel? get questionModel => _questionModel;
  bool isLoading = false;
  int questionNo = 0;

  double _progress = 0;
  Timer? _timer;
  bool _paused = false;

  double get progress => _progress;
  bool isTappedToAnswer = false;

  String givenAnswerByUser = '0';
  int givenAnswerIndex = -1;

  String userName = '';

  int totalScore = 0;

  void getUserName(String givenUserName) {
    userName = givenUserName;
    notifyListeners();
  }

  void userTotalScore({required int score, required String answer}) {
    int index = (answer == 'A')
        ? 0
        : (answer == 'B')
            ? 1
            : (answer == 'C')
                ? 2
                : 3;
    if (index == givenAnswerIndex) {
      totalScore += score;
      notifyListeners();
    } else {
      totalScore += 0;
    }
  }

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

  void questionNoIncreament(int totalQuestion) {
    if (questionNo < totalQuestion) {
      questionNo++;
      notifyListeners();
      print(questionNo);
    }
  }

  void startProgress() {
    const duration = Duration(seconds: 10);
    const tick = Duration(milliseconds: 10);
    int ticks = tick.inMilliseconds == 0
        ? 0
        : (duration.inMilliseconds / tick.inMilliseconds).floor();
    print("Ticks = $ticks");
    _timer = Timer.periodic(tick, (Timer t) {
      if (!_paused) {
        _progress += 1 / ticks;
        if (_progress >= 1) {
          _timer?.cancel();
        }
        notifyListeners();
      }
    });
  }

  void resetProgress() {
    _progress = 0;
    _paused = false;
    _timer?.cancel();
    notifyListeners();
  }

  void pauseProgress() {
    _paused = true;
  }

  void tappedToAnswer(bool value) {
    isTappedToAnswer = value;
    notifyListeners();
  }

  String checkAnswer(int index) {
    String givenAnswer = (index == 0)
        ? 'A'
        : (index == 1)
            ? 'B'
            : (index == 2)
                ? 'C'
                : 'D';
    givenAnswerByUser = givenAnswer;
    givenAnswerIndex = index;
    return givenAnswer;
  }

  void resetAnswerInput() {
    givenAnswerByUser = '0';
    givenAnswerIndex = -1;
  }
}
