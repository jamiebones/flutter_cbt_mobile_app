
import 'package:cbt_app/model/subject.dart';
import 'package:cbt_app/redux/questions/question_action.dart';
import 'package:cbt_app/redux/store.dart';
import 'package:cbt_app/ui/loadQuestionRedux.dart';
import 'package:cbt_app/util/colors.dart';
import "package:flutter/material.dart";


class SubjectPanel extends StatefulWidget {
  @override
  _SubjectPanelState createState() => _SubjectPanelState();
}

class _SubjectPanelState extends State<SubjectPanel> {
  String subjectName;

  void _fetchQuestionsFromDb(subject) {
    Redux.store.dispatch(fetchQuestionsAction(Redux.store, subjectName));
  }

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
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: secondaryColorDark,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                          child: Text(
                        "${subjects[index].name.toUpperCase()}",
                        style: TextStyle(color: secondaryTextColor),
                      )),
                    ),
                  ),
                ),
                onTap: () {
                  //_onLoading(context);
                  subjectName = subjects[index].name;
                  _fetchQuestionsFromDb(subjectName);
                  //var result = await getQuestion(subjectName: subjectName);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoadQuestionRedux()));
                },
              ),
            );
          }),
    );
  }
}

void _onLoading(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[CircularProgressIndicator()],
            )),
      );
    },
  );
}
