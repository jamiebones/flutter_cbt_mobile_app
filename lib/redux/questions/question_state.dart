import "package:meta/meta.dart";
import '../../model/question.dart';

@immutable
class QuestionsState {
  final bool isError;
  final bool isLoading;
  final List<Data> questions;

  QuestionsState({this.isError, this.isLoading, this.questions});

  factory QuestionsState.initial() =>
      QuestionsState(isError: false, isLoading: false, questions: const []);

  QuestionsState copyWith({
    @required bool isError,
    @required bool isLoading,
    @required List<Data> questions,
  }) {
    return QuestionsState(
        isError: isError ?? this.isError,
        isLoading: isLoading ?? this.isLoading,
        questions: questions ?? this.questions);
  }
}
