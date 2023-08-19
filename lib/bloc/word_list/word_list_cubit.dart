import 'dart:math';

import 'package:com.mycompany.quizapp/data/models/word_model.dart';
import 'package:com.mycompany.quizapp/data/repo/quiz_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'word_list_state.dart';

class WordListCubit extends Cubit<WordListState> {
  final QuizRepository repo;
  List<WordList> wordList = [];

  WordListCubit(this.repo) : super(WordListInitial());

  List<WordList> selectWords(List<WordList> words) {
    final random = Random();
    final wordSet = Set.from(words);
    final List<WordList> selectedObjects = [];
    for (int i = 0; i < 5; i++) {
      final randomObject = wordSet.elementAt(random.nextInt(wordSet.length));
      selectedObjects.add(randomObject);
      wordSet.remove(randomObject);
    }
    return selectedObjects;
  }

  void getWordLists() {
    Future.delayed(const Duration(milliseconds: 100))
        .then((value) => emit(WordListLoading()));
    Future.delayed(const Duration(milliseconds: 200));
    repo.getWordList().then((wordList) {
      try {
        this.wordList = selectWords(wordList);
        emit(WordListLoaded(this.wordList));
      } on Exception catch (e) {
        emit(WordListFailed(error: e.toString()));
      }
    });
  }
}
