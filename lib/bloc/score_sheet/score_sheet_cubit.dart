import 'package:com.mycompany.quizapp/data/models/score_model.dart';
import 'package:com.mycompany.quizapp/data/repo/quiz_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'score_sheet_state.dart';

class ScoreSheetCubit extends Cubit<ScoreSheetState> {
  final QuizRepository repo;
  List<Score> scoreSheet = [];

  ScoreSheetCubit(this.repo) : super(ScoreSheetInitial());


  List<Score> getScoreSheets() {
    Future.delayed(const Duration(milliseconds: 100))
        .then((value) => emit(ScoreSheetLoading()));
    Future.delayed(const Duration(milliseconds: 200));
    try {
      repo.getScoreSheet().then((scoreSheet) {
          this.scoreSheet = scoreSheet;
          emit(ScoreSheetLoaded(scoreSheet));
      });
    } on Exception catch (e) {
      emit(ScoreSheetFailed(error: e.toString()));
    }
    return scoreSheet;
  }

  void addToScoreSheet(Score score){
    Future.delayed(const Duration(milliseconds: 100))
        .then((value) => emit(ScoreSheetLoading()));
    Future.delayed(const Duration(milliseconds: 200));
    try {
      repo.addToScoreSheet(score).then((value){
        emit(const ScoreSheetLoaded([]));
      });
    } on Exception catch (e) {
      emit(ScoreSheetFailed(error: e.toString()));
    }
  }
}
