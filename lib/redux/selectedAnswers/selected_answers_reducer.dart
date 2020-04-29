import 'package:cbt_app/model/selectedAnswers.dart';
import 'package:cbt_app/redux/selectedAnswers/selected_answers_action.dart';
import 'package:cbt_app/redux/selectedAnswers/selected_answers_state.dart';

selectedAnswerReducer(
    SelectedAnswerState prevState, SetSelectedAnswerAction action) {
  final payload = action.selectedAnswerState;
  List<SelectedAnswers> prevAnswers = [];
  print(prevState?.myAnswers);
  if (payload.myAnswers != null) {
    //we have a myanswer array here we need to strip and make sure
    //the answer is not contained in the answer array before
    final answer = payload.myAnswers[0];

    //we making a clone here.
    prevAnswers = List.from(prevState.myAnswers);

    //print(prevAnswers[0].questionNumber);

    for (int i = 0; i < prevAnswers.length; i++) {
      final obj = prevAnswers[i];
      if (obj.questionNumber == answer.questionNumber) {
        //we already have that answer so we remove it
        prevAnswers.removeAt(i);
        break;
      }
    }
    prevAnswers.add(answer);
  }

  //print(prevAnswers?.length);

  return prevState.copyWith(
      currentQuestion: payload.currentQuestion,
      currentAnswer: payload.currentAnswer,
      myAnswers: prevAnswers.length > 0 ? prevAnswers : prevState.myAnswers);
}
