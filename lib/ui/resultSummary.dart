import 'package:cbt_app/model/answeredQuestion.dart';
import 'package:cbt_app/util/colors.dart';
import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ResultSumary extends StatelessWidget {
  final List<QuestionAnswered> result;
  final int score;

  const ResultSumary({Key key, this.result, this.score}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Result Summary"),
          backgroundColor: primaryColorDark,
        ),
        backgroundColor: secondaryColorLight,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Score: $score/${result.length}",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: primaryColorDark),
              ),
            )),
            Expanded(
              child: Container(
                child: ListView.builder(
                    itemCount: result.length,
                    itemBuilder: (BuildContext context, int index) {
                      // return ListTile(
                      //   leading: Text((result[index].questionNumber + 1).toString()),
                      //   title: Text(result[index].question),
                      //   subtitle: Text("Answer: ${result[index].answer}"),

                      // );
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(("${(result[index].questionNumber + 1).toString()}.${result[index].question}")),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(("answer: ${result[index].answer}")),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                      "your answer: ${result[index].selectedAnswer}"),
                                  result[index].isCorrect
                                      ? Icon(FontAwesomeIcons.check,
                                          color: Colors.green)
                                      : Icon(
                                          FontAwesomeIcons.asterisk,
                                          color: Colors.red,
                                        )
                                ],
                              ),
                            ),
                            Divider(
                              color: secondaryColorDark,
                              height: 10.0,
                            )
                          ],
                        ),
                      );
                    }),
              ),
            )
          ],
        ));
  }
}
