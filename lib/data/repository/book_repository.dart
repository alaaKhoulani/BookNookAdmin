import 'dart:io';

import 'package:book_nook_admin/data/models/Book.dart';
import 'package:book_nook_admin/data/web_services/book_web_services.dart';
import 'package:flutter/cupertino.dart';

class BookRepository {
  final BookWebServices _bookWebServices;
  BookRepository(this._bookWebServices);
  List<BookInfo> allBooks = <BookInfo>[];

  //----------------------fetch bookss-------------------
  Future<List<BookInfo>> getBooks({
    required int id,
  }) async {
    List books = await _bookWebServices.getBooks(id: id);

    List<BookInfo> allBooks = [];
    this.allBooks.clear();
    for (var i = 0; i < books.length; i++) {
      this.allBooks.add(BookInfo().fromJson1(books[i]));
      print(this.allBooks[i].image);
    }
    // print("==============repository===============");

    return this.allBooks;
  }
  //--------------------- fetch book ------------------------

  Future<BookInfo> getBook({required int id}) async {
    var book = await _bookWebServices.getBook(id: id);
    return BookInfo().fromJson1(book);
  }

  //--------------------------- post new book ------------------------
  Future<bool> postNewBook(
      {required File image,
      required String bookName,
      required String summary,
      required String sellPrice,
      required String purchasingPrice,
      required String quantity,
      required List<String> author,
      required List<String> categories,
      required String numberPage}) async {
    print("repo book add");
    return await _bookWebServices.postNewBook(
        image: image,
        bookName: bookName,
        summary: summary,
        sellPrice: sellPrice,
        purchasingPrice: purchasingPrice,
        quantity: quantity,
        author: author,
        categories: categories,
        numberPage: numberPage);
  }

  Future<bool> postUtilizedBook(
      {required File image,
      required String bookName,
      required String summary,
      required String sellPrice,
      required String purchasingPrice,
      required String quantity,
      required List<String> author,
      required List<String> categories,
      required String numberPage}) async {
    return await _bookWebServices.postUtilizedBook(
        image: image,
        bookName: bookName,
        summary: summary,
        sellPrice: sellPrice,
        purchasingPrice: purchasingPrice,
        quantity: quantity,
        author: author,
        categories: categories,
        numberPage: numberPage);
  }
}
