import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:book_nook_admin/data/repository/book_repository.dart';
import 'package:book_nook_admin/data/web_services/book_web_services.dart';
import 'package:meta/meta.dart';

part 'add_book_state.dart';

class AddBookCubit extends Cubit<AddBookState> {
  BookRepository _bookRepository = BookRepository(BookWebServices());
  AddBookCubit() : super(AddBookInitial());
  List<String> authors = [];
  List<String> Categories = [];
  File? imageFile;

  void addAuther(String author) {
    this.authors.add(author);
    emit(AddAuther(this.authors));
  }

  void deleteAuthor(String author) {
    this.authors.remove(author);
    emit(DeleteAuther(this.authors));
  }

  void addCategory(String Category) {
    this.Categories.add(Category);
    emit(AddCaregory(this.Categories));
  }

  void deleteCategory(String Category) {
    this.Categories.remove(Category);
    emit(DeleteCategory(this.Categories));
  }

  void setImage(File image) {
    this.imageFile = image;
    emit(ImageSelectedState(imageFile));
  }

  Future<void> postNewBook(
      {required File image,
      required String bookName,
      required String summary,
      required String sellPrice,
      required String purchasingPrice,
      required String quantity,
      required List<String> author,
      required List<String> categories,
      required String numberPage}) async {
    emit(AddBookSubmitting());
    try {
      bool ok = await _bookRepository.postNewBook(
          image: image,
          bookName: bookName,
          summary: summary,
          sellPrice: sellPrice,
          purchasingPrice: purchasingPrice,
          quantity: quantity,
          author: author,
          categories: categories,
          numberPage: numberPage);
      if (ok == true) {
        if (isClosed) return;
        emit(AddBookSuccess());
      }
    } on Exception catch (e) {
      if (isClosed) return;
      emit(AddBookFailure(exception: e));
    }
  }

  Future<void> postUtilizedBook(
      {required File image,
      required String bookName,
      required String summary,
      required String sellPrice,
      required String purchasingPrice,
      required String quantity,
      required List<String> author,
      required List<String> categories,
      required String numberPage}) async {
    emit(AddBookSubmitting());
    try {
      bool ok = await _bookRepository.postUtilizedBook(
          image: image,
          bookName: bookName,
          summary: summary,
          sellPrice: sellPrice,
          purchasingPrice: purchasingPrice,
          quantity: quantity,
          author: author,
          categories: categories,
          numberPage: numberPage);
      if (ok == true) {
        if (isClosed) return;
        emit(AddBookSuccess());
      }
    } on Exception catch (e) {
      if (isClosed) return;
      emit(AddBookFailure(exception: e));
    }
  }
}
