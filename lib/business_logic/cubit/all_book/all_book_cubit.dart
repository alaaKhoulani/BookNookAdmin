import 'dart:convert';
import 'dart:developer';
import 'package:book_nook_admin/business_logic/cubit/profile/profile_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:book_nook_admin/data/models/Book.dart';
import 'package:book_nook_admin/data/repository/book_repository.dart';
import 'package:book_nook_admin/data/web_services/book_web_services.dart';
import 'package:book_nook_admin/services/storage/store.dart';
import 'package:meta/meta.dart';

part 'all_book_state.dart';

class AllBookCubit extends Cubit<AllBookState> {
  AllBookCubit() : super(AllBookInitial());
  BookRepository _bookREpository = BookRepository(BookWebServices());
   List<BookInfo> allBooksList=[];

  // get convert => null;

  Future<void> getBooks() async {
    try {
      emit(AllBookLoading());
     await ProfileCubit().profile();
      await _bookREpository.getBooks(id: Store.myAdmin.id!).then((allBooks) => {
            // print("Hiiiiiiiiiiiiii All Books cubit"),
            // print(allBooks),
            emit(AllBookSuccessful(allBooks)),
            this.allBooksList = allBooks
          });
    } catch (e) {
      // return [];
    }
    // return allBooksList;
  }

  //---------------------------------------Search ------------------------------------------------

  List searchedLib = [];
  List searchedBook = [];

  bool isSearched = false;
  List booksFromApi = [];
  static AllBookCubit get(context) => BlocProvider.of(context);

  void inSearchScreen() {
    getRecentApi();
    emit(Recent());
  }

  void delete(element) {
    recent.remove(element);
    emit(DeleteRecent());
  }

  void clearAll() {
    recent.clear();
    deleteRecentFromApi();
    emit(ClearAll());
  }

  void addToSearchedList(String searchedCharacter) {
    // print(searchTextController.text);
    searchedBook = this
        .allBooksList
        .where((book) =>
            book.name.toString().toLowerCase().contains(searchedCharacter))
        .toList();

    // searchedLib = libFromApi
    //     .where((lib) =>
    //         lib["library_name"].toLowerCase().startsWith(searchedCharacter))
    //     .toList();
    print(searchedCharacter);
    // print("searchedBook:$searchedBook");
    emit(StartSearch());
  }

  void startSearching() {
    isSearched = true;
    emit(StartSearch());
  }

  void stopSearching() {
    isSearched = false;
    getRecentApi();
    emit(StopSearch());
  }

  // void topBooks() {
  //   for (int i = 0; i < booksFromApi.length; i++) {
  //     for (int j = 0; j < topBook.length; j++) {
  //       if (i == j) {
  //         topBook[i]['title'] = booksFromApi[i]['name'];
  //       }
  //     }
  //   }
  //   emit(TopBooks());
  // }

  List<String> recent = [];
  List recentFromApi = [];
  void recents() {
    recent = [];
    recentFromApi.forEach((val) {
      recent.add(val['title']);
    });
    log("$recent");
    emit(Recent());
  }

  Future sendSearchtoApi({required String bookname}) async {
    try {
      log('inside');
      var response = await http.get(
        Uri.parse("${Store.baseURL}/api/search/book/${bookname}"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${Store.token}'
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse =
            json.decode(response.body) as Map<String, dynamic>;
        log('Request success with status: ${response.statusCode}.');
        log('${jsonResponse['data']}');
      } else {
        log('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future getRecentApi() async {
    try {
      log('inside');
      var response = await http.get(
          Uri.parse("${Store.baseURL}/api/search/books/recentSearches"),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${Store.token}'
          });

      if (response.statusCode == 200) {
        var jsonResponse =
            json.decode(response.body) as Map<String, dynamic>;
        log('Request success with status: ${response.statusCode}.');
        log('${jsonResponse['data']}');
        recentFromApi = jsonResponse['data'].toList();
        recents();
      } else {
        log('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  // Future getTopBooksApi() async {
  //   try {
  //     log('inside Top');
  //     var response = await http.get(
  //         Uri.parse(
  //             "${Store.baseURL}/api/search/books/mostSearched"),
  //         headers: {
  //           'Accept': 'application/json',
  //           'Authorization': 'Bearer ${Store.token}'});

  //     if (response.statusCode == 200) {
  //       Map<String, dynamic> jsonResponse = jsonDecode(response.body);
  //       print("${jsonResponse['data']}");
  //       log('Request success with status: ${response.statusCode}.');
  //       booksFromApi = jsonResponse['data'].toList();
  //       // topBooks();
  //       //log('$jsonResponse');
  //     } else {
  //       log('Request failed with status: ${response.statusCode}.');
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }

  Future deleteRecentFromApi() async {
    try {
      log('inside delete');
      var response = await http.delete(
        Uri.parse("${Store.baseURL}/api/search/books/clearRecentSearches"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${Store.token}'
        },
      );
      if (response.statusCode == 200) {
        var jsonResponse =
            json.decode(response.body) as Map<String, dynamic>;
        log('Request success with status: ${response.statusCode}.');
        log('${jsonResponse['data']}');
      } else {
        log('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  List libFromApi = [];

  // Future getLibrarysApi() async {
  //   try {
  //     log('inside Top');
  //     var response = await http.get(
  //         Uri.parse("${Store.baseURL}/api/about/library/all"),
  //         headers: {
  //           'Accept': 'application/json',
  //           'Authorization':'Bearer ${Store.token}'  });

  //     if (response.statusCode == 200) {
  //       Map<String, dynamic> jsonResponse = jsonDecode(response.body);
  //       print("${jsonResponse['data']}");
  //       log('Request success with status: ${response.statusCode}.');
  //       libFromApi = jsonResponse['data'].toList();
  //       // topBooks();
  //       //log('$jsonResponse');
  //     } else {
  //       log('Request failed with status: ${response.statusCode}.');
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }
}
