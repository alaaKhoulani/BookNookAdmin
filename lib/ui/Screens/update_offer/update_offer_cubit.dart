import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:book_nook_admin/business_logic/cubit/all_book/all_book_cubit.dart';
import 'package:book_nook_admin/services/storage/store.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import '../../../data/models/Book.dart';

part 'update_offer_state.dart';

class UpdateOfferCubit extends Cubit<UpdateOfferState> {
  UpdateOfferCubit() : super(UpdateOfferInitial());

  
  static UpdateOfferCubit get(context) => BlocProvider.of(context);

  List<BookInfo> booksjson = [];
  List books = [];
  List selectedBooks = [];
  List<String> booksId = [];
  void makeList() {
    booksjson = AllBookCubit().allBooksList;
    books = [];
    booksjson.forEach((val) {
      books.add(val.name);
    });
    print("$books");
    emit(UpdateOffermakeData());
  }

  void UpdateData(data) {
    selectedBooks = data;
    booksId = [];

    booksjson.forEach((val) {
      if (selectedBooks.contains(val.name)) {
        booksId.add(val.id.toString());
      }
    });
    print("$booksId");
    print("$selectedBooks");
    emit(UpdateOfferDataSelected());
  }

  void updateOffer() {
    emit(UpdateOffer());
  }

  bool done = false;

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
        body.addAll({"books[$i]": booksId[i]});
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
      //   UpdateOfferModel.fromJson(jsonResponse);
      // } else {
      //   log('Request failed with status: ${response.statusCode}.');
      // }
    } catch (e) {
      print(e.toString());
    }
  }

}

