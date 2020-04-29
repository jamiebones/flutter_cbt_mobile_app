import 'package:cbt_app/util/colors.dart';
import "package:flutter/material.dart";

class AnsweredQuestion extends StatelessWidget {
  final questionAnswered;
  final Function(int) setQuestionNumber;

  const AnsweredQuestion(
      {Key key, this.questionAnswered, this.setQuestionNumber})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        height: 60,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => SizedBox(width: 3),
            itemCount: questionAnswered.length,
            itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    print("tap");
                    setQuestionNumber(index);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: questionAnswered[index] == -1
                              ? primaryColorLight
                              : primaryColorDark),
                      child: Text(
                        (index + 1).toString(),
                        style: TextStyle(
                            color: questionAnswered[index] == -1
                                ? primaryTextColor
                                : primaryTextColor),
                      ),
                    ),
                  ),
                )));
  }
}
