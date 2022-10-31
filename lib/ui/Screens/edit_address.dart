import 'package:book_nook_admin/business_logic/cubit/profile/profile_cubit.dart';
import 'package:book_nook_admin/business_logic/cubit/setting/seeting_cubit.dart';
import 'package:book_nook_admin/consts/constant.dart';
import 'package:book_nook_admin/consts/myColors.dart';
import 'package:book_nook_admin/data/models/address.dart';
import 'package:book_nook_admin/services/validate/validation.dart';
import 'package:book_nook_admin/ui/widget/MyButton.dart';
import 'package:book_nook_admin/ui/widget/inputCard.dart';
import 'package:book_nook_admin/ui/widget/loaading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditAdress extends StatefulWidget {
  final Address address;
  const EditAdress({Key? key, required this.address}) : super(key: key);

  @override
  State<EditAdress> createState() => _EditAdressState();
}

class _EditAdressState extends State<EditAdress> {
//  late Data _detailes;

  TextEditingController titleConroller = TextEditingController();
  TextEditingController areaConroller = TextEditingController();
  TextEditingController streetConroller = TextEditingController();
  TextEditingController floorConroller = TextEditingController();
  TextEditingController naearConroller = TextEditingController();
  TextEditingController detailsConroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: MyColors.myWhite,
        title: Text("Edit address",
            style: p1.copyWith(
              color: MyColors.myBlack,
            )),
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileSubmitting) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return LoadingDialog();
              },
            );
          } else if (state is EditAddressSuccessful) {
            print("hi ---- hi");
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, 'profile');
            // admin = state.admin;
          } else {
            // Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Center(
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 70,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        feild(
                            titleConroller,
                            "Title",
                            53,
                            Validation.validateRegisterFullName,
                            context,
                            widget.address.title!),
                        feild(
                            areaConroller,
                            "Area",
                            53,
                            Validation.validateRegisterFullName,
                            context,
                            widget.address.area!),
                        feild(
                            streetConroller,
                            "street",
                            43,
                            Validation.validateRegisterFullName,
                            context,
                            widget.address.street!),
                        feild(
                            floorConroller,
                            "Floor",
                            50,
                            Validation.validateRegisterFullName,
                            context,
                            widget.address.floor!.toString()),
                        feild(
                            naearConroller,
                            "Near",
                            51,
                            Validation.validateRegisterFullName,
                            context,
                            widget.address.near!),
                        feild(
                            detailsConroller,
                            "Details",
                            36,
                            Validation.validateRegisterFullName,
                            context,
                            widget.address.details.toString()),
                        MyButton(
                            child: Text("Done",
                                style: buttonfont.copyWith(
                                  color: MyColors.myWhite,
                                )),
                            fun: () {
                              BlocProvider.of<ProfileCubit>(context)
                                  .editAddress(
                                      title: titleConroller.value.text,
                                      area: areaConroller.value.text,
                                      street: streetConroller.value.text,
                                      floor: floorConroller.value.text,
                                      near: naearConroller.value.text,
                                      details: detailsConroller.value.text);
                            },
                            context: context),
                      ])),
            ),
          );
        },
      ),
    );
  }
}

Widget feild(TextEditingController controller, String name, double spaceWidth,
    FormFieldValidator<String> validate, BuildContext context, String init) {
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
                initValue: init,
                name: "$name",
                controller: controller,
                vlaidate: validate,
              ),
            ),
            name == "Authors" || name == "Category"
                ? IconButton(onPressed: () {}, icon: Icon(Icons.send_rounded))
                : Container()
          ],
        ),
      ),
    ],
  );
}
