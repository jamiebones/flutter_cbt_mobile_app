import 'package:cbt_app/model/question.dart';
import 'package:cbt_app/model/subject.dart';
import 'package:cbt_app/network/network.dart';
import 'package:cbt_app/ui/loadQuestion.dart';
import 'package:cbt_app/util/colors.dart';
import "package:flutter/material.dart";

class SubjectPanel extends StatefulWidget {
  @override
  _SubjectPanelState createState() => _SubjectPanelState();
}

class _SubjectPanelState extends State<SubjectPanel> {
  Future<Question> questionobject;
  String subjectName;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    //questionobject = getQuestion(subjectName: subjectName);
  }

  final List<Subject> subjects = Subject.getSubjects();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: subjects.length,
          itemBuilder: (BuildContext context, int index) {
            //return ;
            return Center(
              child: InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 60,
                    width: 200,
                    decoration: BoxDecoration(
                      color: secondaryColorDark,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                          child: Text(
                        "${subjects[index].name.toUpperCase()} $loading",
                        style: TextStyle(color: secondaryTextColor),
                      )),
                    ),
                  ),
                ),
                onTap: () async {
                  _onLoading(context);
                  subjectName = subjects[index].name;
                  var result = await getQuestion(subjectName: subjectName);
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoadQuestion(
                                questions: result.data,
                                subject: subjects[index].name,
                              )));
                },
              ),
            );
          }),
    );
  }

  Future<Question> getQuestion({String subjectName}) =>
      new Network().getQuestions(subjectName: subjectName);
}

void _onLoading(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        child: new Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            new CircularProgressIndicator(),
            new Text("Loading"),
          ],
        ),
      );
    },
  );
}
