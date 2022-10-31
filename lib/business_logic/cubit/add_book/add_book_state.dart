part of 'add_book_cubit.dart';

@immutable
abstract class AddBookState {}

class AddBookInitial extends AddBookState {}

class AddAuther extends AddBookState {
  final List<String> authers;

  AddAuther(this.authers);
}

class DeleteAuther extends AddBookState {
  final List<String> authers;

  DeleteAuther(this.authers);
}

class AddCaregory extends AddBookState {
  final List<String> categories;

  AddCaregory(this.categories);
}

class DeleteCategory extends AddBookState {
  final List<String> categories;

  DeleteCategory(this.categories);
}

class ImageSelectedState extends AddBookState {
  File? imageFile;
  ImageSelectedState(this.imageFile);
}

class AddBookSubmitting extends AddBookState {}

class AddBookSuccess extends AddBookState {}

class AddBookFailure extends AddBookState {
  final Exception exception;

  AddBookFailure({required this.exception});
}
