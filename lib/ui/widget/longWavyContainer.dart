
import 'package:book_nook_admin/consts/constant.dart';
import 'package:flutter/material.dart';

class LongWaveContainer extends StatelessWidget {
  const LongWaveContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: MyCustomClipper(),
          child: Container(
            //color:Color(0xFFF8BA7C),
            //color:Color(0xFFA0BCC2),
            //color:Color(0xFF92BA92),
            color:Color(0xFF497373),
           // height: 500,
          ),
        ),
        Positioned(
          top: screenHeight*0.5,
          left: screenWidth*0.5,
          child: Image.asset("assets/images/book1.png",width: 50,),
        ),
        Positioned(
          top: screenHeight*0.2,
          left:20,
          child: Image.asset("assets/images/book2.png",width: 200,),
        ),
        Positioned(
          top: 50,
          left: screenWidth*0.7,
          child: Image.asset("assets/images/book2.png",width: 75,),
        ),
        Positioned(
          top: screenHeight*0.2,
          left: screenWidth*0.5,
          child: Image.asset("assets/images/book3.png",width: 150,),
        ),
         Positioned(
          top: 10,
          left: 10,
          child: Image.asset("assets/images/book4.png",width: 150,),
        ),
        Positioned(
          top: screenHeight*0.55,
          left: screenWidth*0.35,
          child: Image.asset("assets/images/book4.png",width: 300,),
        ),
        Positioned(
          top: screenHeight*0.35,
          left: screenWidth*0.45,
          child: Image.asset("assets/images/book5.png",width: 300,),
        ),
        Positioned(
          top: screenHeight*0.35,
          left: -100,
          child: Image.asset("assets/images/book5.png",width: 300,),
        ),
      ],
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path0 = Path();
    path0.moveTo(0, 0);
    path0.lineTo(0, size.height * 0.6940000);
    path0.quadraticBezierTo(size.width * 0.2462667, size.height * 0.6423000,
        size.width * 0.4886333, size.height * 0.7865667);
    path0.quadraticBezierTo(size.width * 0.7136333, size.height * 0.9383333,
        size.width, size.height * 0.9);
    path0.lineTo(size.width, 0);
    path0.lineTo(0, 0);
    path0.close();

    return path0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
