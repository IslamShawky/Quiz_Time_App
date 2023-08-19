import 'package:cloud_firestore/cloud_firestore.dart';

class Score {
  Timestamp? time;
  int? score;
  String? name;

  Score({this.time, this.score, this.name});

  Score.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    score = json['score'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['time'] = time;
    data['score'] = score;
    data['name'] = name;
    return data;
  }
}