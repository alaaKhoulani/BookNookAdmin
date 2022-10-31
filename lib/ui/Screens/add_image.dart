import 'dart:io';

import 'package:book_nook_admin/consts/constant.dart';
import 'package:book_nook_admin/consts/myColors.dart';
import 'package:book_nook_admin/ui/widget/loaading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../business_logic/cubit/add_book/add_book_cubit.dart';
import '../../business_logic/cubit/post_image/post_image_cubit.dart';

class AddImage extends StatefulWidget {
  const AddImage({super.key});

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
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
                    _pickimage();
                    Navigator.of(context).pop();
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: Text('camera'),
                  onTap: () {
                    _pickimagecamera();
                    Navigator.of(context).pop();
                  },
                ),
                const Divider(),
              ],
            ),
          ));
        });
  }

  File? pickedimage;
  // holds image file
  final ImagePicker _picker = ImagePicker();
  //image picker instance
  _pickimage() async {
    // pick image from gallery

    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (image == null) // if user doesn't pick any image just return
    {
      return;
    }
    setState(() {
      pickedimage = File(image.path); // putthe selected image in the UI
    });
  }

  //from camera
  _pickimagecamera() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
    ); //pick image from camera
    if (image == null) {
      return;
    }
    setState(() {
      pickedimage = File(image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostImabeCubit, PostImabeState>(
      listener: (context, state) {
       if (state is PostImabeSubmitting) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return LoadingDialog();
            },
          );
        } else if (state is PostImabeSuccess) {
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, 'addAddress');
        } else if (state is PostImabeFailure) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(("${state.exception}" + '.'))));
        }
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Please add Photo to your library",
              style: h2.copyWith(),
            ),
            SizedBox(
              height: 20,
            ),
            Image.asset("assets/images/addPhoto.png"),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 150,
                  decoration: BoxDecoration(
                    color: MyColors.myPurble,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: MaterialButton(
                    child: Text(
                      "Select photo",
                      style: buttonfont.copyWith(color: MyColors.myWhite),
                    ),
                    onPressed: () {
                      pickone(context);
                      if (pickedimage != null) {
                        BlocProvider.of<PostImabeCubit>(context)
                            .addPhoto(image: pickedimage!);
                      }
                    },
                  ),
                ),
                Container(
                  width: 150,
                  decoration: BoxDecoration(
                    color: MyColors.myGrey,
                    border: Border.all(color: MyColors.myGrey),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: MaterialButton(
                    child: Text(
                      "Skip",
                      style: buttonfont.copyWith(color: MyColors.myBlack),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, "addAddress");
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
