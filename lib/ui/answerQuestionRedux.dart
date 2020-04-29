import 'package:cbt_app/redux/selectedAnswers/selected_answers_action.dart';
import 'package:cbt_app/redux/store.dart';
import 'package:cbt_app/util/colors.dart';
import "package:flutter/material.dart";

class AnswerQuestionWidget extends StatelessWidget {
  final questionsAnswered;
  final int totalQuestions;

  const AnswerQuestionWidget(
      {Key key, this.questionsAnswered, this.totalQuestions})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        height: 60,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => SizedBox(width: 3),
            itemCount: totalQuestions,
            itemBuilder: (context, index) => InkWell(
                onTap: () {
                
                  //we call the reducer to change the question here
                  Redux.store.dispatch(setCurrentQuestion(index));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: _isAnswered(questionsAnswered, index) == false
                            ? primaryColorLight
                            : primaryColorDark),
                    child: Center(
                      child: Text(
                        (index + 1).toString(),
                        style: TextStyle(
                            color: _isAnswered(questionsAnswered, index) == true
                                ? primaryTextColor
                                : primaryTextColor),
                      ),
                    ),
                  ),
                ))));
  }
}

bool _isAnswered(List ans, int index) {
  for (int i = 0; i < ans.length; i++) {
    var current = ans[i];
    if (current.questionNumber == index) {
      return true;
    }
  }
  return false;
}
