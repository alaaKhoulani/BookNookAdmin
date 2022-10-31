import 'dart:developer';

import 'package:book_nook_admin/consts/myColors.dart';
import 'package:book_nook_admin/services/translate/locale_keys.g.dart';
import 'package:book_nook_admin/ui/Screens/update_offer/update_offer_cubit.dart';
import 'package:book_nook_admin/ui/widget/MyButton.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';


class AddOfferScreen extends StatefulWidget {
  const AddOfferScreen({Key? key}) : super(key: key);

  @override
  State<AddOfferScreen> createState() => _AddOfferScreenState();
}

class _AddOfferScreenState extends State<AddOfferScreen> {
  void _showMultiSelect(BuildContext context, cubit) async {
    List items = cubit.books;
    List selected = cubit.selectedBooks;
    await showModalBottomSheet(
      isScrollControlled: true, // required for min/max child size
      context: context,
      builder: (ctx) {
        return MultiSelectBottomSheet(
          listType: MultiSelectListType.LIST,
          items: items.map((e) => MultiSelectItem(e, e)).toList(),
          initialValue: selected,
          onConfirm: (values) {
            cubit.addData(values);
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

  Widget buildTextField(cubit) {
    bool canSeeicon = true;
    RegExp numberValidate = RegExp("[0-9]+");

    return TextFormField(
      controller: cubit.priceController,
      validator: (inputValue) {
        if (inputValue!.isEmpty || !numberValidate.hasMatch(inputValue)) {
          log("empty");
          return LocaleKeys.enternumber.tr();
        }
        return null;
      },
      cursorColor: MyColors.myPurble,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: MyColors.myPurble),
        ),
        errorBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: MyColors.myPurble),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: MyColors.myPurble),
        ),
        hintText: LocaleKeys.enternumber.tr(),
        hintStyle: TextStyle(color: MyColors.myPurble),
        errorText: isNumber ? "" : LocaleKeys.enternumber.tr(),
        labelText: LocaleKeys.enternumber.tr(),
        labelStyle: TextStyle(color: MyColors.myPurble),
        prefixIcon: Icon(
          Icons.price_check,
          color: MyColors.myPurble,
        ),
      ),
    );
  }

  bool isNumber = true;
  @override
  @override
  Widget build(BuildContext context) {
    var _key = GlobalKey<FormState>();

    return BlocConsumer<UpdateOfferCubit, UpdateOfferState>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = UpdateOfferCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text("Update offer",//LocaleKeys.updateoffer.tr(),
                style: TextStyle(color: MyColors.myBlack)),
            backgroundColor: MyColors.myWhite,
          ),
          body: Form(
            key: _key,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  ListTile(
                    leading: Text(LocaleKeys.selectBook.tr(),
                        style: TextStyle(color: MyColors.myPurble)),
                    trailing: IconButton(
                        onPressed: () {
                          cubit.makeList();
                          _showMultiSelect(context, cubit);
                        },
                        icon: Icon(Icons.arrow_right,
                            color: MyColors.myPurble)),
                  ),
                  SizedBox(height: 20),
                  buildTextField(cubit),
                  SizedBox(height: 40),
                  MyButton(
                    child: Text(LocaleKeys.ok.tr(),
                        style: TextStyle(color: Colors.white)),
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
                        cubit.updateOffer();
                      }
                    },
                    width: 200,
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await context.setLocale(const Locale('en'));
            },
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }
}
