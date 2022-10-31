part of 'all_book_cubit.dart';

@immutable
abstract class AllBookState {}

class AllBookInitial extends AllBookState {}

class AllBookSuccessful extends AllBookState {
  final List<BookInfo> allBooks;

  AllBookSuccessful(this.allBooks);
}

class AllBookLoading extends AllBookState {}

class AllBookFailer extends AllBookState {
  final Exception exception;

  AllBookFailer({required this.exception});
}
//-----------------------Search states-------------------------

class Initial extends AllBookState {}

class DeleteRecent extends AllBookState {}

class ClearAll extends AllBookState {}

class StartSearch extends AllBookState {}

class StopSearch extends AllBookState {}

class AddSearch extends AllBookState {}

class GetRecent extends AllBookState {}

class TopBooks extends AllBookState {}

class Recent extends AllBookState {}
