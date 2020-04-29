import 'package:cbt_app/redux/questions/question_action.dart';
import 'package:cbt_app/redux/questions/question_reducer.dart';
import 'package:cbt_app/redux/questions/question_state.dart';
import 'package:cbt_app/redux/selectedAnswers/selected_answers_action.dart';
import 'package:cbt_app/redux/selectedAnswers/selected_answers_reducer.dart';
import 'package:cbt_app/redux/selectedAnswers/selected_answers_state.dart';
import 'package:flutter/material.dart';
import "package:meta/meta.dart";
import "package:redux/redux.dart";
import 'package:redux_thunk/redux_thunk.dart';

AppState appReducer(AppState state, dynamic action) {
  if (action is SetQuestionsStateAction) {
    final nextQuestionsState = questionsReducer(state.questionsState, action);
    return state.copyWith(questionsState: nextQuestionsState);
  }

  if (action is SetSelectedAnswerAction) {
    final nextSelectedActionState =
        selectedAnswerReducer(state.selectedAnswerState, action);
    return state.copyWith(selectedAnswerState: nextSelectedActionState);
  }
  return state;
}

@immutable
class AppState {
  final QuestionsState questionsState;
  final SelectedAnswerState selectedAnswerState;

  AppState({@required this.questionsState, @required this.selectedAnswerState});

  AppState copyWith(
      {QuestionsState questionsState,
      SelectedAnswerState selectedAnswerState}) {
    return AppState(
        questionsState: questionsState ?? this.questionsState,
        selectedAnswerState: selectedAnswerState ?? this.selectedAnswerState);
  }
}

class Redux {
  static Store<AppState> _store;
  static Store<AppState> get store {
    if (_store == null) {
      throw Exception("store is not initialized");
    } else {
      return _store;
    }
  }

  static Future<void> init() async {
    final questionsStateInitial = QuestionsState.initial();
    final selectedAnswerStateInitial = SelectedAnswerState.initial();
    //other initial state will be put here

    _store = Store<AppState>(appReducer,
        middleware: [thunkMiddleware],
        initialState: AppState(
            questionsState: questionsStateInitial,
            selectedAnswerState: selectedAnswerStateInitial));
  }
}
