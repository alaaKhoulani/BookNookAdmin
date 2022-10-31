// import 'package:admin/consts/myColors.dart';
// import 'package:flutter/material.dart';

// import 'package:admin/consts/constant.dart';
// import 'package:flutter/material.dart';

// class ShortWaveContainer extends StatelessWidget {
//   const ShortWaveContainer({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         ClipPath(
//           clipper: MyCustomClipper(),
//           child: Container(
//             color: MyColors.myPurble,
//            // height: 500,
//           ),
//         ),
//         Positioned(
//           top: 20,
//           left: 20,
//           child: Image.asset("assets/images/book1.png",width: 50,),
//         ),
//         Positioned(
//           top: 20,
//           left: screenWidth*0.3,
//           child: Image.asset("assets/images/book2.png",width: 50,),
//         ),
//         Positioned(
//           top: 20,
//           left: screenWidth*0.5,
//           child: Image.asset("assets/images/book2.png",width: 100,),
//         ),
//         Positioned(
//           top: screenHeight*0.14,
//           left: screenWidth*0.8,
//           child: Image.asset("assets/images/book4.png",width: 70,),
//         ),
        
//       ],
//     );
//   }
// }

// class MyCustomClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//      Path path0 = Path();
//     path0.moveTo(0,0);
//     path0.lineTo(0,size.height*0.5333333);
//     path0.quadraticBezierTo(size.width*0.2809333,size.height*0.2425455,size.width*0.5319667,size.height*0.6360000);
//     path0.quadraticBezierTo(size.width*0.7503000,size.height,size.width,size.height*0.9433333);
//     path0.lineTo(size.width,0);
//     path0.lineTo(0,0);
//     path0.close();

//     return path0;
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
//     return false;
//   }
// }
