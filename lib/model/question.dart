class Question {
  String subject;
  int status;
  List<Data> data;

  Question({this.subject, this.status, this.data});

  Question.fromJson(Map<String, dynamic> json) {
    subject = json['subject'];
    status = json['status'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subject'] = this.subject;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  String question;
  Option option;
  String section;
  String image;
  String answer;
  String solution;
  String examtype;
  String examyear;

  Data(
      {this.id,
      this.question,
      this.option,
      this.section,
      this.image,
      this.answer,
      this.solution,
      this.examtype,
      this.examyear});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    option =
        json['option'] != null ? new Option.fromJson(json['option']) : null;
    section = json['section'];
    image = json['image'];
    answer = json['answer'];
    solution = json['solution'];
    examtype = json['examtype'];
    examyear = json['examyear'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question'] = this.question;
    if (this.option != null) {
      data['option'] = this.option.toJson();
    }
    data['section'] = this.section;
    data['image'] = this.image;
    data['answer'] = this.answer;
    data['solution'] = this.solution;
    data['examtype'] = this.examtype;
    data['examyear'] = this.examyear;
    return data;
  }
}

class Option {
  String a;
  String b;
  String c;
  String d;

  Option({this.a, this.b, this.c, this.d});

  Option.fromJson(Map<String, dynamic> json) {
    a = json['a'];
    b = json['b'];
    c = json['c'];
    d = json['d'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['a'] = this.a;
    data['b'] = this.b;
    data['c'] = this.c;
    data['d'] = this.d;
    return data;
  }
}
