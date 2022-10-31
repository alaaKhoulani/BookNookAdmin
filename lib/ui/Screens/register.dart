import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:book_nook_admin/business_logic/cubit/register_cubit/register_cubit.dart';
import 'package:book_nook_admin/consts/constant.dart';
import 'package:book_nook_admin/consts/myColors.dart';
import 'package:book_nook_admin/data/models/admin.dart';
import 'package:book_nook_admin/services/storage/store.dart';
import 'package:book_nook_admin/services/validate/validation.dart';
import 'package:book_nook_admin/ui/widget/Header.dart';
import 'package:book_nook_admin/ui/widget/MyButton.dart';
import 'package:book_nook_admin/ui/widget/inputCard.dart';
import 'package:book_nook_admin/ui/widget/loaading_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Register extends StatelessWidget {
  Register({Key? key}) : super(key: key);
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phonController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController libraryNameConmtroller = TextEditingController();
  TextEditingController libraryAddressController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var size, height, width;

  String? validateAddress(var address) {
    String patttern = r'(^[a-zA-Z0-9 ,.-]*$)';
    RegExp regExp = new RegExp(patttern);
    int state = 0;
    var array = address.split('');
    array.forEach((element) {
      print(element); // iterating char by char
    });
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
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    screenSize = MediaQuery.of(context).size;
    screenHeight = screenSize.height;
    screenWidth = screenSize.width;
    // final cubit = BlocProvider.of<RegisterCubit>(context);

    return   GestureDetector(
          // onTap: () => FocusScope.of(context).unfocus(),
          child:  Scaffold(
            backgroundColor: MyColors.myWhite,
            body: BlocConsumer<RegisterCubit, RegisterState>(
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
            Navigator.pushReplacementNamed(context, 'verification');
          } else if (state is RegisterFailure) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text((state.exception.toString() + '.'))));
          } else {
             Container();
          }
        },
              builder: (context, state) {
                return SafeArea(
                          child: Column(
                            children: [
                              Header(height: height, width: width, title: "SignUp"),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.fromLTRB(30, 30, 30, 10),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Column(
                                      children: [
                                        Form(
                                          child: Column(
                                            children: [
                                              // TextFormField(
                                              //   controller: emailController,
                                              // ),
                                              // TextFormField(
                                              //   controller: passwordController,
                                              // ),
                                              // TextFormField(
                                              //   controller: confirmPasswordController,
                                              // ),
                                              InputCard(
                                                  name: "Your Email",
                                                  controller: emailController,
                                                  vlaidate: Validation.validateEmail),
                                              InputCard(
                                                  name: "Password",
                                                  controller: passwordController,
                                                  vlaidate:
                                                      Validation.validateRegisterPassword),
                                              InputCard(
                                                  name: "Confirm Password",
                                                  controller: confirmPasswordController,
                                                  vlaidate:
                                                      Validation.validateRegisterPassword),
                                              SizedBox(
                                                height: 20,
                                              ),
                                            ],
                                          ),
                                        ),
                                        // TextButton(
                                        //     onPressed: () async {
                                        //       // await register(
                                        //       //     email: "alaakhololo@gmail.com",
                                        //       //     password: "123456789",
                                        //       //     confirmPssword: "123456789",
                                        //       //     fcmToken: aStore.fcm_token!);
                                        //       Navigator.pushReplacementNamed(
                                        //           context, 'verification');
                                        //     },
                                        //     child: Text("test")),
                                        MyButton(
                                            child: Text(
                                              "Register",
                                              style: TextStyle(color: MyColors.myWhite),
                                            ),
                                            fun: () async {
                                              if (emailController.value.text.isNotEmpty &&
                                                  emailController.value.text != null &&
                                                  passwordController
                                                      .value.text.isNotEmpty &&
                                                  passwordController.value.text != null &&
                                                  confirmPasswordController
                                                      .value.text.isNotEmpty &&
                                                  confirmPasswordController.value.text !=
                                                      null) {
                                                await BlocProvider.of<RegisterCubit>(
                                                        context)
                                                    .register(
                                                        email: emailController.value.text,
                                                        password:
                                                            passwordController.value.text,
                                                        confirmPassword:
                                                            confirmPasswordController
                                                                .value.text,
                                                        fcmToken: Store.fcmToken!);
                                              } else {
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(
                                                        content: Text(
                                                            ('All fields are requird.'))));
                                              }
                                            },
                                            context: context),
                                        toLogin(context),
                                        const SizedBox(height: 10),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                            ],
                          ),
                        );
              },
            ),
          ),
  );
  }

  Widget toLogin(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have any account ? ",
          style: TextStyle(
            color: MyColors.myBlack,
            // decoration: TextDecoration.underline,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, "login");
          },
          child: Text(
            "log in",
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
