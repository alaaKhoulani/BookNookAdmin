part of 'details_cubit.dart';

@immutable
abstract class DetailsState {}

class DetailsInitial extends DetailsState {}

class DetailsSubmitting extends DetailsState {}

class DetailsSuccess extends DetailsState {
  final BookInfo book;

  DetailsSuccess(this.book);
}

class DetailsFailure extends DetailsState {
  final Exception exception;

  DetailsFailure({required this.exception});
}
