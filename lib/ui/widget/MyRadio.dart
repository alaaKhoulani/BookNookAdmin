// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class MyRadio extends StatefulWidget {
//   late  String blood;
//   MyRadio();

//   @override
//   State<MyRadio> createState() => _MyRadioState();
// }

// class _MyRadioState extends State<MyRadio> {
//   @override
//   Widget build(BuildContext context) {
//     return PopupMenuButton(
//         onSelected: (x) {
//           setState(() {
//           });
//         },
//         child: Container(
//            padding: EdgeInsets.fromLTRB(30.0, 15, 30, 15),
//           width: 100,
//           height: 50,
//           child: Text("city"),
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//               color: Colors.grey[200], //Color(0xFFDCDFE4),
//               borderRadius: BorderRadius.circular(20),
//               border: Border.all(color: Colors.teal, width: 2)),
//         ),
//         itemBuilder: (context) {
//           return [
//             PopupMenuItem(
//               //onTap: () {},
//               child: Text("Damascus"),
//               value: "Damascus",
//             ),
//             PopupMenuItem(
//               //onTap: () {},
//               child: Text("Aleppo"),
//               value: "Aleppo",
//             ),
//             PopupMenuItem(
//               //onTap: () {},
//               child: Text("Homs"),
//               value: "Homs",
//             ),
//             PopupMenuItem(
//               //onTap: () {},
//               child: Text("Hama"),
//               value: "Hama",
//             ),
//             PopupMenuItem(
//               //onTap: () {},
//               child: Text("Daraa"),
//               value: "Daraa",
//             ),
//             PopupMenuItem(
//               //onTap: () {},
//               child: Text("Al-Qunaitra"),
//               value: "Al-Qunaitra",
//             ),
//             PopupMenuItem(
//               //onTap: () {},
//               child: Text("Latakia"),
//               value: "Latakia",
//             ),
//             PopupMenuItem(
//               //onTap: () {},
//               child: Text("Tartos"),
//               value: "Tartos",
//             ),
//             PopupMenuItem(
//               //onTap: () {},
//               child: Text("Edlib"),
//               value: "Edlib",
//             ),
//              PopupMenuItem(
//               //onTap: () {},
//               child: Text("Der-Alzour"),
//               value: "Der-Alzour",
//             ),
//              PopupMenuItem(
//               //onTap: () {},d
//               child: Text("AL-Raqqa"),
//               value: "AL-Raqqa",
//             ),
//              PopupMenuItem(
//               //onTap: () {},
//               child: Text("Souida"),
//               value: "Souida",
//             ),
//              PopupMenuItem(
//               //onTap: () {},
//               child: Text("Al-hasaka"),
//               value: "Al-hasaka",
//             ),
//           ];
//         });
//   }
// }
// /*
// PopupMenuItem(
//                   child:RadioListTile(value: "10", groupValue: tt, onChanged: (x){
//                     setState(() {
//                       tt=x as int?;
//                     });
//                   }) ,
//               ),
//               PopupMenuItem(
//                 child: RadioListTile(
//                     title: Text("A+"),
//                     value: "A+",
//                     activeColor: Colors.teal,
//                     groupValue: s,
//                     onChanged: (x) {
//                       setState(() {
//                         s=x.toString();
//                         //widget.blood=x.toString();
//                       });
//                       print (x.toString());
//                     }
//                 ),
//               ),
//               PopupMenuItem(
//                 child: RadioListTile(
//                     title: Text("A-"),
//                   value: "A-",
//                   groupValue:s,
//                   onChanged: (x) {
//                     setState(() {
//                       s=x.toString();
//                       //widget.blood=x.toString();
//                     });
//                   }
//                 ),
//               ),
//               PopupMenuItem(
//                 child: RadioListTile(
//                     value: "B+",
//                     title: Text("B+"),
//                     groupValue: s,
//                     onChanged: (x) {
//                       setState(() {
//                         s=x.toString();
//                         //widget.blood=x.toString();
//                       });
//                     }
//                   ),
//               ),
//               PopupMenuItem(
//                 child: RadioListTile(
//                 value: "B-",
//                     title: Text("B-"),
//                 groupValue: s,
//                 onChanged: (x) {
//                   setState(() {
//                     s=x.toString();
//                     //widget.blood=x.toString();
//                   });
//                 }),
//               ),
//               PopupMenuItem(
//                 child: RadioListTile(
//                 value: "O+",
//                     title: Text("O+"),
//                 groupValue: s,
//                 onChanged: (x) {
//                   setState(() {
//                     s=x.toString();
//                     //widget.blood=x.toString();
//                   });
//                 }),
//               ),
//               PopupMenuItem(
//                 child: RadioListTile(
//                 value: "O-",
//                     title: Text("O-"),
//                 groupValue: s,
//                 onChanged: (x) {
//                   setState(() {
//                     s=x.toString();
//                     //widget.blood=x.toString();
//                   });
//                 }),
//               ),
//               PopupMenuItem(
//                 child: RadioListTile(
//                 value: "AB+",
//                     title: Text("AB+"),
//                 groupValue:s,
//                 onChanged: (x) {
//                   setState(() {
//                     s=x.toString();
//                     //widget.blood=x.toString();
//                   });
//                 }),
//                 ),
//               PopupMenuItem(
//                 child: RadioListTile(
//                 value: "AB-",
//                     title: Text("AB-"),
//                 groupValue:s ,
//                 onChanged: (x) {
//                   setState(() {
//                     s=x.toString();
//                     //widget.blood=x.toString();
//                   });
//                 }),
//               ),
//             ];
//             },
// ),
// */