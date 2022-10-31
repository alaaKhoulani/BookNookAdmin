import 'dart:convert';
import 'dart:io';
import 'package:book_nook_admin/data/models/Book.dart';
import 'package:book_nook_admin/services/storage/store.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:from_to_time_picker/generated/l10n.dart';
import 'package:http/http.dart' as http;

class BookWebServices {
 
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

      print(response.body);
      if (response.statusCode == 200) {
        List books = (json.decode(response.body))['data'];

        //     .map((e) => BookInfo.fromJson(e))
        //     .toList());
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
    try {
      print("send a book");

      Map<String, dynamic> data = {
        "name": bookName,
        "num_of_page": numberPage,
        "quantity": quantity,
        "purchasing_price": purchasingPrice,
        "selling_price": sellPrice,
        "state": "new",
        "summary": summary,
      };
      print("=========================");
      print(categories);
      print(author);
      print("=========================");
      for (int i = 0; i < categories.length; i++) {
        data.addAll({"category[$i]": categories[i]});
      }
      for (int i = 0; i < author.length; i++) {
        data.addAll({"author[$i]": author[i]});
      }

      var response = await http.post(Uri.parse("${Store.baseURL}/api/book/store"),
          headers: {
            "Authorization": 'Bearer ${Store.token}',
            'Charset': 'utf-8',
            "Accept": "application/json",
          },
          body: data);

      print(response.statusCode);

      var responseBody = (json.decode(response.body) as Map<String, dynamic>);

      print(response.body);
      if (response.statusCode == 200 && responseBody['status code'] == 200) {
        int bookId = responseBody["data"]["book_id"];
        Map<String, String> headers = {
          "Authorization": 'Bearer ${Store.token}',
          'Charset': 'utf-8',
          "Accept": "application/json",
        };
        var request = http.MultipartRequest(
            'POST', Uri.parse('${Store.baseURL}/api/image/book/$bookId'));
        request.headers.addAll(headers);
        var PikedImage = await http.MultipartFile.fromPath('image', image.path);
        request.files.add(PikedImage);
        print("Image start");
        var imageResponse = await request.send();
        imageResponse.stream.transform(utf8.decoder).listen((value) {
          print(value);
        });
        if (imageResponse.statusCode == 200) {
          print("Image dooneeeee");

          return true;
        } else {
          print("imageeeeeeeeeeeee");
          throw Exception("Something went wrong");
        }
      } else if (response.statusCode == 400) {
        print("1111111111111111111111");
        throw Exception('message');
      } else {
        print("222222222222222222");
        throw Exception("Something went wrong");
      }
    } on SocketException {
      print("3333333333333333");
      throw Exception("No internet connection");
    } on Exception catch (e) {
      print("44444444444444444");
      print(e.toString());
      throw Exception("Some Thing went wrong");
    }
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
    try {
      print("send a book");

      Map<String, dynamic> data = {
        "name": bookName,
        "num_of_page": numberPage,
        "quantity": quantity,
        "purchasing_price": purchasingPrice,
        "selling_price": sellPrice,
        "state": "utilized",
        "summary": summary,
      };
      print("===========uuuuuuuuuuuuuu=============");
      print(categories);
      print(author);
      print("============uiuiuiuiuiui=============");
      for (int i = 0; i < categories.length; i++) {
        data.addAll({"category[$i]": categories[i]});
      }
      for (int i = 0; i < author.length; i++) {
        data.addAll({"author[$i]": author[i]});
      }

      var response = await http.post(Uri.parse("${Store.baseURL}/api/book/store"),
          headers: {
            "Authorization": 'Bearer ${Store.token}',
            'Charset': 'utf-8',
            "Accept": "application/json",
          },
          body: data);

      print(response.statusCode);
      var responseBody = (json.decode(response.body) as Map<String, dynamic>);
      print(response.body);
      if (response.statusCode == 200 && responseBody['status code'] == 200) {
        int bookId = responseBody["data"]["book_id"];
        Map<String, String> headers = {
          "Authorization": 'Bearer ${Store.token}',
          'Charset': 'utf-8',
          "Accept": "application/json",
        };
        var request = http.MultipartRequest(
            'POST', Uri.parse('${Store.baseURL}/api/image/book/$bookId'));
        request.headers.addAll(headers);
        var PikedImage = await http.MultipartFile.fromPath('image', image.path);
        request.files.add(PikedImage);
        print("Image start");
        var imageResponse = await request.send();
        if (imageResponse.statusCode == 200) {
          print("Image dooneeeee utilized");
          return true;
        } else {
          print("imageeeeeeeeeeeee utilized");
          throw Exception("Something went wrong");
        }
      } else if (response.statusCode == 400) {
        print("1111111111111111111111");
        throw Exception('message');
      } else {
        print("222222222222222222");
        throw Exception("Something went wrong");
      }
    } on SocketException {
      print("3333333333333333");
      throw Exception("No internet connection");
    } on Exception catch (e) {
      print("44444444444444444");
      print(e.toString());
      throw Exception("Some Thing went wrong");
    }
  }

  //--------------fetch book -----------------------------------
  Future<Map<String, dynamic>> getBook({required int id}) async {
    try {
      var response =
          await http.get(Uri.parse("${Store.baseURL}/api/book/$id"), headers: {
        'Charset': 'utf-8',
        "Accept": "application/json",
      });
      var responsebody = (json.decode(response.body) as Map<String, dynamic>);
      if (response.statusCode == 200) {
        return responsebody["data"];
      } else if (response.statusCode == 400) {
        throw Exception(
            (json.decode(response.body) as Map<String, dynamic>)['message']);
      } else {
        throw Exception("Something went wrong");
      }
    } on SocketException {
      throw Exception("No internet connection");
    } catch (e) {
      throw Exception("No internet connection");
    }
  }

  

}
