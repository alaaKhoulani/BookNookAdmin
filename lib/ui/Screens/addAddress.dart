import 'package:book_nook_admin/business_logic/cubit/AddAdress/add_address_cubit.dart';
import 'package:book_nook_admin/business_logic/cubit/add_book/add_book_cubit.dart';
import 'package:book_nook_admin/consts/constant.dart';
import 'package:book_nook_admin/consts/myColors.dart';
import 'package:book_nook_admin/services/validate/validation.dart';
import 'package:book_nook_admin/ui/widget/MyButton.dart';
import 'package:book_nook_admin/ui/widget/inputCard.dart';
import 'package:book_nook_admin/ui/widget/loaading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAddress extends StatelessWidget {
  AddAddress({super.key});
  TextEditingController titleConroller = TextEditingController();
  TextEditingController areaConroller = TextEditingController();
  TextEditingController streetConroller = TextEditingController();
  TextEditingController floorConroller = TextEditingController();
  TextEditingController naearConroller = TextEditingController();
  TextEditingController detailsConroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<AddAddressCubit, AddAddressState>(
      listener: (context, state) {
        if (state is AddAddressSubmitting) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return LoadingDialog();
            },
          );
        } else if (state is AddAddressSuccess) {
          print("hi");
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, 'home');
        } else if (state is AddAddressFailure) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(("${state.exception}" + '.'))));
        }
      },
      child: Scaffold(
        // appBar: AppBar(
        //   centerTitle: true,
        //   elevation: 0,
        //   backgroundColor: MyColors.myWhite,
        //   title: Text("Add address",style: p1.copyWith(color: MyColors.myBlack,)),
        // ),
        body: Center(
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
                      Text(
                        "Please add yorur address",
                        style: p1,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      feild(titleConroller, "Title", 53,
                          Validation.validateRegisterFullName, context),
                      feild(areaConroller, "Area", 53,
                          Validation.validateRegisterFullName, context),
                      feild(streetConroller, "street", 43,
                          Validation.validateRegisterFullName, context),
                      feild(floorConroller, "Floor", 50,
                          Validation.validateNumericField, context),
                      feild(naearConroller, "Near", 51,
                          Validation.validateRegisterFullName, context),
                      feild(detailsConroller, "Details", 36,
                          Validation.validateRegisterFullName, context),
                      MyButton(
                          child: Text("Done",
                              style: buttonfont.copyWith(
                                color: MyColors.myWhite,
                              )),
                          fun: () {
                            BlocProvider.of<AddAddressCubit>(context)
                                .addAddress(
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
        ),
      ),
    );
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
              name == "Authors" || name == "Category"
                  ? IconButton(onPressed: () {}, icon: Icon(Icons.send_rounded))
                  : Container()
            ],
          ),
        ),
      ],
    );
  }
}
