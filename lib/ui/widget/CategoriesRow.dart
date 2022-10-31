import 'package:book_nook_admin/consts/constant.dart';
import 'package:flutter/material.dart';

import '/../consts/myColors.dart';

class CategoriesRow extends StatefulWidget {
  const CategoriesRow();

  @override
  State<CategoriesRow> createState() => _CategoriesRowState();
}

class _CategoriesRowState extends State<CategoriesRow> {
  int selectedIndex = 0;
  PageController? _pageController;
  @override
  void initState() {
    // TODO: implement initState
    _pageController = PageController(initialPage: 1, viewportFraction: 0.4);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            controller: _pageController,
            itemCount: 10,
            itemBuilder: (context, index) {
              return CatItem(index: index);
            }));
  }
}

class CatItem extends StatelessWidget {
  const CatItem({
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // print(prov.AllDoctors[1]![0]);
      },
      child: Container(
        padding: EdgeInsets.zero,
        width: 120,
        alignment: Alignment.center,
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: index == 2 ? MyColors.myPurble : MyColors.myWhite,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border: Border.all(
                color: index == 2
                    ? MyColors.myPurble
                    : MyColors.myBlack.withAlpha(75))),
        child: Text(
          "Category $index",
          style: p2.copyWith(
            color:
                index == 2 ? MyColors.myWhite : MyColors.myBlack.withAlpha(70),
          ),
        ),
      ),
    );
  }
}
