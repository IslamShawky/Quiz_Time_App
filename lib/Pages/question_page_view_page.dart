import 'package:com.mycompany.quizapp/data/models/word_model.dart';
import 'package:flutter/material.dart';

class QuestionPageViewPage extends StatelessWidget {
  const QuestionPageViewPage(this.word, {Key? key}) : super(key: key);
  final WordList word;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(30)),
        boxShadow: [
          BoxShadow(blurRadius: 4, spreadRadius: 2, color: Colors.black45),
        ],
      ),
      child: Center(
        child: word.word == null
            ? const CircularProgressIndicator()
            : Text(
                capitalizeNames(word.word ?? ""),
                style:
                    const TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
              ),
      ),
    );
  }
}

String capitalizeNames(String str) {
  String fullName = "";
  List<String> words = str.split(" ");
  for (var word in words) {
    String capitalizedWord = "";
    for (var i = 0; i < word.characters.length; i++) {
      var char = word.characters.elementAt(i);
      if (i == 0) {
        capitalizedWord += char.toUpperCase();
      } else {
        capitalizedWord += char;
      }
    }
    fullName = "$fullName $capitalizedWord";
  }
  return fullName.trim();
}
