import 'dart:io';
import 'package:book_nook_admin/business_logic/cubit/logOut/log_out_cubit.dart';
import 'package:book_nook_admin/business_logic/cubit/profile/profile_cubit.dart';
import 'package:book_nook_admin/consts/constant.dart';
import 'package:book_nook_admin/consts/myColors.dart';
import 'package:book_nook_admin/data/models/admin.dart';
import 'package:book_nook_admin/services/storage/store.dart';
import 'package:book_nook_admin/ui/widget/Header.dart';
import 'package:book_nook_admin/ui/widget/loaading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:/consts/myColors.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  File? imageFile;
  // late Admin admin;
  @override
  void initState() {
    super.initState();
    // print("init");
    BlocProvider.of<ProfileCubit>(context).getAddress();
  }

  Widget buildMyButton(var size, String text, IconData icon) {
    return GestureDetector(
      child: Container(
          // height: size.height * .07,
          // width: size.width * .8,
          padding: const EdgeInsets.fromLTRB(10, 2, 20, 0),
          margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: MyColors.myGreen, width: 1),
            color: MyColors.myWhite,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: MyColors.myGreen,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .12,
              ),
              Text(
                text,
                style: TextStyle(
                  color: MyColors.myGreen,
                ),
              ),
            ],
          )),
      onTap: () {},
    );
  }

  // Future buildShowDialog() {
  //   return Get.defaultDialog(
  //     title: "Let's",
  //     titleStyle: TextStyle(color: MyColors.myGreen),
  //     radius: 15,
  //     barrierDismissible: false,
  //     middleText: "choose image",
  //     middleTextStyle: TextStyle(color: MyColors.myGreen),
  //     actions: [
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
  //         children: [
  //           IconButton(
  //             icon: Icon(Icons.collections_outlined, color: MyColors.myGreen),
  //             onPressed: () {
  //               pickImage(ImageSource.gallery);
  //             },
  //           ),
  //           IconButton(
  //             icon: Icon(Icons.camera_alt_outlined, color: MyColors.myGreen),
  //             onPressed: () {
  //               pickImage(ImageSource.camera);
  //             },
  //           ),
  //         ],
  //       ),
  //     ],
  //     textConfirm: "Done",
  //     confirmTextColor: MyColors.myWhite,
  //     buttonColor: MyColors.myGreen,
  //     onConfirm: () {
  //       Get.back();
  //     },
  //   );
  // }
  // var size, height, width;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // height = size.height;
    // width = size.width;
    screenSize = MediaQuery.of(context).size;
    screenHeight = screenSize.height;
    screenWidth = screenSize.width;
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileSubmitting) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return LoadingDialog();
            },
          );
        } else if (state is ProfileSuccess) {
          // admin = state.admin;
        } else if (state is ProfileFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(("${state.exception.toString()}" + '.'))));
        }
      },
      builder: (context, state) {
        var _cubit = BlocProvider.of<ProfileCubit>(context);
        return Scaffold(
            body: SafeArea(
          child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Stack(
                  children: [
                    Container(
                      height: 265,
                      color: MyColors.myGrey,
                    ),
                    // Header(height: screenHeight, width: screenWidth, title: ""),
                    Header(height: screenHeight, width: screenWidth, title: ""),
                    Positioned(
                      right: 170,
                      bottom: 45,
                      child: Text("${Store.myAdmin.libraryName}",
                          style: h2.copyWith(color: MyColors.myPurble)),
                    ),
                    Positioned(
                      right: 10,
                      bottom: 5,
                      child: CircleAvatar(
                        // width: 100,
                        // decoration: BoxDecoration(
                        //     color: MyColors.myPurble,
                        //     borderRadius:
                        //         BorderRadius.all(Radius.circular(100))),
                        backgroundImage: Store.myAdmin.image != null
                            ? NetworkImage(
                                "${Store.baseURL}/${Store.myAdmin.image!}")
                            // ? FadeInImage.assetNetwork(

                            : null,
                        child: Store.myAdmin.image != null
                            ? null
                            : Text(Store.myAdmin.libraryName![0] +
                                Store.myAdmin.libraryName![1],
                                style: h1.copyWith(color: MyColors.myWhite),
                                ),
                        backgroundColor: MyColors.myPurble,
                        radius: 60,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: IconButton(
                          onPressed: () {
                            BlocProvider.of<ProfileCubit>(context).logOut();
                          },
                          icon: Icon(
                            Icons.logout_rounded,
                            color: MyColors.myPurble,
                          )),
                    )
                    // Positioned(
                    //   right: 25,
                    //   bottom: 20,
                    //   child: Container(
                    //     margin: EdgeInsets.only(left: 120),
                    //     decoration: BoxDecoration(
                    //       color: MyColors.myWhite,
                    //       borderRadius: BorderRadius.circular(50),
                    //     ),
                    //     child: IconButton(
                    //         icon: Icon(
                    //           Icons.edit,
                    //           color: MyColors.myPurble,
                    //           size: 20,
                    //         ),
                    //         onPressed: () {
                    //           // buildShowDialog();
                    //         }),
                    //   ),
                    // ),
                  ],
                ),

                SizedBox(
                  height: 30,
                ),
                Container(
                  // margin: EdgeInsets.fromLTRB(10, 20, 30, 20),
                  height: 400,
                  child: GridView(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    physics: AlwaysScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 30,
                        childAspectRatio: 0.7),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: [
                      // MyGridTile(
                      //   child: Text(
                      //     "Saved",
                      //     style: p2.copyWith(color: MyColors.myBlack),
                      //     textAlign: TextAlign.center,
                      //   ),
                      //   icon: Icon(
                      //     Icons.favorite_rounded,
                      //     color: MyColors.myPurble,
                      //     size: 35,
                      //   ),
                      //   function: () => Navigator.pushNamed(context, "allBook")
                      //   // Navigator.pushNamed(context, "allBook");
                      //   ,
                      // ),
                      // MyGridTile(
                      //   child: Text(
                      //     "bought",
                      //     style: p2.copyWith(color: MyColors.myBlack),
                      //     textAlign: TextAlign.center,
                      //   ),
                      //   icon: Icon(
                      //     Icons.done_outline_rounded,
                      //     color: MyColors.myPurble,
                      //     size: 35,
                      //   ),
                      //   function: () {},
                      // ),
                      // MyGridTile(
                      //   child: Text(
                      //     "Borrowed",
                      //     style: p2.copyWith(color: MyColors.myBlack),
                      //     textAlign: TextAlign.center,
                      //   ),
                      //   icon: Icon(
                      //     Icons.menu_book_rounded,
                      //     color: MyColors.myPurble,
                      //     size: 35,
                      //   ),
                      //   function: () {},
                      // ),
                      // MyGridTile(
                      //   child: Text(
                      //     "My Online",
                      //     style: p2.copyWith(color: MyColors.myBlack),
                      //     textAlign: TextAlign.center,
                      //   ),
                      //   icon: Icon(
                      //     Icons.book_outlined,
                      //     color: MyColors.myPurble,
                      //     size: 35,
                      //   ),
                      //   function: () => Navigator.pushNamed(context, "allBook"),
                      // ),
                      MyGridTile(
                        child: Text(
                          "Settings",
                          style: p2.copyWith(color: MyColors.myBlack),
                          textAlign: TextAlign.center,
                        ),
                        icon: Icon(
                          Icons.settings,
                          color: MyColors.myPurble,
                          size: 35,
                        ),
                        function: () {
                          Navigator.pushNamed(context, "setting");
                        },
                      ),
                      MyGridTile(
                        child: Text(
                          "Address",
                          style: p2.copyWith(color: MyColors.myBlack),
                          textAlign: TextAlign.center,
                        ),
                        icon: Icon(
                          Icons.location_on_rounded,
                          color: MyColors.myPurble,
                          size: 35,
                        ),
                        function: () {
                          Navigator.pushNamed(context, "editAdress",
                              arguments: Store.address[0]);
                        },
                      ),
                    ],
                  ),
                ),
                // MyListTile(
                //   leadingIcon: Icon(Icons.favorite_rounded),
                //   lable: "Saved Books",
                //   trailingIcon: Icon(Icons.arrow_forward_ios_rounded),
                //   function: () {},
                // ),
                // MyListTile(
                //   leadingIcon: Icon(Icons.done_outline_rounded),
                //   lable: "My Sold  Book",
                //   trailingIcon: Icon(Icons.arrow_forward_ios_rounded),
                //   function: () {},
                // ),
                // MyListTile(
                //   leadingIcon: Icon(Icons.done_outline_rounded),
                //   lable: "My Borrowed  Book",
                //   trailingIcon: Icon(Icons.menu_book_rounded),
                //   function: () {},
                // ),
                // MyListTile(
                //   leadingIcon: Icon(Icons.done_outline_rounded),
                //   lable: "My Current Online Book",
                //   trailingIcon: Icon(Icons.book_outlined),
                //   function: () {},
                // ),
              ]),
        ));
      },
    );
  }

  Widget MyGridTile(
      {required Widget child,
      required VoidCallback function,
      required Icon icon}) {
    return GestureDetector(
      onTap: function,
      child: GridTile(
        child: Column(
          children: [
            Container(
              height: 90,
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 10,
                    // offset: Offset(0, 0), // changes position of shadow
                  ),
                ],
                color: MyColors.myGrey,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: icon,
            ),
            SizedBox(
              height: 15,
            ),
            child
          ],
        ),
        //  footer: Container(
        //   height: 30,
        //   decoration: BoxDecoration(
        //     color: MyColors.myBlack.withOpacity(0.5),
        //     borderRadius: BorderRadius.only(
        //       bottomLeft:Radius.circular(20),
        //       bottomRight: Radius.circular(20)
        //     )
        //   ),
        //   child: child,
        //   ),
      ),
    );
  }

  Widget MyListTile(
      {required Icon leadingIcon,
      required String lable,
      required Icon trailingIcon,
      required Function function}) {
    return ListTile(
      iconColor: MyColors.myPurble,
      leading: leadingIcon,
      title: Text(lable, style: p1.copyWith(color: MyColors.myBlack)),
      trailing: IconButton(
        icon: trailingIcon,
        onPressed: function.call(),
      ),
    );
  }
}
