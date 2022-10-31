import 'package:book_nook_admin/consts/myColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/../consts/constant.dart';

class InputCard extends StatelessWidget {
  InputCard(
      {required this.name,
      required this.controller,
      required this.vlaidate,
      this.width = double.infinity,
      this.initValue = '',
      Key? key})
      : super(key: key);

  final String name;
  final TextEditingController controller;
  final FormFieldValidator<String> vlaidate;
  double width;
  // String init = '';
  final String initValue;
  final FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return inputCard();
  }

  Widget inputCard() {
    if (initValue != '') controller.text = initValue;
    return Container(
      // width: width,
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      decoration: BoxDecoration(
        // color: MyColors().myPink,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      //height: 120,
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          inputForm(),
        ],
      ),
    );
  }

  Widget inputForm() {
    String errorText = '';
    return TextFormField(
      // focusNode: focusNode,
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,

      decoration: InputDecoration(
        hintText: name,
        hintStyle: p2.copyWith(color: MyColors.myBlack),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: MyColors.myBlack),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyColors.myBlack),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              width: 1,
              color: Colors.red,
            )),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            width: 1,
            color: Colors.red,
          ),
        ),

        /*
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          style: BorderStyle.solid,
          color: Colors.red,
        )),
         */
        //errorMaxLines: 1,
        //errorText: errorText
      ),
      cursorWidth: 1.0,
      cursorColor: MyColors.myBlack,
      validator: (value) => vlaidate(value ?? ""),

      obscuringCharacter: '*', // '●',
      obscureText: name == 'Password' || name == 'Confirm Password',
      // onFieldSubmitted: vlaidate(controller.text).call(),
    );
  }
}
