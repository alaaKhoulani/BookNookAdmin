import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:book_nook_admin/data/models/admin.dart';
import 'package:book_nook_admin/services/storage/store.dart';
import 'package:easy_localization/easy_localization.dart';
// import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class AdminWebServices {
  // late Admin admin;

  //-------------------------------- register ------------------------------------
  Future<Map<String, dynamic>> register({
    required String email,
    required String password,
    required String confirmPassword,
    required String fcmToken,
  }) async {
    try {
      print("======================register start==============");
      var response =
          await http.post(Uri.parse("${Store.baseURL}/api/register"), body: {
        "role_id": '1',
        "email": email,
        "password": password,
        "password confirmation": confirmPassword,
        "fcm_token": "fcmToken",
      });
      print("======================register start==============");
      print(response.body);

      var responseBody = (json.decode(response.body));

      if (response.statusCode == 200 && responseBody['status code'] == 200) {
        print(response.body);
        return (json.decode(response.body) as Map<String, dynamic>)['data'];
      } else if (response.statusCode == 400 ||
          responseBody['status code'] == 400) {
        throw Exception(
            (json.decode(response.body) as Map<String, dynamic>)['message']);
      } else {
        throw Exception("Something went wrong");
      }
    } on SocketException {
      throw Exception("No internet connection");
    }
  }

  //------------------ provider login ---------------------------
  Future<Map<String, dynamic>> ProviderlogIn({
    required String email,
    required String provider_id,
    required String fcmToken,
  }) async {
    try {
      print("======================provider login start==============");

      var response = await http.post(
          Uri.parse("${Store.baseURL}/api/provider/loginOrRegister"),
          headers: {
            "Accept": "application/json",
          },
          body: {
            "email": email,
            "provider_id": provider_id,
            "fcm_token": "fcmToken",
            "role_id": '1',
          });
      print(response.body);
      var responseBody = json.decode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200 && responseBody["status code"] == 200) {
        print(response.statusCode);
        print(response.body);
        return (json.decode(response.body) as Map<String, dynamic>)['data'];
      } else if (response.statusCode == 400 ||
          responseBody["status code"] == 400) {
        throw Exception(
            (json.decode(response.body) as Map<String, dynamic>)['message']);
      } else {
        throw Exception("Something went wrong");
      }
    } on SocketException {
      throw Exception("No internet connection");
    } on Exception {
      throw Exception("Some Thing went wrong");
    }
  }

  //----------------------------------verify---------------------------------------------

  Future<Map<String, dynamic>> isVerify({required String token}) async {
    var response =
        await http.get(Uri.parse("${Store.baseURL}/api/is_verified"), headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer $token',
    });
    print("very");
    var responseBody = json.decode(response.body) as Map<String, dynamic>;

    print(response.body);
    if (response.statusCode == 200) {
      return (json.decode(response.body) as Map<String, dynamic>)['data'];
    } else if (response.statusCode == 400) {
      throw Exception(
          (json.decode(response.body) as Map<String, dynamic>)['message']);
    } else {
      throw Exception("Something went wrong");
    }
  }

  //-------------------------------------Logn in ---------------------------------------------

  Future<Map<String, dynamic>> logIn({
    required String email,
    required String password,
    required String fcmToken,
  }) async {
    try {
      print("======================login start==============");

      var response =
          await http.post(Uri.parse("${Store.baseURL}/api/login"), headers: {
        "Accept": "application/json",
      }, body: {
        "email": email,
        "password": password,
        "fcm_token": fcmToken,
        "role_id": '1',
      });
      print(response.statusCode);
      var responseBody = json.decode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200 && responseBody["status code"] == 200) {
        print(response.body);
        return (json.decode(response.body) as Map<String, dynamic>)['data'];
      } else if (response.statusCode == 400 ||
          responseBody["status code"] == 400) {
        throw Exception(
            (json.decode(response.body) as Map<String, dynamic>)['message']);
      } else {
        throw Exception("Something went wrong");
      }
    } on SocketException {
      throw Exception("No internet connection");
    } on Exception {
      throw Exception("Some Thing went wrong");
    }
  }

  //-------------------------------- register information------------------------------------

  Future<bool> submitInformation({
    required String firstName,
    required String middleName,
    required String lastyName,
    required String libraryName,
    required String phonNumber,
    required String start,
    required String end,
    required String token, //Bearer
  }) async {
    try {
      print("web");
      var response = await http
          .post(Uri.parse("${Store.baseURL}/api/information/admin"), headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $token'
      }, body: {
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastyName,
        "library_name": libraryName,
        "phone": phonNumber,
        'open_time': start,
        'close_time': end
      });
      print(response.body);
      var responseBody = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200 && responseBody["status code"] == 200) {
        print("logIn==================");
        print(response.body);
        return true;
      } else if (response.statusCode == 400 ||
          responseBody["status code"] == 400) {
        throw Exception(
            (json.decode(response.body) as Map<String, dynamic>)['message']);
      } else {
        throw Exception("Something went wrong");
      }
    } on SocketException {
      throw Exception("No internet connection");
    }
  }

  //-------------------------------- edit information------------------------------------

  Future<bool> editProfile({
    required String firstName,
    required String middleName,
    required String lastyName,
    required String libraryName,
    required String phonNumber,
    required String start,
    required String end,
    required String token, //Bearer
  }) async {
    try {
      print("web");
      var response = await http
          .put(Uri.parse("${Store.baseURL}/api/information/admin"), headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $token'
      }, body: {
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastyName,
        "library_name": libraryName,
        "phone": phonNumber,
        'open_time': start,
        'close_time': end
      });
      print(response.body);
      var responseBody = json.decode(response.body) as Map<String, dynamic>;

      print(responseBody);
      if (response.statusCode == 200 && responseBody["status code"] == 200) {
        print("Start Profile edit");
        return true;
      } else if (response.statusCode == 400 ||
          responseBody["status code"] == 400) {
        throw Exception(
            (json.decode(response.body) as Map<String, dynamic>)['message']);
      } else {
        throw Exception("Something went wrong");
      }
    } on SocketException {
      throw Exception("No internet connection");
    }
  }

//-------------------------------------profile---------------------------------
  Future<Map<String, dynamic>> profile() async {
    try {
      var response = await http.get(Uri.parse("${Store.baseURL}/api/profile"),
          headers: {
            "Accept": "application/json",
            'Authorization': 'Bearer ${Store.token}'
          });
      var responseBody = json.decode(response.body) as Map<String, dynamic>;
      // print("profile");
      // print(responseBody);
      if (response.statusCode == 200 && responseBody["status code"] == 200) {
        // print("Address done");
        // print(response.body);
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
    }
  }

  //------------------------- add address ---------------------
  Future<bool> addAddress(
      {required String title,
      required String area,
      required String street,
      required String floor,
      required String near,
      String details = ''}) async {
    try {
      var response =
          await http.post(Uri.parse("${Store.baseURL}/api/address/"), headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer ${Store.token}'
      }, body: {
        "title": title,
        "area": area,
        "street": street,
        "floor": floor,
        "near": near,
        "details": details == '' ? "null" : details
      });
      var responseBody = json.decode(response.body) as Map<String, dynamic>;
      print("address");
      print(responseBody);
      if (response.statusCode == 200 && responseBody["status code"] == 200) {
        print("okkk address");
        print(response.body);
        return true;
      } else if (response.statusCode == 400 ||
          responseBody["status code"] == 400) {
        throw Exception(
            (json.decode(response.body) as Map<String, dynamic>)['message']);
      } else {
        throw Exception("Something went wrong");
      }
    } on Exception {
      throw Exception("Something went wrong");
    }
  }

  //---------------------------- edit address ----------------------
  Future<bool> editAdress({
    required String Title,
    required String Area,
    required String street,
    required String Floor,
    required String Near,
    required String Details,
  }) async {
    try {
      print("hiii");
      // var response = await http.get(url);
      Map<String, String> body = {
        "title": Title,
        "area": Area,
        "street": street,
        "floor": Floor,
        "near": Near,
        "details": Details,
      };
      print("rama");
      http.Response response = await http.put(
          Uri.parse("${Store.baseURL}/api/address/${Store.myAdmin.id}"),
          headers: {
            'Accept': 'application/json',
            'Authorization': ' Bearer ${Store.token}'
          },
          body: body);

      print("hala");
      var responseBody = json.decode(response.body);
      print(
          'Request success with statusssssssss: ${responseBody['status code']}.');
      print(responseBody);
      if (response.statusCode == 200 && responseBody['status code'] == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      throw (e);
    }
  }

  //---------------------------- Fetch address ---------------------
  Future<List> getAddress() async {
    try {
      var response = await http.get(
          Uri.parse("${Store.baseURL}/api/address/user_addresses"),
          headers: {
            "Accept": "application/json",
            'Authorization': 'Bearer ${Store.token}'
          });
      var responseBody = json.decode(response.body) as Map<String, dynamic>;
      print(responseBody);
      if (response.statusCode == 200 && responseBody["status code"] == 200) {
        // print("profile done");
        // print(response.body);
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
    }
  }

  //----------------------------add photo------------------------
  Future<bool> addPhoto({required File image}) async {
    try {
      Map<String, String> headers = {
        "Authorization": 'Bearer ${Store.token}',
        // 'Charset': 'utf-8',
        "Accept": "application/json",
      };
      var request = http.MultipartRequest(
          'POST', Uri.parse('${Store.baseURL}/api/image/library'));
      request.headers.addAll(headers);
      var PikedImage = await http.MultipartFile.fromPath('image', image.path);
      request.files.add(PikedImage);
      print("Image start");
      var imageResponse = await request.send();
      // imageResponse.stream.transform(utf8.decoder).listen((value) {
      //   print("stream image");
      //   print(value);
      // });
      print(imageResponse.statusCode);
      // var body=json.decode(imageResponse.stream);
      if (imageResponse.statusCode == 200) {
        print("Image dooneeeee");

        return true;
      } else {
        print("imageeeeeeeeeeeee");
        print(imageResponse.stream.toString());
        //   imageResponse.stream.transform(utf8.decoder).listen((value) {
        //   print("stream image");
        //   print(value);
        // });
        return false;
        // throw Exception("Something went wrong");
      }
    } on Exception {
      throw Exception("Something went wrong");
    }
  }

  //------------------ log out---------------------------------
  Future<bool> logOut() async {
    try {
      var response = await http.post(Uri.parse("${Store.baseURL}/api/logout"),
          headers: {
            "Accept": "application/json",
            'Authorization': 'Bearer ${Store.token}'
          },
          body: {});
      var responseBody = json.decode(response.body) as Map<String, dynamic>;
      print("logout");
      print(responseBody);
      if (response.statusCode == 200 && responseBody["status code"] == 200) {
        print("okkk logout");
        print(response.body);
        return true;
      } else if (response.statusCode == 400 ||
          responseBody["status code"] == 400) {
        throw Exception(
            (json.decode(response.body) as Map<String, dynamic>)['message']);
      } else {
        throw Exception("Something went wrong");
      }
    } on Exception {
      throw Exception("Something went wrong");
    }
  }

  //-------------------------forget Password-----------------------------------
  Future<void> forgetPassword() async {
    var response =
        await http.patch(Uri.parse("${Store.baseURL}/api/password/forgot"));
    print(response.body);
  }
}
