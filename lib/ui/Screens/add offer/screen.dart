import 'dart:developer';
import 'package:book_nook_admin/consts/constant.dart';
import 'package:book_nook_admin/consts/myColors.dart';
import 'package:book_nook_admin/data/models/Book.dart';
import 'package:book_nook_admin/data/models/offers.dart';
import 'package:book_nook_admin/services/translate/locale_keys.g.dart';
import 'package:book_nook_admin/services/validate/validation.dart';
import 'package:book_nook_admin/ui/Screens/add%20offer/add_offer_cubit.dart';
import 'package:book_nook_admin/ui/Screens/add%20offer/model.dart';
import 'package:book_nook_admin/ui/widget/MyButton.dart';
import 'package:book_nook_admin/ui/widget/inputCard.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

// import '../../../add offer/cubit.dart';

class AddOfferScreen extends StatefulWidget {
  const AddOfferScreen({Key? key}) : super(key: key);

  @override
  State<AddOfferScreen> createState() => _AddOfferScreenState();
}

class _AddOfferScreenState extends State<AddOfferScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quintityController = TextEditingController();

  void _showMultiSelect(BuildContext context) async {
    var cubit = BlocProvider.of<AddOfferCubit>(context);
    List<Pair> items = cubit.books;
    List selected = cubit.selectedBooks;
    await showModalBottomSheet(
      isScrollControlled: true, // required for min/max child size
      context: context,
      builder: (ctx) {
        return MultiSelectBottomSheet(
          listType: MultiSelectListType.LIST,
          items: items.map((e) => MultiSelectItem(e, e.name)).toList(),
          initialValue: selected,
          onConfirm: (values) {
            print("values");
            print(values);
            cubit.addData(values);
            cubit.selectedBooks.clear();
            // selected = cubit.selectedBooks;
            // Navigator.pop(context);
          },
          searchable: true,
          cancelText: Text(LocaleKeys.cancle.tr(),
              style: TextStyle(color: MyColors.myPurble)),
          confirmText: Text(LocaleKeys.ok.tr(),
              style: TextStyle(color: MyColors.myPurble)),
          checkColor: Colors.white,
          selectedColor: MyColors.myPurble,
          unselectedColor: Colors.grey,
          title: Text(LocaleKeys.selectBook.tr(),
              style: TextStyle(color: MyColors.myPurble)),
        );
      },
    );
  }

  // Widget buildTextField(cubit) {
  //   bool canSeeicon = true;
  //   RegExp numberValidate = RegExp("[0-9]+");

  //   return TextFormField(
  //     controller: cubit.priceController,
  //     validator: (inputValue) {
  //       if (inputValue!.isEmpty || !numberValidate.hasMatch(inputValue)) {
  //         log("empty");
  //         return LocaleKeys.enternumber.tr();
  //       }
  //       return null;
  //     },
  //     cursorColor: MyColors.myPurble,
  //     decoration: InputDecoration(
  //       border: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(10),
  //         borderSide: BorderSide(color: MyColors.myPurble),
  //       ),
  //       errorBorder:
  //           OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
  //       enabledBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(10),
  //         borderSide: BorderSide(color: MyColors.myPurble),
  //       ),
  //       focusedBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(10),
  //         borderSide: BorderSide(color: MyColors.myPurble),
  //       ),
  //       hintText: LocaleKeys.enternumber.tr(),
  //       hintStyle: TextStyle(color: MyColors.myPurble),
  //       errorText: isNumber ? "" : LocaleKeys.enternumber.tr(),
  //       labelText: LocaleKeys.enternumber.tr(),
  //       labelStyle: TextStyle(color: MyColors.myPurble),
  //       prefixIcon: Icon(
  //         Icons.price_check,
  //         color: MyColors.myPurble,
  //       ),
  //     ),
  //   );
  // }

  bool isNumber = true;
  @override
  @override
  Widget build(BuildContext context) {
    var _key = GlobalKey<FormState>();

    final cubit = BlocProvider.of<AddOfferCubit>(context);
    // return BlocConsumer<AddOfferCubit, AddOfferState>(
    // listener: (context, state) {},
    // builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.addOffer.tr(),
            style: TextStyle(color: Colors.white)),
        backgroundColor: MyColors.myPurble,
      ),
      body: Form(
        key: _key,
        child: Container(
          padding: EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                feild(titleController, "Title", 40,
                    Validation.validateProductTitle, context),
                feild(priceController, "Price", 35,
                    Validation.validateNumericField, context),
                feild(quintityController, "Quintity", 20,
                    Validation.validateNumericField, context),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  leading: Text(LocaleKeys.selectBook.tr(),
                      style: TextStyle(color: MyColors.myBlack)),
                  trailing: IconButton(
                      onPressed: () {
                        // print("object");
                        cubit.makeList();
                        _showMultiSelect(context);
                      },
                      icon: Icon(Icons.arrow_right, color: MyColors.myPurble)),
                ),
                SizedBox(height: 20),
                // buildTextField(cubit),
                SizedBox(height: 40),
                MyButton(
                  child: Text(LocaleKeys.ok.tr(),
                      style: buttonfont.copyWith(color: MyColors.myWhite)),
                  context: context,
                  fun: () {
                    // await context.setLocale(const Locale('en'));
                    if (_key.currentState!.validate()) {
                      setState(() {
                        isNumber = true;
                      });
                    } else {
                      setState(() {
                        isNumber = false;
                      });
                    }
                    if (isNumber) {
                      log("navigate");
                      cubit.addOffer();
                      cubit.getFromApi(
                          title: titleController.text,
                          totalPrice: priceController.text,
                          quantity: quintityController.text);
                    }
                  },
                  width: 250,
                ),
              ],
            ),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     await context.setLocale(const Locale('en'));
      //   },
      //   child: Icon(Icons.add),
      // ),
    );
    // },
    // );
  }

  Widget feild(TextEditingController controller, String name, double spaceWidth,
      FormFieldValidator<String> validate, BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("$name:"),
        SizedBox(
          width: spaceWidth,
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: InputCard(
                  name: "$name",
                  controller: controller,
                  vlaidate: validate,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
