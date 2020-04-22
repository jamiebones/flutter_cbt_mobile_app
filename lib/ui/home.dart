import 'package:cbt_app/ui/subjectPanel.dart';
import 'package:cbt_app/util/colors.dart';
import "package:flutter/material.dart";

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CBT App"),
        backgroundColor: primaryColor,
      ),
      backgroundColor: secondaryColorLight,
      body: SubjectPanel(),
    );
  }
}
