import 'dart:convert';
import 'package:book_nook_admin/business_logic/cubit/login_cubit/cubit/log_in_cubit.dart';
import 'package:book_nook_admin/consts/constant.dart';
import 'package:book_nook_admin/consts/myColors.dart';
import 'package:book_nook_admin/data/web_services/admin_web_services.dart';
import 'package:book_nook_admin/services/storage/store.dart';
import 'package:book_nook_admin/services/validate/validation.dart';
import 'package:book_nook_admin/ui/widget/Header.dart';
import 'package:book_nook_admin/ui/widget/MyButton.dart';
import 'package:book_nook_admin/ui/widget/inputCard.dart';
import 'package:book_nook_admin/ui/widget/loaading_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogIn extends StatelessWidget {
  LogIn({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? validateAddress(var address) {
    String patttern = r'(^[a-zA-Z0-9 ,.-]*$)';
    RegExp regExp = new RegExp(patttern);
    int state = 0;
    if (address.isEmpty || address.length == 0) {
      state = 1;
    } else if (address.length < 10) {
      state = 3;
    } else {
      state = 0;
    }
    if (state == 1) {
      return "Please enter address";
    } else if (state == 3) {
      return "Please enter minimum 10 characters";
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    screenHeight = screenSize.height;
    screenWidth = screenSize.width;
    return BlocListener<LogInCubit, LogInState>(
      listener: (context, state) {
        if (state is LogInInSubmitting) {
          // print("Doneeeeeeeeeeeeeeeeeeeeeeeeeeee");
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return LoadingDialog();
            },
          );
        } else if (state is LogInSuccess) {
          // print("Doneeeeeeeeeeeeeeeeeeeeeeeeeeee");
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, 'home');
        } else if (state is LogInInFailure) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text((state.exception.toString() + '.'))));
        }
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: MyColors.myWhite,
          body: SingleChildScrollView(
            child: Column(children: [
              SizedBox(
                height: 60,
              ),
              Header(height: screenHeight, width: screenWidth, title: "Log In"),
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: screenWidth * 0.1,
                      ),
                      InputCard(
                        controller: emailController,
                        name: 'Email',
                        vlaidate: Validation.validateEmail,
                        width: screenWidth * 0.9,
                      ),
                      InputCard(
                        controller: passwordController,
                        name: 'Password',
                        vlaidate: Validation.validateRegisterPassword,
                        width: screenWidth * 0.9,
                      ),
                      GestureDetector(
                        onTap: () {
                          AdminWebServices().forgetPassword();
                        },
                        child: Text(
                          "Forget your password",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 14,
                            color: MyColors.myPurble,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      MyButton(
                          child: Text(
                            "login",
                            style: TextStyle(color: MyColors.myWhite),
                          ),
                          fun: () {
                            BlocProvider.of<LogInCubit>(context).LogIn(
                                email: emailController.value.text,
                                password: passwordController.value.text,
                                fcmToken: Store.fcmToken!);
                          },
                          context: context),
                      SizedBox(
                        height: 20,
                      ),
                      toSignUp(context),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget toSignUp(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Dont have an account?",
          style: TextStyle(
            // decoration: TextDecoration.underline,
            fontSize: 14,
            color: MyColors.myBlack,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, 'SignUp');
          },
          child: Text(
            "Sign Up",
            style: TextStyle(
              color: MyColors.myPurble,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
