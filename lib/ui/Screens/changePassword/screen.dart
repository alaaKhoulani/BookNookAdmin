import 'dart:developer';

import 'package:book_nook_admin/ui/widget/loaading_dialog.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../consts/myColors.dart';
import '../../../services/translate/locale_keys.g.dart';
import '../../widget/MyButton.dart';
import 'cubit.dart';
import 'sates.dart';

class ChangPassword extends StatefulWidget {
  const ChangPassword({Key? key}) : super(key: key);

  @override
  State<ChangPassword> createState() => _ChangPasswordState();
}

class _ChangPasswordState extends State<ChangPassword> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  var _keyForm = GlobalKey<FormState>();
  bool valid = false;
  Widget buildTextField(cubit, cnt, button) {
    bool canSeeicon = true;
    return TextFormField(
      controller: cnt == 1
          ? passwordController
          : cnt == 2
              ? newPasswordController
              : confirmController,
      validator: (inputValue) {
        if (cnt == 1 && inputValue!.isEmpty) {
          return LocaleKeys.cantbeEmpty.tr();
        } else if (cnt == 2 && inputValue!.isEmpty) {
          return LocaleKeys.cantbeEmpty.tr();
        } else if (cnt == 3 &&
            (inputValue!.isEmpty || newPasswordController.text != inputValue)) {
          return LocaleKeys.mustbethesame.tr();
        }
        return null;
      },
      obscureText: cnt == 1
          ? cubit.canSeepassword
          : cnt == 2
              ? cubit.canSeeNewpassword
              : cubit.canSeeConfirm,
      obscuringCharacter: "*",
      maxLength: 8,
      cursorColor: MyColors.myPurble,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: MyColors.myPurble),
          ),
          errorBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: MyColors.myPurble),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: MyColors.myPurble),
          ),
          labelText: cnt == 1
              ? LocaleKeys.password.tr()
              : cnt == 2
                  ? LocaleKeys.newpassword.tr()
                  : LocaleKeys.confirm.tr(),
          labelStyle: TextStyle(color: MyColors.myPurble),
          prefixIcon: Icon(
            Icons.lock,
            color: MyColors.myPurble,
          ),
          suffixIcon: button),
    );
  }

  IconButton buildNewPassWord(cubit) {
    bool isPressed = false;
    return IconButton(
        onPressed: () {
          cubit.isPressedNewPassWord();
        },
        icon: cubit.canSeeNewpassword
            ? Icon(
                Icons.visibility,
                color: MyColors.myPurble,
              )
            : Icon(
                Icons.visibility_off,
                color: MyColors.myPurble,
              ));
  }

  IconButton buildPassWord(cubit) {
    bool isPressed = false;
    return IconButton(
        onPressed: () {
          cubit.isPressedPassWord();
        },
        icon: cubit.canSeepassword
            ? Icon(
                Icons.visibility,
                color: MyColors.myPurble,
              )
            : Icon(
                Icons.visibility_off,
                color: MyColors.myPurble,
              ));
  }

  IconButton buildConfirm(cubit) {
    bool isPressed = false;
    return IconButton(
        onPressed: () {
          cubit.isPressedConfirm();
        },
        icon: cubit.canSeeConfirm
            ? Icon(
                Icons.visibility,
                color: MyColors.myPurble,
              )
            : Icon(
                Icons.visibility_off,
                color: MyColors.myPurble,
              ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChangePasswordCubit, ChangePasswordStates>(
        listener: (context, state) {
      if (state is ChangePasswordInitial) {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return LoadingDialog();
          },
        );
      } else if (state is ChangePasswordSuccess) {
        Navigator.pop(context);
        Navigator.pushNamed(context, 'profile');
      }
    }, builder: (context, state) {
      final cubit = ChangePasswordCubit.get(context);
      return Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.password.tr(),
              style: TextStyle(color: Colors.white)),
          backgroundColor: MyColors.myPurble,
          actions: [
            IconButton(
                onPressed: () {
                  //Navigator.of(context).pop();
                  cubit.cancleChanging(passwordController,
                      newPasswordController, confirmController);
                },
                icon: Icon(
                  Icons.clear,
                  color: Colors.white,
                )),
          ],
        ),
        body: Form(
          key: _keyForm,
          child: Container(
            padding: EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 7),
                  buildTextField(cubit, 1, buildPassWord(cubit)),
                  SizedBox(height: 7),
                  buildTextField(cubit, 2, buildNewPassWord(cubit)),
                  SizedBox(height: 7),
                  buildTextField(cubit, 3, buildConfirm(cubit)),
                  SizedBox(height: 9),
                  MyButton(
                    child: Text(LocaleKeys.ok.tr(),
                        style: TextStyle(color: Colors.white)),
                    context: context,
                    fun: () {
                      // await context.setLocale(const Locale('en'));
                      if (_keyForm.currentState!.validate()) {
                        setState(() {
                          valid = true;
                        });
                      } else {
                        setState(() {
                          valid = false;
                        });
                      }
                      valid
                          ? cubit.changeApi(
                              oldPassword: passwordController.value.text,
                              newPassword: newPasswordController.value.text,
                              confirm: confirmController.value.text)
                          : null;
                    },
                    width: 300,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
