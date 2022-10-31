import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInApi {
  static final _googleSignIn = GoogleSignIn();
  // static Future<GoogleSignInAccount?> login() async {
  //   final GoogleSignInAccount? googleUser =
  //       await _googleSignIn.signIn().catchError((onError) {
  //     print("Error $onError");
  //   });
  //   print(googleUser);
  //   return googleUser;
  // }
  static login() {
    try {
      GoogleSignIn _googleSignIn = GoogleSignIn();
      return _googleSignIn.signIn();
    } on Exception {
      print("Eceeeeeeeeeeeeeeeeeeeeeeeeeeeee");
      return null;
      // return ;
    }
  }

  static Future logOut() => _googleSignIn.disconnect();
}
