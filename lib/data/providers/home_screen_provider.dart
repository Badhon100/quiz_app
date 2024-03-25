import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreenProvider extends ChangeNotifier {
  int _score = 0;
  int _highScore = 0;

  int get highScore => _highScore;
  int get score => _score;

  void getScores() {
    _loadScore();
  }

  Future<void> _loadScore() async {
    final prefs = await SharedPreferences.getInstance();
    _highScore = prefs.getInt('highScore') ?? 0;
    _score = prefs.getInt('score') ?? 0;
    notifyListeners();
  }

  Future<void> updateScore(int newScore) async {
    final pref = await SharedPreferences.getInstance();
    
    if (newScore > _highScore) {
      _highScore = newScore;

      pref.setInt('highScore', _highScore);
      
    }
    _score = newScore;
    pref.setInt('score', _score);
    notifyListeners();
  }
}
