import 'dart:convert';
import 'dart:io';

import 'package:book_nook_admin/services/storage/store.dart';
import 'package:http/http.dart' as http;

class CommentWebServices{
  
  
  //---------------- show Comment in book -----------------------
  Future<List> getBookComments({
    required int id,
  }) async {
    try {
      var response =
          await http.get(Uri.parse("${Store.baseURL}/api/comment/$id"), headers: {
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

  //------------------------ add Comment--------------------

  Future<bool> addComment({required String comment, required int id}) async {
    try {
      var response = await http
          .post(Uri.parse("${Store.baseURL}/api/comment/$id"), headers: {
        "Accept": "application/json",
        "Authorization": 'Bearer ${Store.token}',
      }, body: {
        "value": comment
      });

      var responseBodey = (json.decode(response.body) as Map<String, dynamic>);
      print(responseBodey);
      if (response.statusCode == 200 && responseBodey["status code"] == 200) {
        return true;
      } else if (response.statusCode == 400) {
        throw Exception(
            (json.decode(response.body) as Map<String, dynamic>)['message']);
      } else {
        throw Exception("Something went wrong");
      }
    } catch (e) {
      throw (Exception());
    }
  }
}