import 'dart:convert';
import 'dart:io';

import 'package:book_nook_admin/business_logic/cubit/admin_information/admin_information_cubit.dart';
import 'package:book_nook_admin/business_logic/cubit/register_cubit/register_cubit.dart';
import 'package:book_nook_admin/consts/constant.dart';
import 'package:book_nook_admin/data/models/admin.dart';
import 'package:book_nook_admin/services/validate/validation.dart';
import 'package:book_nook_admin/ui/widget/Header.dart';
import 'package:book_nook_admin/ui/widget/MyButton.dart';
import 'package:book_nook_admin/ui/widget/inputCard.dart';
import 'package:book_nook_admin/ui/widget/loaading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:from_to_time_picker/from_to_time_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbols.dart';
import 'package:intl/intl.dart';
import '../../../consts/myColors.dart';
import '../../services/storage/store.dart';

class AdminInformation extends StatefulWidget {
  AdminInformation({Key? key}) : super(key: key);

  @override
  State<AdminInformation> createState() => _AdminInformationState();
}

class _AdminInformationState extends State<AdminInformation> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController libraryNameController = TextEditingController();
  TimeOfDay? start, end;

  TimeOfDay _selectedTime = TimeOfDay(hour: 0, minute: 0);
  var size, height, width;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    var screenSize = MediaQuery.of(context).size;
    screenHeight = screenSize.height;
    screenWidth = screenSize.width;
    return BlocListener<AdminInformationCubit, AdminInformationState>(
      listener: (context, state) {
        if (state is AdminInformationSubmitting) {
          print("Doneeeeeeeeeeeeeeeeeeeeeeeeeeee");
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return LoadingDialog();
            },
          );
        } else if (state is AdminInformationSuccess) {
          print("Doneeeeeeeeeeeeeeeeeeeeeeeeeeee");
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, 'addImage');
        } else if (state is AdminInformationFailure) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text((state.exception.toString() + '.'))));
        }
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          // floatingActionButtonLocation:
          //     FloatingActionButtonLocation.centerFloat,
          // floatingActionButton: FloatingActionButton.extended(
          //   backgroundColor: MyColors.myPurble,
          //   onPressed: ,
          //   label:
          // ),
          backgroundColor: MyColors.myWhite,
          body: SafeArea(
            child: Column(
              children: [
                Header(height: height, width: width, title: ""),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.fromLTRB(30, 30, 30, 10),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          Text("Your Information",
                              style: h2.copyWith(
                                color: MyColors.myBlack,
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          InputCard(
                            name: "First Name",
                            controller: firstNameController,
                            vlaidate: Validation.validateRegisterFullName,
                          ),
                          InputCard(
                            name: "Middle Name",
                            controller: middleNameController,
                            vlaidate: Validation.validateRegisterFullName,
                          ),
                          InputCard(
                            name: "Last Name",
                            controller: lastNameController,
                            vlaidate: Validation.validateRegisterFullName,
                          ),
                          InputCard(
                            name: "Your Number Phon",
                            controller: phoneController,
                            vlaidate: Validation.validateRegisterPhoneNumber,
                          ),
                          InputCard(
                            name: "Library Name",
                            controller: libraryNameController,
                            vlaidate: Validation.validateRegisterFullName,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Select open and close time",
                                style: p2.copyWith(color: MyColors.myBlack),
                              ),
                              TextButton(
                                  onPressed: () => showLightTimePicker(),
                                  child: Container(
                                      padding:
                                          EdgeInsets.fromLTRB(15, 10, 15, 10),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          color: MyColors.myPurble),
                                      child: Text("select",
                                          style: buttonfont.copyWith(
                                            color: MyColors.myWhite,
                                          )))),
                            ],
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          MyButton(
                              child: Container(
                                margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                                width: screenWidth * 0.5,
                                child: Center(
                                  child: Text(
                                    "Continue",
                                    style: TextStyle(color: MyColors.myWhite),
                                  ),
                                ),
                              ),
                              fun: () async {
                                if (firstNameController.value.text.isNotEmpty &&
                                    firstNameController.value.text != null &&
                                    middleNameController
                                        .value.text.isNotEmpty &&
                                    middleNameController.value.text != null &&
                                    lastNameController.value.text.isNotEmpty &&
                                    lastNameController.value.text != null &&
                                    phoneController.value.text.isNotEmpty &&
                                    phoneController.value.text != null &&
                                    start != null &&
                                    start!.format(context).isNotEmpty &&
                                    end != null &&
                                    end!.format(context).isNotEmpty)
                                  await BlocProvider.of<
                                          AdminInformationCubit>(context)
                                      .submitInformation(
                                          firstName: firstNameController
                                              .value.text
                                              .toString(),
                                          middleName:
                                              middleNameController
                                                  .value.text
                                                  .toString(),
                                          lastyName: lastNameController.value.text
                                              .toString(),
                                          libraryName: libraryNameController.value
                                              .text
                                              .toString(),
                                          phonNumber: phoneController.value.text
                                              .toString(),
                                          start: format(start!),
                                          end: format(end!), // formatDate(end),
                                          token: Store.token!);
                              },
                              context: context)
                        ],
                      ),
                    ),
                  ),
                ),
                // const SizedBox(height: 5),
                // toLogin(context),
                // const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showDarkTimePicker() {
    showDialog(
      context: context,
      builder: (_) => FromToTimePicker(
        onTab: (from, to) {
          print('from $from to $to');
        },
        dialogBackgroundColor: Color(0xFF121212),
        fromHeadlineColor: Colors.white,
        toHeadlineColor: Colors.white,
        upIconColor: Colors.white,
        downIconColor: Colors.white,
        timeBoxColor: Color(0xFF1E1E1E),
        timeHintColor: Colors.grey,
        timeTextColor: Colors.white,
        dividerColor: Color(0xFF121212),
        doneTextColor: Colors.white,
        dismissTextColor: Colors.white,
        defaultDayNightColor: Color(0xFF1E1E1E),
        defaultDayNightTextColor: Colors.white,
        colonColor: Colors.white,
        showHeaderBullet: true,
        headerText: 'Time available from 01:00 AM to 11:00 PM',
      ),
    );
  }

  // String formatDate(DateTime date) => new DateFormat("Hm").format(date);

  String format(TimeOfDay time) {
    String hour = time.hour.toString().padLeft(2, '0');
    String minute = time.minute.toString().padLeft(2, '0');
    print("$hour:$minute");
    return "$hour:$minute";
    // var inputDate = DateTime(time.hour, time.minute);

    //   var outputFormat = DateFormat('Hm');
    // var outputDate = outputFormat.format(inputDate);
    // print(outputDate);
    // return outputDate;
  }

  void showLightTimePicker() {
    showDialog(
        context: context,
        builder: (_) => FromToTimePicker(
              onTab: (from, to) {
                start = from;
                end = to;
                print("okkkk===================");
                format(from);
                format(to);
                // print('from $from to $to');
              },
            ));
  }
}
