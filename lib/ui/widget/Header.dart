
import 'package:book_nook_admin/consts/constant.dart';
import 'package:flutter/material.dart';

import '/../consts/myColors.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.height,
    required this.width,
    required this.title
  }) : super(key: key);

  final height;
  final width;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 60,
        ),
        Container(
            //margin: EdgeInsets.only(top: 50),
            height: screenHeight * 0.25,
            child: Image(image: AssetImage("assets/images/book-nook.png"))

            //ShortWaveContainer(),
            ),
        Positioned(
          top: height * 0.18,
          right: width * 0.2,
          child: Text(
            title,
            style: h1.copyWith(color: MyColors.myPurble),
          ),
        ),
      ],
    );
  }
}
