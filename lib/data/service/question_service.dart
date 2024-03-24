import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quiz_app/data/model/question_model.dart';

class QuestinService {
  static Future<QuestionModel> fetchQuestions() async {
    final response = await http.get(Uri.parse('https://herosapp.nyc3.digitaloceanspaces.com/quiz.json'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return QuestionModel.fromJson(data);
    } else {
      throw Exception('Failed to load questions');
    }
  }
}
