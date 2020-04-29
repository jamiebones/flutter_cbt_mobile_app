import 'package:cbt_app/model/selectedAnswers.dart';
import 'package:cbt_app/redux/selectedAnswers/selected_answers_state.dart';
import 'package:cbt_app/redux/store.dart';
import 'package:flutter/material.dart';

final store = Redux.store;

@immutable
class SetSelectedAnswerAction {
  final SelectedAnswerState selectedAnswerState;

  SetSelectedAnswerAction(this.selectedAnswerState);
}

setCurrentQuestion(int index) {
  store.dispatch(
      SetSelectedAnswerAction(SelectedAnswerState(currentQuestion: index)));
}

setCurrentAnswer(SelectedAnswers answer) {
  store.dispatch(SetSelectedAnswerAction(SelectedAnswerState(
      currentAnswer: answer.answerSelected,
      currentQuestion: answer.questionNumber,
      myAnswers: [answer])));
}
