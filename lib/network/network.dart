import 'dart:convert';
import 'package:cbt_app/model/question.dart';
import 'package:http/http.dart';

class Network {
  Future<Question> getQuestions({String subjectName}) async {
    var finalUrl = "https://questions.aloc.ng/api/q/7?subject=" + subjectName;
    final response = await get(Uri.encodeFull(finalUrl));
    if (response.statusCode == 200) {
      return Question.fromJson(json.decode(response.body));
    } else {
      throw Exception("Error getting the questions");
    }
  }
}
