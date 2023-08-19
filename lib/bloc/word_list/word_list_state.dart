part of 'word_list_cubit.dart';

@immutable
abstract class WordListState extends Equatable{
  const WordListState();

  @override
  List<Object> get props => [];
}

class WordListInitial extends WordListState {}

class WordListLoading extends WordListState {}

class WordListLoaded extends WordListState {
  final List<WordList> wordLists;
  const WordListLoaded(this.wordLists);
}

class WordListFailed extends WordListState {
  final String error;

  const WordListFailed({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'Loading Failed { error: $error }';
}
