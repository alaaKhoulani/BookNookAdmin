

import 'package:book_nook_admin/consts/myColors.dart';
import 'package:flutter/material.dart';

import '/../consts/constant.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      margin: EdgeInsets.fromLTRB(5, 5, 5, 20),
      height: 50,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: MyColors.myBlack.withOpacity(0.3),
                blurRadius: 50,
                offset: Offset(0, 7)),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(50))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon:const Icon(Icons.search),
                  hintText: "Search",
                  hintStyle: p2.copyWith(color: MyColors.myBlack),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none),
              autofocus: false,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.send,
              color: MyColors.myPurble,
            ),
          ),
        ],
      ),
    );
  }
}
