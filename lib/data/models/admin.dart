import 'dart:io';
import 'package:flutter/material.dart';

class Admin {
  int? id;
  int? roleId;
  String? email;
  String? providerId;
  int? isVerified;
  String? firstName;
  String? middleName;
  String? lastName;
  String? libraryName;
  String? phone;
  String? openTime;
  String? closeTime;
  String? image;
  String? status;

  Admin(
      {this.id,
      this.roleId,
      this.email,
      this.providerId,
      this.isVerified,
      this.firstName,
      this.middleName,
      this.lastName,
      this.libraryName,
      this.phone,
      this.openTime,
      this.closeTime,
      this.image,
      this.status});

  Admin fromJson1(Map<String, dynamic> json) {
    
    return Admin(
        roleId : json['role_id'],
        email : json['email'],
        providerId : json['provider_id'],
        isVerified : json['is_verified'],
        id : json['id'],
        firstName : json['first_name'],
        middleName : json['middle_name'],
        lastName : json['last_name'],
        libraryName : json['library_name'],
        phone : json['phone_number'].toString(),
        openTime : json['open_time'],
        closeTime : json['close_time'],
        image : json['image'],
        status : json['status']);
  }

  Admin.fromJson(Map<String, dynamic> json) {
    roleId = json['role_id'];
    email = json['email'];
    providerId = json['provider_id'];
    isVerified = json['is_verified'];
    id = json['user_id'];
    firstName = json['firstName'];
    middleName = json['middleName'];
    lastName = json['lastName'];
    libraryName = json['libraryName'];
    phone = json['phone'];
    openTime = json['open_time'];
    closeTime = json['close_time'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['role_id'] = this.roleId;
    data['email'] = this.email;
    data['provider_id'] = this.providerId;
    data['is_verified'] = this.isVerified;
    data['firstName'] = this.firstName;
    data['middleName'] = this.middleName;
    data['lastName'] = this.lastName;
    data['libraryName'] = this.libraryName;
    data['phone'] = this.phone;
    data['open_time'] = this.openTime;
    data['close_time'] = this.closeTime;
    data['image'] = this.image;
    data['status'] = this.status;
    return data;
  }
}






// import 'package:book_nook_admin/services/storage/store.dart';
// import 'package:flutter/material.dart';


// class Admin {
//   late String password , GoogleID ;
//   late String email;
//   late String firstName,lastName,middleName,
//       id,
//       libraryName,
//       Phon,
//       confirmPassword,
//       libraryAddress,
//       token;

//   // Admin.fromjson();
//   Admin.fromJson(Map<String, dynamic> json) {
//     id = json[''];
//     email = json[''];
//     if (Store.state == 1)
//       password = json[''];
//     else if (Store.state == 2) GoogleID = json[''];
//     firstName = json[''];
//     libraryName = json[''];
//     Phon = json[''];
//     confirmPassword = json[''];
//     libraryAddress = json[''];
//   }
// }
