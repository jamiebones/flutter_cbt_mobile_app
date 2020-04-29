import "dart:convert";
import 'package:cbt_app/redux/questions/question_state.dart';
import 'package:cbt_app/redux/store.dart';
import "package:redux/redux.dart";
import "package:meta/meta.dart";
import 'package:cbt_app/model/question.dart';
import 'package:http/http.dart';
import '../../model/question.dart';

@immutable
class SetQuestionsStateAction {
  final QuestionsState questionsState;
  SetQuestionsStateAction(this.questionsState);
}

Future<void> fetchQuestionsAction(
    Store<AppState> store, String subjectName) async {
  store.dispatch(SetQuestionsStateAction(QuestionsState(isLoading: true)));
  try {
    var finalUrl = "https://questions.aloc.ng/api/q/7?subject=" + subjectName;

    final response = await get(Uri.encodeFull(finalUrl));
    if (response.statusCode == 200) {
      //final jsonData = (json.decode(response.body));
      final jsonData = Question.fromJson(json.decode(response.body));
      store.dispatch(SetQuestionsStateAction(QuestionsState(
           isLoading: false, questions: jsonData.data)));
    }
  } catch (e) {
    store.dispatch(SetQuestionsStateAction(QuestionsState(isError: true)));
  }
}
