import 'package:cbt_app/model/question.dart';
import 'package:cbt_app/model/selectedAnswers.dart';
import 'package:cbt_app/redux/selectedAnswers/selected_answers_action.dart';
import 'package:cbt_app/redux/store.dart';
import 'package:cbt_app/ui/answerQuestionRedux.dart';
import 'package:cbt_app/util/colors.dart';
import "package:flutter/material.dart";
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoadQuestionRedux extends StatelessWidget {
  final reduxStore = Redux.store;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            StoreConnector<AppState, bool>(
              distinct: true,
              converter: (store) => store.state.questionsState.isError,
              builder: (context, isError) {
                if (isError) {
                  return Text("Failed to get questions");
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
            StoreConnector<AppState, bool>(
                distinct: true,
                converter: (store) => store.state.questionsState.isLoading,
                builder: (context, isLoading) {
                  if (isLoading) {
                    return Expanded(
                      child: Container(
                          child: Center(child: CircularProgressIndicator())),
                    );
                  } else {
                    return Expanded(
                      child: Container(
                        height: double.infinity,
                        child: StoreConnector<AppState, List<Data>>(
                            distinct: true,
                            converter: (store) =>
                                store.state.questionsState.questions,
                            builder: (context, questions) {
                              return StoreConnector<AppState, int>(
                                converter: (store) => store
                                    .state.selectedAnswerState.currentQuestion,
                                builder: (context, currentQuestion) {
                                  return ListView(
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 48.0, left: 20, right: 10),
                                            child: Row(
                                              children: <Widget>[
                                                Expanded(
                                                    child: Text(
                                                  "${currentQuestion + 1}.${questions[currentQuestion].question}",
                                                  style:
                                                      TextStyle(fontSize: 22),
                                                )),
                                              ],
                                            ),
                                          ),
                                          StoreConnector<AppState,
                                                  List<SelectedAnswers>>(
                                              converter: (store) => store
                                                  .state
                                                  .selectedAnswerState
                                                  .myAnswers,
                                              builder: (context, myAnswers) {
                                                return Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    _myRadioButton(
                                                        value: 0,
                                                        title: questions[
                                                                currentQuestion]
                                                            .option
                                                            .a,
                                                        onChanged: (val) {
                                                          _radioButtonChanged(
                                                              val,
                                                              currentQuestion);
                                                        },
                                                        currentQuestion:
                                                            currentQuestion,
                                                        myAnswers: myAnswers),
                                                    _myRadioButton(
                                                        value: 1,
                                                        title: questions[
                                                                currentQuestion]
                                                            .option
                                                            .b,
                                                        onChanged: (val) {
                                                          _radioButtonChanged(
                                                              val,
                                                              currentQuestion);
                                                        },
                                                        currentQuestion:
                                                            currentQuestion,
                                                        myAnswers: myAnswers),
                                                    _myRadioButton(
                                                        value: 2,
                                                        title: questions[
                                                                currentQuestion]
                                                            .option
                                                            .c,
                                                        onChanged: (val) {
                                                          _radioButtonChanged(
                                                              val,
                                                              currentQuestion);
                                                        },
                                                        currentQuestion:
                                                            currentQuestion,
                                                        myAnswers: myAnswers),
                                                    _myRadioButton(
                                                        value: 3,
                                                        title: questions[
                                                                currentQuestion]
                                                            .option
                                                            .d,
                                                        onChanged: (val) {
                                                          _radioButtonChanged(
                                                              val,
                                                              currentQuestion);
                                                        },
                                                        currentQuestion:
                                                            currentQuestion,
                                                        myAnswers: myAnswers),
                                                    AnswerQuestionWidget(
                                                      totalQuestions: questions.length,
                                                      questionsAnswered:
                                                          myAnswers,
                                                    )
                                                  ],
                                                );
                                              }),
                                          Divider(
                                            height: 5,
                                            color: Colors.black,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                RaisedButton(
                                                  color: primaryColorLight,
                                                  onPressed: () {
                                                    if (currentQuestion > 0) {
                                                      final nextQuestion =
                                                          currentQuestion - 1;
                                                      reduxStore.dispatch(
                                                          setCurrentQuestion(
                                                              nextQuestion));
                                                    }
                                                  },
                                                  child: Icon(FontAwesomeIcons
                                                      .backward),
                                                ),
                                                RaisedButton(
                                                  onPressed: null,
                                                  child: Text("Submit"),
                                                ),
                                                RaisedButton(
                                                    color: primaryColorLight,
                                                    onPressed: () {
                                                      if (currentQuestion <
                                                          questions.length -
                                                              1) {
                                                        final nextQuestion =
                                                            currentQuestion + 1;
                                                        reduxStore.dispatch(
                                                            setCurrentQuestion(
                                                                nextQuestion));
                                                      }
                                                    },
                                                    child: Icon(FontAwesomeIcons
                                                        .forward)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  );
                                },
                              );
                            }),
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }

  void _radioButtonChanged(int val, questionNumber) {
    SelectedAnswers newAnswers = new SelectedAnswers(
        questionNumber: questionNumber, answerSelected: val);
    reduxStore.dispatch(setCurrentAnswer(newAnswers));
  }

  Widget _myRadioButton(
      {String title,
      int value,
      Function onChanged,
      currentQuestion,
      myAnswers}) {
    var selectedValue = -1;
    for (int i = 0; i < myAnswers.length; i++) {
      var anwser = myAnswers[i];
      if (anwser.questionNumber == currentQuestion) {
        selectedValue = anwser.answerSelected;
        break;
      }
    }
    return RadioListTile(
      value: value,
      groupValue: selectedValue,
      onChanged: onChanged,
      activeColor: secondaryColorDark,
      title: Text(title),
    );
  }
}
