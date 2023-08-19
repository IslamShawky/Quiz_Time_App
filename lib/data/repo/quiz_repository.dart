import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com.mycompany.quizapp/data/models/word_model.dart';

import '../models/score_model.dart';

class QuizRepository{

  Future<List<WordList>> getWordList() async {
    final wordList = await FirebaseFirestore.instance.collection('wordList').get();
    return wordList.docs.map((word) => WordList.fromJson(word.data())).toList();
  }

  Future<void> addToScoreSheet(Score score) async{
    await FirebaseFirestore.instance.collection('scoreSheet').add(score.toJson());
  }

  Future<List<Score>> getScoreSheet() async {
    final scoreSheet = await FirebaseFirestore.instance.collection('scoreSheet').get();
    return scoreSheet.docs.map((score) => Score.fromJson(score.data())).toList();
  }
}