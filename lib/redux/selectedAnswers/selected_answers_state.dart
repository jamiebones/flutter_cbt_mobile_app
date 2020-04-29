import 'package:cbt_app/model/selectedAnswers.dart';
import "package:meta/meta.dart";

@immutable
class SelectedAnswerState {
  final int currentQuestion;
  final int currentAnswer;
  final List<SelectedAnswers> myAnswers;

  SelectedAnswerState(
      {this.currentQuestion, this.currentAnswer, this.myAnswers});

  factory SelectedAnswerState.initial() => SelectedAnswerState(
      currentAnswer: -1, currentQuestion: 0, myAnswers: const []);

  SelectedAnswerState copyWith(
      {@required int currentQuestion,
      @required int currentAnswer,
      @required List<SelectedAnswers> myAnswers}) {
    return SelectedAnswerState(
        currentAnswer: currentAnswer  ?? this.currentAnswer,
        currentQuestion: currentQuestion ?? this.currentQuestion,

        //this is where i check if it is existing so i can update it
        myAnswers: myAnswers ?? this.myAnswers);
  }
}
