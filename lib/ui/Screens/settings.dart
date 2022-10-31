import 'dart:io';

import 'package:book_nook_admin/business_logic/cubit/post_image/post_image_cubit.dart';
import 'package:book_nook_admin/business_logic/cubit/profile/profile_cubit.dart';
import 'package:book_nook_admin/business_logic/cubit/setting/seeting_cubit.dart';
import 'package:book_nook_admin/consts/constant.dart';
import 'package:book_nook_admin/consts/myColors.dart';
import 'package:book_nook_admin/services/storage/store.dart';
import 'package:book_nook_admin/services/translate/locale_keys.g.dart';
import 'package:book_nook_admin/services/validate/validation.dart';
import 'package:book_nook_admin/ui/widget/MyButton.dart';
import 'package:book_nook_admin/ui/widget/inputCard.dart';
import 'package:book_nook_admin/ui/widget/loaading_dialog.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:from_to_time_picker/from_to_time_picker.dart';
import 'package:image_picker/image_picker.dart';

class Settings extends StatefulWidget {
  // User user;
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _EdetAdminProfileState();
}

class _EdetAdminProfileState extends State<Settings> {
//  late Data _detailes;
  // String gender = '';

  // String fordate = LocaleKeys.nodateSelected.tr();
  // DateTime? _selectedDate;

  TextEditingController firstnameConroller =
      TextEditingController(text: Store.myAdmin.firstName!);
  TextEditingController middlenameConroller =
      TextEditingController(text: Store.myAdmin.middleName!);
  TextEditingController lastnametConroller =
      TextEditingController(text: Store.myAdmin.lastName!);
  TextEditingController librarynameConroller = TextEditingController();
  TextEditingController phonenumberConroller =
      TextEditingController(text: Store.myAdmin.phone);

  // String fordate = LocaleKeys.nodateSelected.tr();
  // TimeOfDay _selectedTime = TimeOfDay(hour: 0, minute: 0);
  TextEditingController stateConroller = TextEditingController();
  TextEditingController opentimeConroller = TextEditingController();
  TextEditingController closetimetimeConroller = TextEditingController();
  TimeOfDay? start = TimeOfDay(
          hour: int.parse(Store.myAdmin.openTime!.split(":")[0]),
          minute: int.parse(Store.myAdmin.openTime!.split(":")[1])),
      end = TimeOfDay(
          hour: int.parse(Store.myAdmin.closeTime!.split(":")[0]),
          minute: int.parse(Store.myAdmin.closeTime!.split(":")[1]));

  TimeOfDay _selectedTime = TimeOfDay(hour: 0, minute: 0);

  File? pickedimage; // holds image file
  final ImagePicker _picker = ImagePicker(); //image picker instance
  _pickimage(BuildContext context) async {
    // pick image from gallery

    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (image == null) // if user doesn't pick any image just return
    {
      return;
    }
    BlocProvider.of<ProfileCubit>(context).setImage(File(image.path));
  }

  //from camera
  _pickimagecamera(BuildContext context) async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
    ); //pick image from camera
    if (image == null) {
      return;
    }
    BlocProvider.of<ProfileCubit>(context).setImage(File(image.path));
  }

  void pickone(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext ctx) {
          return SafeArea(
              child: SizedBox(
            height: 150,
            width: double.infinity,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: Text('gallery'),
                  onTap: () {
                    _pickimage(context);

                    Navigator.of(context).pop();
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: Text('camera'),
                  onTap: () {
                    _pickimagecamera(context);
                    Navigator.of(context).pop();
                  },
                ),
                const Divider(),
              ],
            ),
          ));
        });
  }

  @override
  Widget build(BuildContext context) {
    start = TimeOfDay(
        hour: int.parse(Store.myAdmin.openTime!.split(":")[0]),
        minute: int.parse(Store.myAdmin.openTime!.split(":")[1]));
    end = TimeOfDay(
        hour: int.parse(Store.myAdmin.closeTime!.split(":")[0]),
        minute: int.parse(Store.myAdmin.closeTime!.split(":")[1]));
    var _cubit = BlocProvider.of<ProfileCubit>(context);
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   elevation: 0,
      //   backgroundColor: MyColors.myWhite,
      //   title: Text("Add address",style: p1.copyWith(color: MyColors.myBlack,)),
      // ),
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
          } else if (state is ProfileEditingSuccess) {
            Navigator.pop(context);
            Navigator.popAndPushNamed(context, 'profile');
          } else if (state is ProfileFailure) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text((state.exception.toString() + '.'))));
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
                        Text(
                          " Update your informations",
                          style: p1,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            pickone(context);
                          },
                          child: Container(
                            margin: EdgeInsets.all(20),
                            child: _cubit.imageFile != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        10), // Image border
                                    child: SizedBox.fromSize(
                                      size: Size.fromRadius(60),
                                      child: Image(
                                          image: FileImage(_cubit.imageFile!),
                                          fit: BoxFit.cover),
                                    ),
                                  )
                                : Store.myAdmin.image != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            10), // Image border
                                        child: SizedBox.fromSize(
                                          size: Size.fromRadius(60),
                                          child: Image(
                                              image: NetworkImage(
                                                  "${Store.baseURL}/${Store.myAdmin.image}"),
                                              fit: BoxFit.cover),
                                        ),
                                      )
                                    : Container(
                                        margin: EdgeInsets.all(10),
                                        child: FloatingActionButton(
                                          backgroundColor: MyColors.myPurble,
                                          child: const Icon(
                                            Icons.add_a_photo,
                                          ),
                                          onPressed: () {
                                            pickone(context);
                                          },
                                        ),
                                      ),
                          ),
                        ),
                        feild(
                            firstnameConroller,
                            "First Name",
                            53,
                            Validation.validateRegisterFullName,
                            context,
                            Store.myAdmin.firstName!),
                        feild(
                            middlenameConroller,
                            "Middle Name",
                            43,
                            Validation.validateRegisterFullName,
                            context,
                            Store.myAdmin.middleName!),
                        feild(
                            lastnametConroller,
                            "Last Name",
                            53,
                            Validation.validateRegisterFullName,
                            context,
                            Store.myAdmin.lastName!),
                        feild(
                            librarynameConroller,
                            "Library Name",
                            33,
                            Validation.validateRegisterFullName,
                            context,
                            Store.myAdmin.libraryName.toString()),
                        feild(
                            phonenumberConroller,
                            "phone Namber",
                            29,
                            Validation.validateRegisterFullName,
                            context,
                            Store.myAdmin.phone!),
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
                        // feild(opentimeConroller, "open Time", 53,
                        //     Validation.validateRegisterFullName, context),
                        // feild(closetimetimeConroller, "close Time", 53,
                        //     Validation.validateRegisterFullName, context),

                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "changPassword");
                            },
                            child: Text("Change password ", //ToDo translate
                                style: p1.copyWith(
                                  color: MyColors.myPurble,
                                  decoration: TextDecoration.underline,
                                ))),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Text(
                        //       "Select open and close time",
                        //       style: p2.copyWith(color: MyColors.myBlack),
                        //     ),
                        //     TextButton(
                        //         onPressed: () => showLightTimePicker(),
                        //         child: Container(
                        //             padding:
                        //                 EdgeInsets.fromLTRB(15, 10, 15, 10),
                        //             decoration: BoxDecoration(
                        //                 borderRadius: BorderRadius.all(
                        //                     Radius.circular(20)),
                        //                 color: MyColors.myPurble),
                        //             child: Text("select",
                        //                 style: buttonfont.copyWith(
                        //                   color: MyColors.myWhite,
                        //                 )))),
                        //   ],
                        // ),
                        MyButton(
                            child: Text("Done",
                                style: buttonfont.copyWith(
                                  color: MyColors.myWhite,
                                )),
                            fun: () async {
                              print(Store.myAdmin.openTime);
                              print(end);
                              await BlocProvider.of<ProfileCubit>(context)
                                  .editProfile(
                                      firstName: firstnameConroller.text,
                                      middletName: middlenameConroller.text,
                                      lastName: lastnametConroller.text,
                                      libraryName: librarynameConroller.text,
                                      phonNumber: phonenumberConroller.text,
                                      start: format(start),
                                      end: format(end));
                            },
                            context: context),
                      ])),
            ),
          );
        },
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

  String? format(TimeOfDay? time) {
    if (time == null) return null;
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
