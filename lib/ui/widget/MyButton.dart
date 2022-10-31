import 'package:book_nook_admin/consts/myColors.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  MyButton(
      {Key? key,
      required this.child,
      required this.fun,
      required this.context,
      this.width = 300})
      : super(key: key);
  final Widget child;
  double width;
  final BuildContext context;
  final Function fun;
  @override
  Widget build(BuildContext context) {
    return button();
  }

  Widget button() {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: MyColors.myPurble,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: MaterialButton(
        onPressed:()=> this.fun.call(),
        child: child
      ),
    );
  }
}
