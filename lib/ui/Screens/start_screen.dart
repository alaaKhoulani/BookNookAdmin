import 'dart:convert';
import 'dart:io';

import 'package:book_nook_admin/business_logic/cubit/register_cubit/register_cubit.dart';
import 'package:book_nook_admin/consts/constant.dart';
import 'package:book_nook_admin/services/auth/facebook_auth.dart';
import 'package:book_nook_admin/services/auth/google_auth.dart';
import 'package:book_nook_admin/services/storage/store.dart';
import 'package:book_nook_admin/ui/widget/MyButton.dart';
import 'package:book_nook_admin/ui/widget/loaading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../consts/myColors.dart';
import 'package:http/http.dart' as http;

class StartScreen extends StatefulWidget {
  StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  signInWithGoogle() async {
    var user = await GoogleSignInApi.login();
     if (user != null)
      BlocProvider.of<RegisterCubit>(context).ProviderlogIn(
          email: user.email, provider_id: user.id, fcmToken: "fcmToken");

    GoogleSignInApi.logOut();
    print(user);
  }

  signInWithFacebook() async {
    var user = await FacebookSignInApi.login();
    print(user);
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenHeight = screenSize.height;
    var screenWidth = screenSize.width;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: MyColors.myWhite,
        body: BlocListener<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is RegisterSubmitting) {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return LoadingDialog();
                },
              );
            } else if (state is RegisterSuccess) {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, 'adminInformation');
            } else if (state is RegisterFailure) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text((state.exception.toString() + '.'))));
            }
          },
          child: SingleChildScrollView(
            child: Column(children: [
              SizedBox(
                height: 60,
              ),
              Container(
                  //margin: EdgeInsets.only(top: 50),
                  height: screenHeight * 0.25,
                  child: Image(image: AssetImage("assets/images/book-nook.png"))
                  //ShortWaveContainer(),
                  ),
              Text(
                "Book Nook",
                style: h1.copyWith(color: MyColors.myPurble),
                textAlign: TextAlign.left,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 60, 30, 30),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    MyButton(
                        child: Text(
                          "Sign up",
                          style: TextStyle(color: MyColors.myWhite),
                        ),
                        fun: () {
                          Store.state = 1;
                          Navigator.pushNamed(context, 'SignUp');
                        },
                        context: context),
                    SizedBox(
                      height: 20,
                    ),
                    MyButton(
                        child: Text(
                          "Log in",
                          style: TextStyle(color: MyColors.myWhite),
                        ),
                        fun: () => Navigator.pushNamed(context, 'login'),
                        context: context),
                    SizedBox(
                      height: 20,
                    ),
                    MyButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Sign up with Google",
                              style: TextStyle(color: MyColors.myWhite),
                            ),
                            Image.asset(
                              "assets/images/google.png",
                              width: 20,
                            ),
                          ],
                        ),
                        fun: () async {
                          // Store.state = 2;
                          await signInWithGoogle();
                          Navigator.pushNamed(context, 'adminInformation');
                        },
                        context: context),
                    SizedBox(
                      height: 20,
                    ),
                    MyButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Sign up with Facebook",
                              style: TextStyle(color: MyColors.myWhite),
                            ),
                            Image.asset(
                              "assets/images/facebook.png",
                              width: 20,
                            ),
                          ],
                        ),
                        fun: () async {
                          Store.state = 3;
                          print(
                              "=====================================Facebook");
                          await signInWithFacebook();
                          // Navigator.pushNamed(context, 'adminInformation');
                        },
                        context: context),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     Container(
                    //       // width: 150,
                    //       child: InkWell(
                    //         onTap: () {},
                    //         child: CircleAvatar(
                    //           radius: 20,
                    //           backgroundColor: MyColors.myWhite,
                    //           backgroundImage:
                    //               AssetImage("assets/images/google.png"),
                    //         ),
                    //       ),
                    //     ),
                    //     // Container(
                    //     // width: 150,
                    //     //   child: InkWell(
                    //     //     onTap: () {
                    //     //       // signInWithFaceook();
                    //     //     },
                    //     //     child: CircleAvatar(
                    //     //       radius: 20,
                    //     //       backgroundImage:
                    //     //           AssetImage("assets/images/facebook.png"),
                    //     //     ),
                    //     //   ),
                    //     // ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
