import 'dart:convert';
import 'dart:developer';
// import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:book_nook_admin/business_logic/cubit/all_book/all_book_cubit.dart';
import 'package:book_nook_admin/data/repository/book_repository.dart';
import 'package:book_nook_admin/data/web_services/book_web_services.dart';
import 'package:book_nook_admin/services/storage/store.dart';
import 'package:book_nook_admin/ui/Screens/add%20offer/model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/Book.dart';
import 'package:http/http.dart' as http;
part 'add_offer_state.dart';

class AddOfferCubit extends Cubit<AddOfferState> {
  AddOfferCubit() : super(AddOfferInitial());

  static AddOfferCubit get(context) => BlocProvider.of(context);

  List<BookInfo> booksjson = [];
  List<Pair> books = [];
  List<Pair> selectedBooks = [];
  Set<String> booksId = {};

  void makeList() async {
    booksjson =
        await BookRepository(BookWebServices()).getBooks(id: Store.myAdmin.id!);
    print("booksjson");
    print(booksjson);
    print(AllBookCubit().allBooksList);
    books = [];
    booksjson.forEach((val) {
      books.add(Pair(name: val.name!, id: val.id!));
      // booksId.add(val.id.toString());
    });
    // print("$books");
    emit(AddOffermakeData());
  }

  void addData(data) {
    // selectedBooks = data;
    booksId.clear();
    selectedBooks.clear;
    print("data");
    print(data);
    data.forEach(
      (element) {
        selectedBooks.add(element);
        booksId.add(element.id.toString());
      },
    );
    // booksjson.forEach((val) {
    //   if (selectedBooks.contains(val.name)) {
    //     booksId.add(val.id.toString());
    //   }
    // });
    print("$booksId");
    print("$selectedBooks");
    emit(AddOfferDataSelected());
  }

  void addOffer() {
    emit(AddOffer());
  }

  bool done = false;

  Future getFromApi(
      {required String title,
      required String totalPrice,
      required String quantity}) async {
    try {
      // var response = await http.get(url);
      Map<String, String> body = {
        "title": title,
        "totalPrice": totalPrice,
        "quantity": quantity
      };
      for (int i = 0; i < booksId.length; i++) {
        body.addAll({"books[$i]": booksId.elementAt(i)});
      }
      done = false;
      var response = await http.post(Uri.parse("${Store.baseURL}/api/offer/"),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${Store.token}'
          },
          body: body);

      var jsonResponse = json.decode(response.body) as Map<String, dynamic>;
      log('Request success with status: ${response.statusCode}.');
      print(response.body);
      if (response.statusCode == 200 && jsonResponse['status code'] == 200) {
        // Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        done = true;
      } else {
        done = false;
      }
      // if (response.statusCode == 200) {
      //   var jsonResponse =
      //       convert.jsonDecode(response.body) as Map<String, dynamic>;
      //   log('Request success with status: ${response.statusCode}.');
      //   AddOfferModel.fromJson(jsonResponse);
      // } else {
      //   log('Request failed with status: ${response.statusCode}.');
      // }
    } catch (e) {
      print(e.toString());
    }
  }

  // Future getDataApi() async {
  //   try {
  //     // var response = await http.get(url);
  //     var response = await http
  //         .get(Uri.parse("${Store.baseURL}/api/offer/5"), headers: {
  //       'Accept': 'application/json',
  //       'Authorization':'Bearer ${Store.baseURL}' });

  //     if (response.statusCode == 200) {
  //       var jsonResponse =
  //           convert.jsonDecode(response.body) as Map<String, dynamic>;
  //       log('Request success with status: ${response.statusCode}.');
  //       log('$jsonResponse');
  //     } else {
  //       log('Request failed with status: ${response.statusCode}.');
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  Future updateDataApi(
      {required int id,
      required String title,
      required String totalPrice,
      required String quantity}) async {
    try {
      // var response = await http.get(url);
      Map<String, String> body = {
        "title": title,
        "totalPrice": totalPrice,
        "quantity": quantity
      };
      for (int i = 0; i < booksId.length; i++) {
        body.addAll({"books[$i]": booksId.elementAt(i)});
      }
      var response = await http.put(Uri.parse("${Store.baseURL}/api/offer/$id"),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${Store.baseURL}'
          },
          body: body);

      log('Request success with status: ${response.statusCode}.');
      if (response.statusCode == 200) {
        // var jsonResponse = (convert.jsonDecode(response.body) as Map<String,dynamic>)['message'];
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        print("${jsonResponse['message']}");
        done = true;
      } else {
        done = false;
      }
      // if (response.statusCode == 200) {
      //   var jsonResponse =
      //       convert.jsonDecode(response.body) as Map<String, dynamic>;
      //   log('Request success with status: ${response.statusCode}.');
      //   AddOfferModel.fromJson(jsonResponse);
      // } else {
      //   log('Request failed with status: ${response.statusCode}.');
      // }
    } catch (e) {
      print(e.toString());
    }
  }
}
