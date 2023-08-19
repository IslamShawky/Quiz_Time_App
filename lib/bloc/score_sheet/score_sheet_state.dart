part of 'score_sheet_cubit.dart';

@immutable
abstract class ScoreSheetState extends Equatable{
  const ScoreSheetState();

  @override
  List<Object> get props => [];
}

class ScoreSheetInitial extends ScoreSheetState {}

class ScoreSheetLoading extends ScoreSheetState {}

class ScoreSheetLoaded extends ScoreSheetState {
  final List<Score> scoreSheet;
  const ScoreSheetLoaded(this.scoreSheet);
}

class ScoreSheetFailed extends ScoreSheetState {
  final String error;

  const ScoreSheetFailed({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LoginFailure { error: $error }';
}
