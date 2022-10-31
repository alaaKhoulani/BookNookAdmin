
import 'package:book_nook_admin/consts/constant.dart';
import 'package:flutter/material.dart';

import '../../../consts/myColors.dart';

class CategoryFavourite extends StatelessWidget {
  const CategoryFavourite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: MyColors.myPurble,
        onPressed: () {
          Navigator.pushReplacementNamed(context, 'home');
        },
        label: Row(
          children: [
            Text("Done"),
            Icon(Icons.arrow_right)
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  "Select at least 3 kinds you like :",
                  style: const TextStyle(fontSize: 40),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 40,
                ),
                Wrap(
                  
                  spacing: 10.0,
                  runSpacing: 20.0,
                  children: [
                    ChipWidget(
                      lable: chipContainer("Action"),
                    ),
                    ChipWidget(
                      lable: chipContainer("Classics"),
                    ),
                    ChipWidget(
                      lable: chipContainer("Horror"),
                    ),
                    ChipWidget(
                      lable: chipContainer("True Crime"),
                    ),
                    ChipWidget(
                      lable: chipContainer("Crime"),
                    ),
                    ChipWidget(
                      lable: chipContainer("Fantasy"),
                    ),
                    ChipWidget(
                      lable: chipContainer("Historical Fiction"),
                    ),
                    ChipWidget(
                      lable: chipContainer("Adventure"),
                    ),
                    ChipWidget(
                      lable: chipContainer("Graphic Novel"),
                    ),
                    ChipWidget(
                      lable: chipContainer("Comic Book"),
                    ),
                    ChipWidget(
                      lable: chipContainer("Humor"),
                    ),
                    ChipWidget(
                      lable: chipContainer("Mystery"),
                    ),
                    ChipWidget(
                      lable: chipContainer("Romance"),
                    ),
                    ChipWidget(
                      lable: chipContainer("Graphic Novel"),
                    ),
                    ChipWidget(
                      lable: chipContainer("Poetry"),
                    ),
                    ChipWidget(
                      lable: chipContainer("Cookbooks"),
                    ),
                    ChipWidget(
                      lable: chipContainer("Science Fiction"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget chipContainer(String lable) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      height: 45,
      padding: const EdgeInsets.all(10),
      child: Text(
        lable,
        style: p1.copyWith(color: MyColors.myBlack),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class ChipWidget extends StatefulWidget {
  final lable;
  ChipWidget({Key? key, required this.lable}) : super(key: key);

  @override
  State<ChipWidget> createState() => _ChipWidgetState();
}

class _ChipWidgetState extends State<ChipWidget> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FilterChip(
        label: widget.lable,
        backgroundColor: MyColors.myGrey,
        selectedColor: MyColors.myGreen,
        selected: isSelected,
        onSelected: (newvalue) {
          setState(() {
            isSelected = newvalue;
          });
        },
      ),
    );
  }
}
