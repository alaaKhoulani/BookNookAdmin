// import 'package:flutter/material.dart';
// import 'package:flutter_login_facebook/flutter_login_facebook.dart';

// class FacebookSignInApi {
//   static final _facebookSignIn = FacebookLogin();
//   static Future<FacebookLoginResult> login() => _facebookSignIn.logIn();
// }
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

class FacebookSignInApi {
  // static const _facebookAuth=FacebookAuth;
  // static var user;
  static login() async {
    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status == LoginStatus.success) {
      var user = await FacebookAuth.instance.getUserData();
      return user;
    } else {
      print(result.message);
      return null; 
    }
  }
}
