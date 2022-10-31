// import 'package:admin/consts/constant.dart';
// import 'package:admin/consts/myColors.dart';
// import 'package:admin/widget/MyButton.dart';
// import 'package:admin/widget/inputCard.dart';
// import 'package:admin/widget/longWavyContainer.dart';
// import 'package:admin/widget/shortWaveContainer.dart';
// import 'package:flutter/material.dart';

// class Test extends StatelessWidget {
//   Test({Key? key}) : super(key: key);
//   TextEditingController Controller = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     screenSize = MediaQuery.of(context).size;
//     screenHeight = screenSize.height;
//     screenWidth = screenSize.width;

//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: Scaffold(
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               Container(
//                 height: screenHeight * 0.25,
//                 child: ShortWaveContainer(),
//               ),
//               Text(
//                 "Log In",
//                 style: TextStyle(fontSize: 28),
//                 textAlign: TextAlign.left,
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(40.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     SizedBox(
//                       height: screenWidth * 0.1,
//                     ),
//                     Text(
//                       "Email",
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: MyColors.myGrey,
//                       ),
//                     ),
//                     InputCard(
//                       controller: Controller,
//                       name: 'Email',
//                       vlaidate: () {},
//                       width: screenWidth * 0.9,
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Text(
//                       "Password",
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: MyColors.myGrey,
//                       ),
//                     ),
//                     InputCard(
//                       controller: Controller,
//                       name: 'Email',
//                       vlaidate: () {},
//                       width: screenWidth * 0.9,
//                     ),
//                     Text(
//                       "Forget your password",
//                       style: TextStyle(
//                         decoration: TextDecoration.underline,
//                         fontSize: 14,
//                         color: MyColors.myGrey,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     MyButton(
//                         child: Text(
//                           "Log in",
//                           style: TextStyle(color: MyColors.myWhite),
//                         ),
//                         fun: () {},
//                         context: context),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Text(
//                       "Dont have an account? Sign Up",
//                       style: TextStyle(
//                         decoration: TextDecoration.underline,
//                         fontSize: 14,
//                         color: MyColors.myGrey,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
