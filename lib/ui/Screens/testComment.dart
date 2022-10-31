// import 'dart:developer';
// import 'package:book_nook_admin/business_logic/cubit/comment/comment_cubit.dart';
// import 'package:book_nook_admin/business_logic/cubit/details/details_cubit.dart';
// import 'package:book_nook_admin/consts/constant.dart';
// import 'package:book_nook_admin/consts/myColors.dart';
// import 'package:book_nook_admin/data/models/Book.dart';
// import 'package:book_nook_admin/data/models/comment.dart';
// import 'package:book_nook_admin/services/storage/store.dart';
// import 'package:book_nook_admin/ui/widget/MyButton.dart';
// import 'package:book_nook_admin/ui/widget/loaading_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:like_button/like_button.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:shimmer/shimmer.dart';

// class Detailes extends StatefulWidget {
//   Detailes({Key? key, required this.book}) : super(key: key);
//   BookInfo book;
//   @override
//   State<Detailes> createState() => _detalesState();
// }

// class _detalesState extends State<Detailes> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     BlocProvider.of<CommentCubit>(context).getBookComment(id: widget.book.id!);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // leading: TextButton(
//         //   onPressed: (){},
//         //   child: Text("Library",style: buttonfont.copyWith(color: MyColors.myBlack),)),
//         centerTitle: true,
//         elevation: 0,
//         actions: [
//           TextButton(
//               onPressed: () {},
//               child: Text(
//                 "library",
//                 style:
//                     buttonfont.copyWith(color: MyColors.myPurble, fontSize: 20),
//               )),
//           // IconButton(
//           //     onPressed: () {},
//           //     icon: Icon(
//           //       Icons.maps_home_work_outlined,
//           //       color: Colors.black54,
//           //     )),
//           IconButton(
//             icon: Icon(
//               Icons.share_rounded,
//               color: MyColors.myPurble,
//             ),
//             onPressed: () async {
//               await Share.share(
//                   'http://play.google.com/stor/apps/details?id-com.instructivetech.testapp');
//             },
//           )
//         ],
//         // title: Text("Detail", style: h2.copyWith(color: MyColors.myBlack)),
//         backgroundColor: MyColors.myWhite,
//       ),
//       body:
//           BlocConsumer<CommentCubit, CommentState>(listener: (context, state) {
//         if (state is CommentPostSubmetting) {
//           showDialog(
//             barrierDismissible: false,
//             context: context,
//             builder: (context) {
//               return LoadingDialog();
//             },
//           );
//         } else if (state is DetailsSuccess) {
//           // Navigator.pop(context);
//           // widget.book = state.book;
//           // Navigator.pushReplacementNamed(context, 'addAddress');
//         } else if (state is DetailsFailure) {
//           Navigator.pop(context);
//           ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text(("${state.exception}" + '.'))));
//         }
//       }, builder: (context, state) {
//         return ListView(
//             shrinkWrap: true,
//             physics: ClampingScrollPhysics(),
//             children: [
//               Container(
//                   margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: SizedBox.fromSize(
//                       // size: const Size.fromRadius(100),
//                       child: widget.book.image != null ||
//                               widget.book.image!.isNotEmpty
//                           ? FadeInImage.assetNetwork(
//                               width: 100,
//                               height: 300,
//                               fit: BoxFit.contain,
//                               image: ("${Store.baseURL}/${widget.book.image!}"),
//                               // fit: BoxFit.cover,
//                               placeholder: "assets/images/loading.gif",
//                             )
//                           : Image(image: AssetImage("assets/images/book1.png")),
//                     ),
//                   )),

//               Center(
//                 child: Text(
//                   "${widget.book.name}",
//                   textAlign: TextAlign.left,
//                   style: TextStyle(
//                       fontSize: 15,
//                       fontWeight: FontWeight.bold,
//                       color: MyColors.myBlack),
//                 ),
//               ),
//               Container(
//                 height: 30,
//                 width: 50,
//                 margin: EdgeInsets.only(top: 10, left: 120),
//                 child: RatingBar.builder(
//                   initialRating: 3,
//                   minRating: 1,
//                   direction: Axis.horizontal,
//                   itemCount: 5,
//                   itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
//                   itemBuilder: (context, _) => Icon(
//                     Icons.star,
//                     color: Colors.amber,
//                   ),
//                   itemSize: 20,
//                   onRatingUpdate: (rating) {
//                     print(rating);
//                   },
//                 ),
//               ),
//               Center(
//                   // margin: EdgeInsets.only(left: 140),
//                   // height: 20,
//                   child: Text(
//                 "num of pages : ${widget.book.numOfPage}",
//                 style: TextStyle(
//                     fontSize: 12,
//                     fontWeight: FontWeight.normal,
//                     color: MyColors.myBlack),
//               )),
//               SizedBox(
//                 height: 20,
//               ),
//               Container(
//                 child: GridView(
//                     // padding: EdgeInsets.zero,
//                     padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
//                     physics: NeverScrollableScrollPhysics(),
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 3,
//                         mainAxisSpacing: 0,
//                         crossAxisSpacing: 10,
//                         childAspectRatio: 0.8),
//                     scrollDirection: Axis.vertical,
//                     shrinkWrap: true,
//                     children: [
//                       MyGridTileIcon(
//                           child: Text(
//                             "Comment",
//                             style: p2.copyWith(
//                                 color: MyColors.myBlack, fontSize: 13),
//                             textAlign: TextAlign.center,
//                           ),
//                           icon: Icon(
//                             Icons.comment,
//                             color: MyColors.myPurble,
//                             size: 35,
//                           ),
//                           function: ()  =>  (context) async {
//                                 await Navigator.pushNamed(
//                                     context, "comment",
//                                     arguments: widget.book.id);
//                               }

//                           // Navigator.pushNamed(context, "comment",
//                           // arguments: widget.book),
//                           ),
//                       MyGridTileIcon(
//                         child: Text(
//                           "Quotes",
//                           style: p2.copyWith(
//                               color: MyColors.myBlack, fontSize: 13),
//                           textAlign: TextAlign.center,
//                         ),
//                         icon: Icon(
//                           Icons.format_quote_sharp,
//                           color: MyColors.myPurble,
//                           size: 35,
//                         ),
//                         function: () {
//                           Navigator.pushNamed(context, "allQuotes",
//                               arguments: widget.book.id);
//                         },
//                       ),
//                       MySave(
//                         child: Text(
//                           "Save",
//                           style: p2.copyWith(
//                               color: MyColors.myBlack, fontSize: 13),
//                           textAlign: TextAlign.center,
//                         ),
//                         // icon: ,
//                         icon: Icons.bookmark_rounded,

//                         function: () {},
//                       ),
//                     ]),
//               ),
//               Container(
//                   child: GridView(
//                 // padding: EdgeInsets.zero,
//                 padding: EdgeInsets.fromLTRB(20, 0, 20, 5),
//                 physics: NeverScrollableScrollPhysics(),
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 4,
//                     mainAxisSpacing: 0,
//                     crossAxisSpacing: 10,
//                     childAspectRatio: 0.7),
//                 scrollDirection: Axis.vertical,
//                 shrinkWrap: true,
//                 children: [
//                   myGridTile(
//                     child: Text(
//                       "Purchasing price",
//                       style: p2.copyWith(color: MyColors.myBlack, fontSize: 13),
//                       textAlign: TextAlign.center,
//                     ),
//                     text: Text(
//                       "${widget.book.purchasingPrice}",
//                       style: p2.copyWith(
//                           color: MyColors.myPurble,
//                           fontWeight: FontWeight.bold),
//                     ),
//                     function: () {},
//                   ),
//                   myGridTile(
//                     child: Text(
//                       "Selling price",
//                       style: p2.copyWith(color: MyColors.myBlack, fontSize: 13),
//                       textAlign: TextAlign.center,
//                     ),
//                     text: Text(
//                       "${widget.book.sellingPrice}",
//                       style: p2.copyWith(
//                           color: MyColors.myPurble,
//                           fontWeight: FontWeight.bold),
//                     ),
//                     function: () {},
//                   ),
//                   myGridTile(
//                     child: Text(
//                       "State",
//                       style: p2.copyWith(color: MyColors.myBlack, fontSize: 13),
//                       textAlign: TextAlign.center,
//                     ),
//                     text: Text(
//                       "${widget.book.state}",
//                       style: p2.copyWith(
//                           color: MyColors.myPurble,
//                           fontWeight: FontWeight.bold),
//                     ),
//                     function: () {},
//                   ),
//                   myGridTile(
//                     child: Text(
//                       "Quanitiy",
//                       style: p2.copyWith(
//                         color: MyColors.myBlack,
//                         fontSize: 13,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     text: Text(
//                       "${widget.book.quantity}",
//                       style: p2.copyWith(
//                           color: MyColors.myPurble,
//                           fontWeight: FontWeight.bold),
//                     ),
//                     function: () {},
//                   ),
//                 ],
//               )),
//               Container(
//                 margin: EdgeInsets.zero,
//                 padding: EdgeInsets.fromLTRB(20, 40, 20, 5),
//                 child: Text(
//                   "Auothers :",
//                   style: TextStyle(
//                       fontSize: 15,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black38),
//                 ),
//               ),
//               Container(
//                   height: 100,
//                   child: GridView.builder(
//                       padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
//                       shrinkWrap: true,
//                       physics: NeverScrollableScrollPhysics(),
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                               mainAxisSpacing: 5,
//                               crossAxisCount: 3,
//                               childAspectRatio: 3,
//                               crossAxisSpacing: 10),
//                       scrollDirection: Axis.vertical,
//                       itemCount: widget.book.authors!.length,
//                       itemBuilder: (BuildContext ctx, index) {
//                         return Container(
//                           alignment: Alignment.center,
//                           padding: EdgeInsets.all(5),
//                           // margin: EdgeInsets.all(5),
//                           decoration: BoxDecoration(
//                             color: MyColors.myGreen,
//                             // border: Border.all(color: MyColors.myGrey),
//                             borderRadius: BorderRadius.circular(5),
//                           ),
//                           // offset: Offset(0, 0), // changes position of shadow

//                           child: Text(
//                             "${widget.book.authors![index].name}",
//                             style: p2.copyWith(color: Colors.black54),
//                           ),
//                         );
//                       })),
//               Container(
//                 padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
//                 child: Text(
//                   "Categories :",
//                   style: TextStyle(
//                       fontSize: 15,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black38),
//                 ),
//               ),
//               Container(
//                   height: 100,
//                   child: GridView.builder(
//                       padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
//                       shrinkWrap: true,
//                       physics: NeverScrollableScrollPhysics(),
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                               mainAxisSpacing: 5,
//                               crossAxisCount: 3,
//                               childAspectRatio: 3,
//                               crossAxisSpacing: 10),
//                       scrollDirection: Axis.vertical,
//                       itemCount: widget.book.categories!.length,
//                       itemBuilder: (BuildContext ctx, index) {
//                         return Container(
//                           alignment: Alignment.center,
//                           padding: EdgeInsets.all(5),
//                           // margin: EdgeInsets.all(5),
//                           decoration: BoxDecoration(
//                             color: MyColors.myGreen,
//                             // border: Border.all(color: MyColors.myGrey),
//                             borderRadius: BorderRadius.circular(5),
//                           ),
//                           // offset: Offset(0, 0), // changes position of shadow

//                           child: Text(
//                             "${widget.book.categories![index].name}",
//                             style: p2.copyWith(color: Colors.black54),
//                           ),
//                         );
//                       })),

//               Container(
//                 margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
//                 child: Text(
//                   "Summary :",
//                   style: TextStyle(
//                       fontSize: 15,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black38),
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
//                 margin: EdgeInsets.only(left: 10),
//                 child: Text(widget.book.summary!,
//                     style: p2.copyWith(
//                       color: MyColors.myBlack,
//                     )
//                     // 'he secret power of the universe how to use the law of attraction fof manifestation '
//                     // "Have you ever noticed that this world was made to complete perfection ?There is areason and use for every single"
//                     // "thing that you can see,taste,toush,hear and feel on this planet"
//                     // ".Everything works and fits together in perfect harmony ."
//                     // "From the functions and shaoes of our bodies Are you eager to learn about the Law of"
//                     // " Attraction? In this the Law of Attraction summary and book review, we will go into the"
//                     // " book’s basic lessons"
//                     ),
//               ),
//               SizedBox(
//                 height: 60,
//               )
//               // Container(
//               //   margin: EdgeInsets.fromLTRB(40, 10, 40, 10),
//               //   child: MyButton(
//               //       child: Text(
//               //         "Add to card",
//               //         style: buttonfont.copyWith(color: MyColors.myWhite),
//               //       ),
//               //       fun: () {},
//               //       context: context),
//               // ),
//             ]);
//       }),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       floatingActionButton: FloatingActionButton.extended(
//         backgroundColor: MyColors.myPurble,
//         onPressed: () {},
//         label: Text(
//           "Add to card",
//           style: buttonfont.copyWith(color: MyColors.myWhite),
//         ),
//       ),
//     );
//   }

//   Widget MySave(
//       {required Widget child,
//       required VoidCallback function,
//       required IconData icon}) {
//     return GridTile(
//         child: Column(
//       children: [
//         Container(
//           height: 60,
//           // padding: EdgeInsets.all(10),
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.3),
//                 spreadRadius: 1,
//                 // blurRadius: 10,
//                 // offset: Offset(0, 0), // changes position of shadow
//               ),
//             ],
//             color: MyColors.myGrey,
//             borderRadius: BorderRadius.all(Radius.circular(20)),
//           ),
//           child: LikeButton(
//             likeBuilder: (bool isLiked) {
//               return Icon(
//                 icon,
//                 color: isLiked ? MyColors.myPurble : Colors.grey,
//                 size: 30,
//               );
//             },
//           ),
//         ),
//         SizedBox(
//           height: 15,
//         ),
//         child
//       ],
//     ));
//   }

//   Widget MyGridTileIcon(
//       {required Widget child,
//       required VoidCallback function,
//       required Icon icon}) {
//     return GestureDetector(
//       onTap: function,
//       child: GridTile(
//         child: Column(
//           children: [
//             Container(
//               height: 60,
//               // padding: EdgeInsets.all(10),
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.3),
//                     spreadRadius: 1,
//                   ),
//                 ],
//                 color: MyColors.myGrey,
//                 borderRadius: BorderRadius.all(Radius.circular(20)),
//               ),
//               child: icon,
//             ),
//             SizedBox(
//               height: 15,
//             ),
//             child
//           ],
//         ),

//         //  footer: Container(
//         //   height: 30,
//         //   decoration: BoxDecoration(
//         //     color: MyColors.myBlack.withOpacity(0.5),
//         //     borderRadius: BorderRadius.only(
//         //       bottomLeft:Radius.circular(20),
//         //       bottomRight: Radius.circular(20)
//         //     )
//         //   ),
//         //   child: child,
//         //   ),
//       ),
//     );
//   }

//   Widget myGridTile(
//       {required Widget child,
//       required VoidCallback function,
//       required Text text}) {
//     return GestureDetector(
//       onTap: function,
//       child: GridTile(
//         child: Column(
//           children: [
//             Container(
//               height: 60,
//               // padding: EdgeInsets.all(10),
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.3),
//                     spreadRadius: 1,
//                     // blurRadius: 10,
//                     // offset: Offset(0, 0), // changes position of shadow
//                   ),
//                 ],
//                 color: MyColors.myGrey,
//                 borderRadius: BorderRadius.all(Radius.circular(20)),
//               ),
//               child: text,
//             ),
//             SizedBox(
//               height: 15,
//             ),
//             child
//           ],
//         ),
//       ),
//     );
//   }

//   // TextEditingController commentController = TextEditingController();
//   // void show_coments_sheet(BuildContext context) {
//   //   // BlocProvider.of<CommentCubit>(context).getBookComment(id: widget.book.id!);

//   //   List<Comment> comments = [];
//   //   // WidgetsBinding.instance.addPostFrameCallback(
//   //   //   (timeStamp) {
//   //   Future.delayed(
//   //     Duration.zero,
//   //     () {
//   //       showModalBottomSheet(
//   //           enableDrag: true,
//   //           isDismissible: true,
//   //           backgroundColor: MyColors.myGrey,
//   //           shape: RoundedRectangleBorder(
//   //               borderRadius: BorderRadius.only(
//   //                   topLeft: Radius.circular(20),
//   //                   topRight: Radius.circular(20))),
//   //           isScrollControlled: true,
//   //           context: context,
//   //           builder: (context) {
//   //             // var _cubit = BlocProvider.of<CommentCubit>(context);
//   //             // _cubit.getBookComment(id: widget.book.id!);
//   //             return BlocConsumer<CommentCubit, CommentState>(
//   //               listener: (context, state) {
//   //                 if (state is CommentPostSubmetting) {
//   //                   showDialog(
//   //                     barrierDismissible: false,
//   //                     context: context,
//   //                     builder: (context) {
//   //                       return LoadingDialog();
//   //                     },
//   //                   );
//   //                 } else if (state is CommentPostSuccess) {
//   //                   Navigator.pop(context);
//   //                 } else if (state is CommentFailure) {
//   //                   Navigator.pop(context);
//   //                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//   //                       content: Text((state.exception.toString() + '.'))));
//   //                 }
//   //               },
//   //               builder: (context, state) {
//   //                 if (state is CommentPostSubmetting) {
//   //                   return _buildLoaddingListWidget();
//   //                 } else if (state is CommentGetSuccess) {
//   //                   comments = state.comment;
//   //                   return _buildSuccessfullWidget(comments);
//   //                 } else {
//   //                   _showMyDialog(context);
//   //                   return Container();
//   //                 }
//   //               },
//   //             );
//   //           });
//   //     },
//   //   );
//   // }

//   // // TextEditingController commentController = TextEditingController();
//   // Widget _buildSuccessfullWidget(List<Comment> comments) {
//   //   return SafeArea(
//   //     child: SizedBox(
//   //       height: 800,
//   //       child: SingleChildScrollView(
//   //         // physics: NeverScrollableScrollPhysics(),
//   //         child: Column(
//   //           children: [
//   //             // Container(
//   //             //   height: 5,
//   //             // ),
//   //             Container(
//   //               height: 50,
//   //               decoration: BoxDecoration(
//   //                   color: MyColors.myGreen,
//   //                   borderRadius: BorderRadius.circular(40.0)),
//   //               child: ListTile(
//   //                 title: TextField(
//   //                   controller: commentController,
//   //                   decoration: InputDecoration(
//   //                     hintText: 'addcomment',
//   //                     border: InputBorder.none,
//   //                     suffixIcon: IconButton(
//   //                       color: MyColors.myBlack,
//   //                       onPressed: () {
//   //                         if (commentController.value.text.isNotEmpty &&
//   //                             commentController.value.text != null) {
//   //                           BlocProvider.of<CommentCubit>(context).addComment(
//   //                               comment: commentController.value.text,
//   //                               id: widget.book.id!);
//   //                           commentController.clear();
//   //                         }
//   //                       },
//   //                       icon: const Icon(
//   //                         Icons.send,
//   //                         size: 25,
//   //                       ),
//   //                     ),
//   //                   ),
//   //                 ),
//   //               ),
//   //             ),
//   //             Container(
//   //                 child: ListView.builder(
//   //               physics: ClampingScrollPhysics(),
//   //               shrinkWrap: true,
//   //               itemCount: comments.length,
//   //               itemBuilder: (context, index) {
//   //                 return ListTile(
//   //                   leading: Image.asset("assets/images/book-nook.png"),
//   //                   title: comments[index].role_id != 1
//   //                       ? Text(
//   //                           "${comments[index].firstName} ${comments[index].lastName}")
//   //                       : Text("${comments[index].library}"),
//   //                   subtitle: Text("${comments[index].comment}"),
//   //                 );
//   //               },
//   //             ))
//   //           ],
//   //         ),
//   //       ),
//   //     ),
//   //   );
//   // }

//   // Widget _buildLoaddingListWidget() {
//   //   return ListView.builder(
//   //       itemCount: 5,
//   //       itemBuilder: (context, index) {
//   //         return Container(
//   //             padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
//   //             child: Shimmer.fromColors(
//   //                 baseColor: Colors.grey.shade300,
//   //                 highlightColor: Colors.grey.shade100,
//   //                 child: Row(
//   //                   children: [
//   //                     Container(
//   //                       width: 80,
//   //                       height: 90,
//   //                       decoration: BoxDecoration(
//   //                           color: MyColors.myWhite,
//   //                           borderRadius:
//   //                               BorderRadius.all(Radius.circular(20))),
//   //                     ),
//   //                     Expanded(
//   //                       child: ListTile(
//   //                         title: Container(
//   //                           height: 10,
//   //                           width: 30,
//   //                           color: MyColors.myWhite,
//   //                         ),
//   //                         subtitle: Container(
//   //                           height: 10,
//   //                           width: 40,
//   //                           color: MyColors.myWhite,
//   //                         ),
//   //                       ),
//   //                     )
//   //                   ],
//   //                 )));
//   //       });
//   // }

//   // Future<void> _showMyDialog(BuildContext context) async {
//   //   return showDialog<void>(
//   //     context: context,
//   //     barrierDismissible: false, // user must tap button!
//   //     builder: (BuildContext context) {
//   //       return AlertDialog(
//   //         title: const Text('Failer'),
//   //         content: SingleChildScrollView(
//   //           child: ListBody(
//   //             children: const <Widget>[
//   //               // Text('This is a demo alert dialog.'),
//   //               Text('please swap to try again..'),
//   //             ],
//   //           ),
//   //         ),
//   //         actions: <Widget>[
//   //           TextButton(
//   //             child: const Text('Ok'),
//   //             onPressed: () {
//   //               Navigator.of(context).pop();
//   //             },
//   //           ),
//   //         ],
//   //       );
//   //     },
//   //   );
//   // }
// }
