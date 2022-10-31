import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:book_nook_admin/data/models/address.dart';
import 'package:book_nook_admin/data/models/admin.dart';
import 'package:book_nook_admin/data/web_services/admin_web_services.dart';
import 'package:book_nook_admin/ui/Screens/edit_address.dart';

class AdminRepository {
  final AdminWebServices _adminrWebServices;
  AdminRepository(this._adminrWebServices);

  Future<String> register(
      {required String email,
      required String password,
      required String confirmPassword,
      required String fcmToken}) async {
    final response = await _adminrWebServices.register(
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        fcmToken: fcmToken);
    print("token=====================");
    // print(response['access_token']);
    return response['access_token'];
  }

  Future<String> logIn({
    required String email,
    required String password,
    required String fcmToken,
  }) async {
    var response = await _adminrWebServices.logIn(
        email: email, password: password, fcmToken: fcmToken);
    return response['access_token'];
  }

  Future<bool> addAddress(
      {required String title,
      required String area,
      required String street,
      required String floor,
      required String near,
      String details = ''}) async {
    return await _adminrWebServices.addAddress(
        area: area,
        title: title,
        street: street,
        floor: floor,
        near: near,
        details: details);
  }

  Future<bool> editAdress(
      {required String title,
      required String area,
      required String street,
      required String floor,
      required String near,
      String details = ''}) async {
    return await _adminrWebServices.editAdress(
        Area: area,
        Title: title,
        street: street,
        Floor: floor,
        Near: near,
        Details: details);
  }

  //----------------------- get address---------------------------------
  Future<List<Address>> getAddresses() async {
    List addresses = await _adminrWebServices.getAddress();

    List<Address> _list = [];
    for (var i = 0; i < addresses.length; i++) {
      _list.add(Address().fromJson(addresses[i]));
      print(addresses[i]['details']);
      print(_list[i].details);
    }
    return _list;
  }

  //-----------------------verify---------------------------
  Future<bool> isVerify({
    required String token,
  }) async {
    var response = await _adminrWebServices.isVerify(token: token);
    return response["verified"] == 1 ? true : false;
  }

  //--------------------information-------------------------
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
    return await _adminrWebServices.submitInformation(
        firstName: firstName,
        middleName: middleName,
        lastyName: lastyName,
        libraryName: libraryName,
        phonNumber: phonNumber,
        start: start,
        end: end,
        token: token);
    // return {};
  }

  //--------------------Edit-------------------------
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
    print("repo");
    if (start == null) {}
    return await _adminrWebServices.editProfile(
        firstName: firstName,
        middleName: middleName,
        lastyName: lastyName,
        libraryName: libraryName,
        phonNumber: phonNumber,
        start: start,
        end: end,
        token: token);
    // return {};
  }

  //--------------------profile-------------------------------------------
  Future<Admin> profile() async {
    var response = await _adminrWebServices.profile();
    // print(Admin().fromJson1(response).libraryName);
    return Admin().fromJson1(response);
  }

  //------------------- add photo---------------------
  Future<bool> addPhoto({required File image}) async {
    return await _adminrWebServices.addPhoto(image: image);
  }

  //------------------ log out---------------------------------
  Future<bool> logOut() async {
    return await _adminrWebServices.logOut();
  }

  //------------------provider log in-----------------
  Future<String> ProviderLogIn({
    required String email,
    required String provider_id,
    required String fcmToken,
  }) async {
    var response = await _adminrWebServices.ProviderlogIn(
        email: email, provider_id: provider_id, fcmToken: fcmToken);
    return response['token'];
  }
}
