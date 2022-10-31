import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:book_nook_admin/services/storage/store.dart';
import 'package:http/http.dart' as http;

class LibraryWebServices {
  Future<Map<String, dynamic>> getLibraryInfo({required int id}) async {
    try {
      var response = await http
          .get(Uri.parse("${Store.baseURL}/api/about/library/${id}"), headers: {
        "Accept": "application/json",
      });
      var responseBody = json.decode(response.body);
      if (response.statusCode == 200 && responseBody["status code"] == 200) {
        return responseBody["data"];
      } else if (response.statusCode == 400 ||
          responseBody["status code"] == 400) {
        return ((json.decode(response.body)
            as Map<String, dynamic>)['message']);
      } else
        throw Exception("Some thing went wrong");
    } on SocketException {
      throw Exception("No internet connection");
    } catch (e) {
      throw Exception("Some thing went wrong");
      // return [];
    }
  }
  
  Future<List> getBooks({
    required int id,
  }) async {
    try {
      // print("======================fetch book start $id==============");
      var response = await http.get(
          Uri.parse("${Store.baseURL}/api/about/library/books/$id"),
          headers: {
            "Accept": "application/json",
          });

      // print(response.body);
      if (response.statusCode == 200) {
        List books = (json.decode(response.body))['data'];

        return books;
      } else if (response.statusCode == 400) {
        throw Exception(
            (json.decode(response.body) as Map<String, dynamic>)['message']);
      } else {
        throw Exception("Something went wrong");
      }
    } on SocketException {
      throw Exception("No internet connection");
    } catch (e) {
      return [];
    }
  }
  
  Future<List> getLibraryOffers({
    required int id,
  }) async {
    try {
      // print("======================fetch book start $id==============");
      var response = await http.get(
          Uri.parse("${Store.baseURL}/api/offer/library/$id"),
          headers: {
            "Accept": "application/json",
          });

      // print(response.body);
      if (response.statusCode == 200) {
        List books = (json.decode(response.body))['data'];

        return books;
      } else if (response.statusCode == 400) {
        throw Exception(
            (json.decode(response.body) as Map<String, dynamic>)['message']);
      } else {
        throw Exception("Something went wrong");
      }
    } on SocketException {
      throw Exception("No internet connection");
    } catch (e) {
      return [];
    }
  }
}
