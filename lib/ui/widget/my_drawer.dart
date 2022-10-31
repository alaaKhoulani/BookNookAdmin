import 'package:book_nook_admin/business_logic/cubit/profile/profile_cubit.dart';
import 'package:book_nook_admin/data/repository/admin_repository.dart';
import 'package:book_nook_admin/data/web_services/admin_web_services.dart';
import 'package:book_nook_admin/services/storage/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/../consts/constant.dart';
import '/../consts/myColors.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Container(
        color: MyColors.myWhite,
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisSize: MainAxisSize.max,

          children: [
            Container(
              color: MyColors.myPurble,
              padding: EdgeInsets.fromLTRB(10, 60, 10, 20),
              child: Column(
                children: [
                  Store.myAdmin.image == null
                      ? CircleAvatar(
                          radius: 60,
                          backgroundColor: MyColors.myPurble,
                          backgroundImage:
                              AssetImage("assets/images/library.jpg"),
                        )
                      : CircleAvatar(
                          radius: 60,
                          backgroundColor: MyColors.myPurble,
                          backgroundImage: NetworkImage("${Store.baseURL}/${Store.myAdmin.image}"),
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${Store.myAdmin.libraryName}",
                    style: h2.copyWith(color: MyColors.myWhite),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
            ListTile(
              onTap: () async {
                Store.myAdmin =
                    await AdminRepository(AdminWebServices()).profile();
                // AdminRepository(AdminrWebServices()).profle();
                Navigator.pushNamed(context, "profile");
              },
              title: Text("My Account",
                  style: p2.copyWith(
                    color: MyColors.myBlack,
                  )),
              leading: Icon(
                Icons.home_work,
                color: MyColors.myPurble2,
              ),
            ),
            ListTile(
              onTap: () {
                
                Navigator.pushNamed(context, 'myOffersScreen',
                    arguments: Store.myAdmin.id);
              },
              // co: MyColors.myBlack,
              // selectedColor: MyColors.myGreen,
              title: Text("My Offers",
                  style: p2.copyWith(
                    color: MyColors.myBlack,
                  )),
              leading: Icon(
                Icons.home_work,
                color: MyColors.myPurble2,
              ),
            ),
            // ListTile(
            //   // co: MyColors.myBlack,
            //   // selectedColor: MyColors.myGreen,
            //   title: Text("Earning",
            //       style: p2.copyWith(
            //         color: MyColors.myBlack,
            //       )),
            //   leading: Icon(
            //     Icons.attach_money_rounded,
            //     color: MyColors.myPurble2,
            //   ),
            // ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, 'myOrder');
              },
              title: Text("Orders",
                  style: p2.copyWith(
                    color: MyColors.myBlack,
                  )),
              leading: Icon(
                Icons.done_outline_rounded,
                color: MyColors.myPurble2,
              ),
            ),
            ListTile(
              // co: MyColors.myBlack,
              // selectedColor: MyColors.myGreen,
              title: Text("Borrowed Books",
                  style: p2.copyWith(
                    color: MyColors.myBlack,
                  )),
              leading: Icon(
                Icons.menu_book_rounded,
                color: MyColors.myPurble2,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, "graphScreen");
              },
              // co: MyColors.myBlack,
              // selectedColor: MyColors.myGreen,
              title: Text("statistics",
                  style: p2.copyWith(
                    color: MyColors.myBlack,
                  )),
              leading: Icon(
                Icons.bar_chart_rounded,
                color: MyColors.myPurble2,
              ),
            ),
            ListTile(
              onTap: () async {
                await Navigator.pushNamed(context, 'myOrder');
              },
              title: Text("My Orders",
                  style: p2.copyWith(
                    color: MyColors.myBlack,
                  )),
              leading: Icon(
                Icons.menu_book_rounded,
                color: MyColors.myPurble2,
              ),
            ),
            // ListTile(
            //   // co: MyColors.myBlack,
            //   // selectedColor: MyColors.myGreen,
            //   title: Text("about us",
            //       style: p2.copyWith(
            //         color: MyColors.myBlack,
            //       )),
            //   leading: Icon(
            //     Icons.menu_book_rounded,
            //     color: MyColors.myPurble2,
            //   ),
            // ),
            ListTile(
              // co: MyColors.myBlack,
              // selectedColor: MyColors.myGreen,
              title: Text("Log Out",
                  style: p2.copyWith(
                    color: MyColors.myBlack,
                  )),
              leading: Icon(
                Icons.logout_outlined,
                color: MyColors.myPurble2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
