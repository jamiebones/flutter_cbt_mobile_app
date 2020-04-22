class QuestionAnswered {
  int questionNumber;
  String question;
  String selectedAnswer;
  String answer;
  bool isCorrect;

  QuestionAnswered(
      {this.questionNumber,
      this.selectedAnswer,
      this.answer,
      this.isCorrect,
      this.question});
}
