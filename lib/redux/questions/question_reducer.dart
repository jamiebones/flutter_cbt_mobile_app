import 'package:cbt_app/redux/questions/question_action.dart';
import 'package:cbt_app/redux/questions/question_state.dart';

questionsReducer(QuestionsState prevState, SetQuestionsStateAction action) {
  final payload = action.questionsState;
  return prevState.copyWith(
      isError: payload.isError,
      isLoading: payload.isLoading,
      questions: payload.questions);
}
