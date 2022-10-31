import 'package:book_nook_admin/data/models/address.dart';
import 'package:book_nook_admin/data/models/admin.dart';
import 'package:get_storage/get_storage.dart';

class Store {
  Store() {
    store = GetStorage();
  }

  static late Admin myAdmin;
  static late List<Address> address;
  static String? token;
  static bool is_verify = false;
  static String? fcmToken;
  static int? state;
  static late GetStorage store;
  // static GlobalKey<RefreshIndicatorState>? homeRefreshIndicatorKey;
  // static GlobalKey<RefreshIndicatorState>? myProductsRefreshIndicatorKey;
  static String baseURL = 'http://192.168.1.14:8000';
}
