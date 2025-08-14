import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../../models/question_model.dart';
import '../../../domain/entities/questions.dart';

class QuestionsLocalDataSource {
  Future<List<Question>> loadQuestions() async {
    final raw = await rootBundle.loadString('assets/questions.json');
    final jsonList = json.decode(raw) as List<dynamic>;
    return jsonList
        .map(
          (e) => QuestionModel.fromJson(e as Map<String, dynamic>).toEntity(),
        )
        .toList();
  }
}
