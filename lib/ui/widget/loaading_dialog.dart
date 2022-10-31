import 'package:book_nook_admin/consts/myColors.dart';
import 'package:flutter/material.dart';


class LoadingDialog extends StatelessWidget {
  const LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: Color(0xffa085aa),
      ),
    );
  }
}