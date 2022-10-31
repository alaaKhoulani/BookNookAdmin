part of 'quotes_cubit.dart';

@immutable
abstract class QuotesState {}

class QuotesInitial extends QuotesState {}

class QuotesSubmitting extends QuotesState {}
class QuotesPostSubmetting extends QuotesState {}
class QuotesPostSuccess extends QuotesState {}
class QuotesRandomInitial extends QuotesState {}

class QuotesSuccess extends QuotesState {
  final List<Quote> quotes;

  QuotesSuccess(this.quotes);
}
class QuotesLoaded extends QuotesState {
  final List<Quote> quotes;

  QuotesLoaded(this.quotes);
}

class QuotesFailure extends QuotesState {
  final Exception exception;

  QuotesFailure({required this.exception});
}
