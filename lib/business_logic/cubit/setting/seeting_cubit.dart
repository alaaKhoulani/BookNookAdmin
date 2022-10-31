import 'dart:convert';
import 'package:book_nook_admin/services/storage/store.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'seeting_state.dart';

class SeetingCubit extends Cubit<SeetingState> {
  SeetingCubit() : super(SeetingInitial());

  static SeetingCubit get(context) => BlocProvider.of(context);

  // Future edetAdress({
  //   required String Title,
  //   required String Area,
  //   required String street,
  //   required String Floor,
  //   required String Near,
  //   required String Details,
  // }) async {
  //   try {
  //     print("hiii");
  //     // var response = await http.get(url);
  //     Map<String, String> body = {
  //       "title": Title,
  //       "area": Area,
  //       "street": street,
  //       "floor": Floor,
  //       "near": Near,
  //       "details": Details,
  //     };
  //     print("rama");
  //     http.Response response = await http.post(
  //         Uri.parse("${Store.baseURL}/api/address/1"),
  //         headers: {
  //           'Accept': 'application/json',
  //           'Authorization': ' Bearer ${Store.token}'
  //         },
  //         body: body);

  //     print("hala");
  //     print('Request success with status: ${response.statusCode}.');
  //     var responseBody= json.decode(response.body);
  //     if (response.statusCode == 200 && responseBody['status codre']==200) {
  //       // var jsonResponse = (convert.jsonDecode(response.body) as Map<String,dynamic>)['message'];
  //       Map<String, dynamic> jsonResponse = jsonDecode(response.body);
  //       print("${jsonResponse['message']}");
  //     } else {}
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  // Future getEdetadminprofile({
  //   required String first_name,
  //   required String middle_name,
  //   required String last_name,
  //   required String library_name,
  //   required String phone_number,
  //   required String? open_time,
  //   required String? close_time,
  // }) async {
  //   try {
  //     print("hiii");
  //     // var response = await http.get(url);
  //     Map<String, String> body = {
  //       "first_name": first_name,
  //       "middle_name": middle_name,
  //       "library_name": library_name,
  //       "last_name": last_name,
  //       "phone_number": phone_number,
  //       "open_time": open_time.toString(),
  //       "close_time": close_time.toString(),
  //     };

  //     print("rama");
  //     http.Response response = await http.put(
  //         Uri.parse("${Store.baseURL}/api/information/admin/"),
  //         headers: {
  //           'Accept': 'application/json',
  //           'Authorization': ' Bearer ${Store.token}'
  //         },
  //         body: body);

  //     print("hala");
  //     print(response.body);
  //     print('Request success with status: ${response.statusCode}.');
  //     if (response.statusCode == 200) {
  //       // var jsonResponse = (convert.jsonDecode(response.body) as Map<String,dynamic>)['message'];
  //       Map<String, dynamic> jsonResponse = jsonDecode(response.body);
  //       print("${jsonResponse['message']}");
  //     } else {}
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

//todo in user
  // Future getEdetuserprofile({
  //   required String first_name,
  //   required String middle_name,
  //   required String last_name,
  //   required String gender,
  //   required String phone_number,
  //   required String birth_day,
  // }) async {
  //   try {
  //     print("hiii");
  //     // var response = await http.get(url);
  //     Map<String, String> body = {
  //       "first_name": first_name,
  //       "middle_name": middle_name,
  //       "last_name": last_name,
  //       "gender": gender,
  //       "phone": phone_number,
  //       "birth_day": birth_day,
  //     };

  //     print("rama");
  //     var response = await http.put(
  //         Uri.parse("${Store.baseURL}/api/information/customer/"),
  //         headers: {
  //           'Accept': 'application/json',
  //           'Authorization': ' Bearer ${Store.token}'
  //         },
  //         body: body);

  //     print("hala");

  //     print('Request success with status: ${response.statusCode}.');
  //     if (response.statusCode == 200) {
  //       // var jsonResponse = (convert.jsonDecode(response.body) as Map<String,dynamic>)['message'];
  //       Map<String, dynamic> jsonResponse = jsonDecode(response.body);
  //       print(response.body);
  //     } else {}
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }
  
  Future deletbook({required int id}) async {
    try {
      print("hiii");
      // var response = await http.get(url);

      print("rama");
      var response = await http.delete(
        Uri.parse("${Store.baseURL}/api/book/$id"),
        headers: {
          'Accept': 'application/json',
          'Authorization': ' Bearer ${Store.token}'
        },
      );

      print("hala");
      print('Request success with status: ${response.statusCode}.');
      if (response.statusCode == 200) {
        // var jsonResponse = (convert.jsonDecode(response.body) as Map<String,dynamic>)['message'];
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        print("${jsonResponse['message']}");
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  Future getRate({
    required int id,
    required String star,
  }) async {
    try {
      print("hiii");
      Map<String, String> body = {
        "star": star,
      };

      print("rama");
      var response = await http
          .post(Uri.parse("${Store.baseURL}/api/book/rate/$id"), headers: {
        'Accept': 'application/json',
        'Authorization': ' Bearer ${Store.token}'
      }, body: {
        "star": star
      });

      print("hala");

      print('Request success with status: ${response.statusCode}.');
      if (response.statusCode == 200) {
        // var jsonResponse = (convert.jsonDecode(response.body) as Map<String,dynamic>)['message'];
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        print("${jsonResponse['message']}");
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  Future savebook({required int id}) async {
    try {
      print("hiii");
      // var response = await http.get(url);

      print("rama");
      var response = await http.post(
        Uri.parse("${Store.baseURL}/api/save/$id"),
        headers: {
          'Accept': 'application/json',
          'Authorization': ' Bearer ${Store.token}'
        },
      );

      print("hala");

      print('Request success with status: ${response.statusCode}.');
      if (response.statusCode == 200) {
        // var jsonResponse = (convert.jsonDecode(response.body) as Map<String,dynamic>)['message'];
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        print("${jsonResponse['message']}");
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  Future deletoffer({required int id}) async {
    try {
      print("hiii");
      print("rama");
      var response = await http
          .delete(Uri.parse("${Store.baseURL}/api/offer/$id"), headers: {
        'Accept': 'application/json',
        'Authorization': ' Bearer ${Store.token}'
      });

      print("hala");
      print('Request success with status: ${response.statusCode}.');
      if (response.statusCode == 200) {
        // var jsonResponse = (convert.jsonDecode(response.body) as Map<String,dynamic>)['message'];
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        print("${jsonResponse['message']}");
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  Future edaitbook({
    required int id,
    required String Name,
    required String Summary,
    required String Page_number,
    required String Purchasing_price,
    required String Selling_price,
    required String Quantity,
    required String Authors,
    required String Category,
  }) async {
    try {
      print("hiii");
      // var response = await http.get(url);
      Map<String, String> body = {
        "Name": Name,
        "Summary": Summary,
        "Page_number": Page_number,
        "Purchasing_price": Purchasing_price,
        "Selling_price": Selling_price,
        "Quantity": Quantity,
        "Authors": Authors,
        "Category": Category,
      };
      print("rama");
      var response = await http.put(Uri.parse("${Store.baseURL}/api/book/$id"),
          headers: {
            'Accept': 'application/json',
            'Authorization': ' Bearer ${Store.token}'
          },
          body: body);

      print("hala");
      print('Request success with status: ${response.statusCode}.');
      if (response.statusCode == 200) {
        // var jsonResponse = (convert.jsonDecode(response.body) as Map<String,dynamic>)['message'];
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        print("${jsonResponse['message']}");
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  Future deletComent({required int id}) async {
    try {
      print("hiii");
      print("rama");
      var response = await http.delete(
        Uri.parse("${Store.baseURL}/api/comment/$id"),
        headers: {
          'Accept': 'application/json',
          'Authorization': ' Bearer ${Store.token}'
        },
      );

      print("hala");
      print('Request success with status: ${response.statusCode}.');
      if (response.statusCode == 200) {
        // var jsonResponse = (convert.jsonDecode(response.body) as Map<String,dynamic>)['message'];
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        print("${jsonResponse['message']}");
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  Future deletQuote({required int id}) async {
    try {
      print("hiii");
      print("rama");
      var response = await http.delete(
        Uri.parse("${Store.baseURL}/api/quote/$id"),
        headers: {
          'Accept': 'application/json',
          'Authorization': ' Bearer ${Store.token}'
        },
      );

      print("hala");
      print('Request success with status: ${response.statusCode}.');
      if (response.statusCode == 200) {
        // var jsonResponse = (convert.jsonDecode(response.body) as Map<String,dynamic>)['message'];
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        print("${jsonResponse['message']}");
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  Future UpdateQuote({required String value, required int id}) async {
    try {
      print("hiii");
      // var response = await http.get(url);
      Map<String, String> body = {
        "value": value,
      };
      print("rama");
      var response = await http.put(Uri.parse("${Store.baseURL}/api/quote/$id"),
          headers: {
            'Accept': 'application/json',
            'Authorization': ' Bearer ${Store.token}'
          },
          body: body);

      print("hala");
      print('Request success with status: ${response.statusCode}.');
      if (response.statusCode == 200) {
        // var jsonResponse = (convert.jsonDecode(response.body) as Map<String,dynamic>)['message'];
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        print("${jsonResponse['message']}");
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  Future CancleOrder({required int id}) async {
    try {
      print("hiii");
      print("rama");
      var response = await http.post(
        Uri.parse("${Store.baseURL}/api/order/$id/cancel_order"),
        headers: {
          'Accept': 'application/json',
          'Authorization': ' Bearer ${Store.token}'
        },
      );

      print("hala");
      print('Request success with status: ${response.statusCode}.');
      if (response.statusCode == 200) {
        // var jsonResponse = (convert.jsonDecode(response.body) as Map<String,dynamic>)['message'];
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        print("${jsonResponse['message']}");
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }
}
