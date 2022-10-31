import 'dart:convert';
import 'dart:io';
import 'package:book_nook_admin/data/models/order.dart';
import 'package:book_nook_admin/services/storage/store.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;

class OrderWebServices {
  Future<void> PostOrder(Order order) async {
    try {
      Map<String, dynamic> data = {};
      // data = order.toJson();
      data.addAll({"totalPrice": order.totalPrice.toString()});
      data.addAll({"library_id": order.libraryId.toString()});
      data.addAll({"address_id": "1"});

      for (int i = 0; i < order.orderes!.length; i++) {
        data.addAll(
            {"orderes[$i][book_id]": order.orderes![i].bookId.toString()});
        data.addAll({"orderes[$i][type]": order.orderes![i].type.toString()});
        data.addAll(
            {"orderes[$i][quantity]": order.orderes![i].quantity.toString()});
        data.addAll(
            {"orderes[$i][offer_id]": order.orderes![i].offerId.toString()});
      }

      print("data");
      print(data);
      var response = await http.post(Uri.parse("${Store.baseURL}/api/order/"),
          headers: {
            "Accept": "application/json",
            "Authorization": 'Bearer ${Store.token}',
          },
          body: data);

      var responseBody = json.decode(response.body) as Map<String, dynamic>;
      print("object");
      print(responseBody);
      if (responseBody["statue code"] == 200 && response.statusCode == 200) {
        return responseBody["data"];
      } else if (response.statusCode == 400 ||
          responseBody["status code"] == 400) {
        throw Exception(
            (json.decode(response.body) as Map<String, dynamic>)['message']);
      } else {
        throw Exception("Something went wrong");
      }
    } on SocketException {
      throw Exception("No internet connection");
    } catch (e) {
      throw Exception("Something went wrong");
      // return [];
    }
  }

  //----------------------- show my orders-----------------------------------------
  Future<List> getOrders() async {
    try {
      var response = await http.get(
        Uri.parse("${Store.baseURL}/api/order/orderes_in_library"),
        headers: {
          "Accept": "application/json",
          "Authorization": 'Bearer ${Store.token}'
        },
      );
      var responseBody = json.decode(response.body);
      print(responseBody);
      if (response.statusCode == 200 && responseBody["status code"] == 200) {
        return responseBody["data"];
      } else if (response.statusCode == 400 ||
          responseBody["status code"] == 400) {
        throw Exception(
            (json.decode(response.body) as Map<String, dynamic>)['message']);
      } else {
        throw Exception("Something went wrong");
      }
    } on SocketException {
      throw Exception("No internet connection");
    } catch (e) {
      print(e.toString());
      throw Exception("Something went wrong");
    }
  }

  Future<bool> orderConfirmed({required int id}) async {
    try {
      var response = await http.post(
          Uri.parse("${Store.baseURL}/api/order/${id}/confirm_order"),
          headers: {
            "Accept": "application/json",
            "Authorization": 'Bearer ${Store.token}'
          });

      var responseBody = json.decode(response.body) as Map<String, dynamic>;
      print("object");
      print(responseBody);
      if (responseBody["statue code"] == 200 && response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 400 ||
          responseBody["status code"] == 400) {
        return false;
        // throw Exception(
        //     (json.decode(response.body) as Map<String, dynamic>)['message']);
      } else {
        return false;
        // throw Exception("Something went wrong");
      }
    } on SocketException {
      return false;
      // throw Exception("No internet connection");
    } catch (e) {
      return false;
      // throw Exception("Something went wrong");
      // return [];
    }
  }

  Future<bool> orderDelivered({required int id}) async {
    try {
      print("object");
      var response = await http.post(
          Uri.parse("${Store.baseURL}/api/order/${id}/order_delivered"),
          headers: {
            "Accept": "application/json",
            "Authorization": 'Bearer ${Store.token}'
          });

      var responseBody = json.decode(response.body) as Map<String, dynamic>;
      print(responseBody);
      if (responseBody["statue code"] == 200 && response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 400 ||
          responseBody["status code"] == 400) {
        return false;
        // throw Exception(
        //     (json.decode(response.body) as Map<String, dynamic>)['message']);
      } else {
        return false;
        // throw Exception("Something went wrong");
      }
    } on SocketException {
      return false;
      // throw Exception("No internet connection");
    } catch (e) {
      return false;
      // throw Exception("Something went wrong");
      // return [];
    }
  }

  Future<bool> orderCanceled({required int id}) async {
    try {
      var response = await http.post(
          Uri.parse("${Store.baseURL}/api/order/${id}/cancel_order"),
          headers: {
            "Accept": "application/json",
            "Authorization": 'Bearer ${Store.token}'
          });

      var responseBody = json.decode(response.body) as Map<String, dynamic>;
      print("object");
      print(responseBody);
      if (responseBody["statue code"] == 200 && response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 400 ||
          responseBody["status code"] == 400) {
        return false;
        // throw Exception(
        //     (json.decode(response.body) as Map<String, dynamic>)['message']);
      } else {
        return false;
        // throw Exception("Something went wrong");
      }
    } on SocketException {
      return false;
      // throw Exception("No internet connection");
    } catch (e) {
      return false;
      // throw Exception("Something went wrong");
      // return [];
    }
  }
}
