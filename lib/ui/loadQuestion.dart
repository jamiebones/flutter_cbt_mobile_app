import 'package:cbt_app/model/answeredQuestion.dart';
import 'package:cbt_app/model/question.dart';
import 'package:cbt_app/redux/store.dart';
import 'package:cbt_app/ui/answerdQuestion.dart';
import 'package:cbt_app/ui/resultSummary.dart';
import 'package:cbt_app/util/colors.dart';
import "package:flutter/material.dart";
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoadQuestion extends StatelessWidget {
  final List<Data> questions;
  final String subject;

  const LoadQuestion({Key key, this.questions, this.subject}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(subject.toUpperCase()),
      ),
      backgroundColor: secondaryColorLight,
      body: ListView(
        children: <Widget>[
          //Text(questions[0].question),
          ShowQuestion(
            data: questions,
            subject: subject,
          )
        ],
      ),
    );
  }
}

class ShowQuestion extends StatefulWidget {
  final List<Data> data;
  final String subject;

  const ShowQuestion({Key key, this.data, this.subject}) : super(key: key);
  @override
  _ShowQuestionState createState() => _ShowQuestionState();
}

class _ShowQuestionState extends State<ShowQuestion> {
  int questionNumber = 0;
  int _groupValue;
  List<int> selectedAnswers = [];

  @override
  void initState() {
    super.initState();
    selectedAnswers = new List(widget.data.length);
    selectedAnswers.fillRange(0, widget.data.length, -1);
  }

  @override
  Widget build(BuildContext context) {
    print(selectedAnswers);
    return Column(
      children: <Widget>[
        //we are loading here
        StoreConnector<AppState, bool>(
          distinct: true,
          converter: (store) => store.state.questionsState.isLoading,
          builder: (context, isLoading) {
            if (isLoading) {
              return CircularProgressIndicator();
            } else {
              return SizedBox.shrink();
            }
          },
        ),

        //we have an error here

       

        StoreConnector<AppState, List<Data>>(
          distinct: true,
          converter: (store) => store.state.questionsState.questions,
          builder: (context, questions) {
            return Column(
              children: <Widget>[
                AnsweredQuestion(
                  questionAnswered: selectedAnswers,
                  //! this is a call back function sending a value from
                  //! the child to the parent
                  setQuestionNumber: (int val) {
                    setState(() {
                      questionNumber = val;
                      _groupValue = selectedAnswers[questionNumber];
                    });
                  },
                ),
                //return roll here

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        (1 + questionNumber).toString(),
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(bottom: 18.0, left: 10.0),
                      child: Text(
                        "${questions[0].question}",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    )),
                  ],
                ),

                _myRadioButton(
                    value: 0,
                    title: widget.data[questionNumber].option.a,
                    onChanged: (val) {
                      setState(() {
                        selectedAnswers[questionNumber] = val;
                        _groupValue = val;
                        //check if the person has already answered that question
                      });
                    }),

                _myRadioButton(
                    value: 1,
                    title: widget.data[questionNumber].option.b,
                    onChanged: (val) {
                      setState(() {
                        selectedAnswers[questionNumber] = val;
                        _groupValue = val;
                      });
                    }),

                _myRadioButton(
                    value: 2,
                    title: widget.data[questionNumber].option.c,
                    onChanged: (val) {
                      setState(() {
                        selectedAnswers[questionNumber] = val;
                        _groupValue = val;
                      });
                    }),
                _myRadioButton(
                    value: 3,
                    title: widget.data[questionNumber].option.d,
                    onChanged: (val) {
                      setState(() {
                        selectedAnswers[questionNumber] = val;
                        _groupValue = val;
                      });
                    }),

                Divider(
                  height: 5,
                  color: Colors.black,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        setState(() {
                          if (questionNumber > 0) {
                            questionNumber = (questionNumber - 1);
                            _groupValue = selectedAnswers[questionNumber];
                          }
                        });
                      },
                      child: Icon(FontAwesomeIcons.backward),
                    ),
                    RaisedButton(
                      onPressed: _confirmSubmit,
                      child: Text("Submit"),
                    ),
                    RaisedButton(
                        onPressed: () {
                          setState(() {
                            //increament question number here.
                            if (questionNumber + 1 < widget.data.length) {
                              questionNumber = (questionNumber + 1);
                              _groupValue = selectedAnswers[questionNumber];
                            }
                          });
                        },
                        child: Icon(FontAwesomeIcons.forward)),
                  ],
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _myRadioButton({String title, int value, Function onChanged}) {
    return RadioListTile(
      value: value,
      groupValue: _groupValue,
      onChanged: onChanged,
      activeColor: secondaryColorDark,
      title: Text(title),
    );
  }

  void _submitQuiz() {
    //lets gather all our questions and check with out questions
    List<QuestionAnswered> questionAnswered = [];
    final questions = widget.data;
    int index = 0;
    int answerIndex;
    int totalScored = 0;
    //map through it and compare the answers if they are correct
    questions.forEach((question) {
      var answer = question.answer;
      var selectedValue = selectedAnswers[index];
      switch (answer) {
        case "a":
          answerIndex = 0;
          break;
        case "b":
          answerIndex = 1;
          break;
        case "c":
          answerIndex = 2;
          break;
        case "d":
          answerIndex = 3;
          break;
      }

      //compare with selected answers
      QuestionAnswered newAnswers = new QuestionAnswered();

      switch (selectedValue) {
        case -1:
          newAnswers.selectedAnswer = "did not answer";
          break;
        case 0:
          newAnswers.selectedAnswer = question.option.a;
          break;
        case 1:
          newAnswers.selectedAnswer = question.option.b;
          break;
        case 2:
          newAnswers.selectedAnswer = question.option.c;
          break;
        case 3:
          newAnswers.selectedAnswer = question.option.d;
          break;
      }

      var correctAnswer = question.answer;

      switch (correctAnswer) {
        case "a":
          newAnswers.answer = question.option.a;
          break;
        case "b":
          newAnswers.answer = question.option.b;
          break;
        case "c":
          newAnswers.answer = question.option.c;
          break;
        case "d":
          newAnswers.answer = question.option.d;
          break;
      }

      newAnswers.question = question.question;
      newAnswers.questionNumber = index;

      if (selectedAnswers[index] == answerIndex) {
        newAnswers.isCorrect = true;
        //we got the question
        totalScored++;
      } else {
        newAnswers.isCorrect = false;
        //we failed it
      }

      index++;
      questionAnswered.add(newAnswers);
    });
    print(totalScored);
    print(questionAnswered);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => ResultSumary(
                  result: questionAnswered,
                  score: totalScored,
                )));
    // Navigator.pushAndRemoveUntil(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => ResultSumary(
    //               result: questionAnswered,
    //               score: totalScored,
    //             )),
    //     (_) => false);
  }

  void _confirmSubmit() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text("Are you sure?")),
          content: Container(
            height: 70,
            child: Center(child: Text("Please confirm submission")),
          ),
          actions: <Widget>[
            FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("Close")),
            FlatButton(onPressed: _submitQuiz, child: Text("Submit"))
          ],
        );
      },
    );
  }
}
