
import 'package:book_nook_admin/data/models/Book.dart';
import 'package:book_nook_admin/data/models/offers.dart';
import 'package:book_nook_admin/data/web_services/library_web_services.dart';

class LibraryRepository {
  static LibraryWebServices _libraryWebServices = LibraryWebServices();
  List<Offer> offers = <Offer>[];

  // Future<LibraryProfile> getLibraryInfo({required int id}) async {
  //   var json = await _libraryWebServices.getLibraryInfo(id: id);
  //   // print("LibraryProfile.fromJson(json)");
  //   return LibraryProfile.fromJson(json);
  // }

  // List<BookInfo> allBooks = <BookInfo>[];
  // List<Offer> offers = <Offer>[];

  // //----------------------fetch bookss-------------------
  // Future<List<BookInfo>> getBooks({
  //   required int id,
  // }) async {
  //   List books = await _libraryWebServices.getBooks(id: id);

  //   // List<BookInfo> allBooks = [];
  //   // allBooks.clear();

  //   this.allBooks.clear();
  //   for (var i = 0; i < books.length; i++) {
  //     this.allBooks.add(BookInfo().fromJson1(books[i]));
  //     // print(this.allBooks[i].image);
  //   }
  //   // print("==============repository===============");

  //   return this.allBooks;
  // }

  //----------------------fetch offers -------------------
  Future<List<Offer>> getLibraryOffers({
    required int id,
  }) async {
    List offers = await _libraryWebServices.getLibraryOffers(id: id);
    // List<Offer> offers = [];
    print(offers);
    this.offers.clear();
    for (var i = 0; i < offers.length; i++) {
      Offer offerObject = Offer().fromJson(offers[i]);
      List jsonBooks = offers[i]["books"];
      offerObject.books = [];
      for (int j = 0; j < jsonBooks.length; j++) {
        offerObject.books!.add(BookInfo().fromJson1(jsonBooks[j]));
        // print(offerObject.books![j].name);
      }
      print(offerObject.books!.length);
      this.offers.add(offerObject);
    }
    print(this.offers.length);
    return this.offers;
  }
}
