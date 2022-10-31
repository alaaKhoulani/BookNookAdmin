import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:book_nook_admin/services/storage/store.dart';
import 'package:book_nook_admin/ui/Screens/loan%20and%20sold%20books/model.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'sates.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class LoanBooksCubit extends Cubit<LoanBooksStates> {
  LoanBooksCubit() : super(LoanBooksInitial());
  // List soldBook = [
  //   {
  //     'title': 'Book1',
  //     'photo': 'assets/images/bookphoto1.png',
  //     'date': '12/5/2022',
  //     'user name': 'user name',
  //     'price': '500\$',
  //   },
  //   {
  //     'title': 'Book2',
  //     'photo': 'assets/images/bookphoto2.png',
  //     'date': '12/6/2022',
  //     'user name': 'user name',
  //     'price': '200\$',
  //   },
  //   {
  //     'title': 'Book3',
  //     'photo': 'assets/images/bookphoto3.png',
  //     'date': '12/7/2022',
  //     'user name': 'user name',
  //     'price': '100\$',
  //   },
  //   {
  //     'title': 'Book4',
  //     'photo': 'assets/images/bookphoto4.png',
  //     'date': '12/8/2022',
  //     'user name': 'user name',
  //     'price': '800\$',
  //   },
  // ];
  // List LoanBooks = [
  //   {
  //     'title': 'Book1',
  //     'photo': 'assets/images/bookphoto1.png',
  //     'date': '12/5/2022',
  //     'day left': 2,
  //     'isdone': true,
  //     'user name': 'user name',
  //   },
  //   {
  //     'title': 'Book2',
  //     'photo': 'assets/images/bookphoto2.png',
  //     'date': '21/6/2022',
  //     'day left': 7,
  //     'isdone': false,
  //     'user name': 'user name',
  //   },
  //   {
  //     'title': 'Book3',
  //     'photo': 'assets/images/bookphoto3.png',
  //     'date': '1/7/2002',
  //     'day left': 0,
  //     'isdone': true,
  //     'user name': 'user name',
  //   },
  //   {
  //     'title': 'Book4',
  //     'photo': 'assets/images/bookphoto4.png',
  //     'date': '22/7/2022',
  //     'day left': 20,
  //     'isdone': true,
  //     'user name': 'user name',
  //   }
  // ];
  static LoanBooksCubit get(context) => BlocProvider.of(context);

  var isSearched = false;
  var done = false;

  void startSearch() {
    isSearched = true;
    emit(LoanBooksStartSearch());
  }

  void stopSearch() {
    isSearched = false;
    emit(LoanBooksStopSearch());
  }

  // void isDone(String booktitle) {
  //   print("is done ");
  //   done = !done;
  //   LoanBooks.forEach((book) {
  //     print("${book}");
  //     if (book['title'] == booktitle) {
  //       print("${book['isdone']}");
  //       book['isdone'] = !book['isdone'];
  //     }
  //   });
  //   emit(LoanBooksIsDone());
  // }

  List searchLoanBook = [];
  List searchSoldBook = [];
  List<Borrowed> loanBooks = [];
  List<Borrowed> soldBook = [];
  // void getResult(String booktitle) {
  //   searchLoanBook = loanBooks.where(
  //       (book) => book['title'].toLowerCase().startsWith(booktitle)).toList();
  //   print(searchLoanBook);
  //   searchSoldBook = soldBook
  //       .where((book) => book['title'].toLowerCase().startsWith(booktitle))
  //       .toList();
  //   emit(LoanBooksStartSearch());
  // }

  // List bookFromApi = [];
  // List<Borrowed> BooksData = [];
  void getData() async {
    emit(LoanBooksInitial());
    List<Borrowed> loanBooks = await convertData();
    if (isClosed) return;
    emit(LoanBooksGetData(loanBooks));
  }

  Future<List> getLoanBookApi() async {
    try {
      log('inside getLoanBookApi');
      var response = await http.get(
        Uri.parse("${Store.baseURL}/api/order/borrow_books_in_library"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${Store.token}'
        },
      );
      var responseBody = json.decode(response.body);

      if (response.statusCode == 200 && responseBody['status code'] == 200) {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        log('Request success with status: ${response.statusCode}.');
        log('${jsonResponse['data']}');
        // bookFromApi = jsonResponse['data'];
        return responseBody['data'];
      } else {
        log('Request failed with status: ${response.statusCode}.');
        return [];
      }
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  Future<List<Borrowed>> convertData() async {
    List response = await getLoanBookApi();
    List<Borrowed> _list = [];
    for (var i = 0; i < response.length; i++) {
      _list.add(Borrowed().fromJson1(response[i]));
      print(_list[i].userfirstname);
    }
    return _list;
  }

  bool returned = false;
  Future sendReturnedApi({required int id}) async {
    try {
      log('inside getLoanBookApi');
      var response = await http.post(
        Uri.parse("${Store.baseURL}/api/order/$id/restored"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${Store.token}'
        },
      );

      if (response.statusCode == 200) {
        returned = true;
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        log('Request success with status: ${response.statusCode}.');
        log('${jsonResponse['message']}');
      } else {
        log('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
