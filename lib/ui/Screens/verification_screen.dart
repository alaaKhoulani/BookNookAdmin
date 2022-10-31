import 'package:book_nook_admin/business_logic/cubit/verify/cubit/verify_cubit.dart';
import 'package:book_nook_admin/consts/constant.dart';
import 'package:book_nook_admin/consts/myColors.dart';
import 'package:book_nook_admin/services/storage/store.dart';
import 'package:book_nook_admin/ui/widget/MyButton.dart';
import 'package:book_nook_admin/ui/widget/loaading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<VerifyCubit, VerifyState>(
      listener: (context, state) async {
        if (state is VerifySubmitting) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return LoadingDialog();
            },
          );
        } else if (state is VerifyUnComplete) {
          Navigator.pop(context);
          return await _showMyDialog(context);
        } else if (state is VerifySuccess) {
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, 'adminInformation');
        } else if (state is VerifyFailure) {
          Navigator.pop(context);
          _showMyDialog(context);
        }
        else{
          return await _showMyDialog(context);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Container(
              padding: EdgeInsets.all(50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Check your email and verify account to continue your regiter",
                    style: p1.copyWith(
                        fontWeight: FontWeight.bold, wordSpacing: 2),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  MyButton(
                      child: Text(
                        "Continue",
                        style: buttonfont.copyWith(color: MyColors.myWhite),
                      ),
                      fun: () async {
                        BlocProvider.of<VerifyCubit>(context)
                            .isVerify(token: Store.token!);
                      },
                      context: context)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Failer'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                // Text('This is a demo alert dialog.'),
                Text('You should check your email and verify it to continue..'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
