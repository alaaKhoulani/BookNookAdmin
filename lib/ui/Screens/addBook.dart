import 'dart:io';

import 'package:book_nook_admin/business_logic/cubit/add_book/add_book_cubit.dart';
import 'package:book_nook_admin/business_logic/cubit/register_cubit/register_cubit.dart';
import 'package:book_nook_admin/consts/constant.dart';
import 'package:book_nook_admin/consts/myColors.dart';
import 'package:book_nook_admin/services/validate/validation.dart';
import 'package:book_nook_admin/ui/Screens/HomePage.dart';
import 'package:book_nook_admin/ui/widget/MyButton.dart';
import 'package:book_nook_admin/ui/widget/inputCard.dart';
import 'package:book_nook_admin/ui/widget/loaading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddBook extends StatefulWidget {
  AddBook({Key? key}) : super(key: key);

  @override
  State<AddBook> createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    var cubit = BlocProvider.of<AddBookCubit>(context);
    cubit.Categories.clear();
    cubit.authors.clear();
  }

  TextEditingController nameController = new TextEditingController();

  TextEditingController authorcontroller = new TextEditingController();

  TextEditingController summaryController = new TextEditingController();

  TextEditingController sellingPriceController = new TextEditingController();

  TextEditingController purchasingPriceController = new TextEditingController();

  TextEditingController borrowPriceController = new TextEditingController();

  TextEditingController newQuintityController = new TextEditingController();

  TextEditingController borrowQuintityController = new TextEditingController();

  TextEditingController pagesNumberController = new TextEditingController();

  TextEditingController categoryController = new TextEditingController();

  File? pickedimage;
  // holds image file
  final ImagePicker _picker = ImagePicker();
  //image picker instance
  _pickimage(BuildContext context) async {
    // pick image from gallery

    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (image == null) // if user doesn't pick any image just return
    {
      return;
    }
    BlocProvider.of<AddBookCubit>(context).setImage(File(image.path));
  }

  //from camera
  _pickimagecamera(BuildContext context) async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
    ); //pick image from camera
    if (image == null) {
      return;
    }
    BlocProvider.of<AddBookCubit>(context).setImage(File(image.path));
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

  List<String> category = [], authers = [];

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenHeight = screenSize.height;
    var screenWidth = screenSize.width;
    var pickedimage;
    var _cubit = BlocProvider.of<AddBookCubit>(context);
    return BlocConsumer<AddBookCubit, AddBookState>(
      listener: (context, state) {
        if (state is RegisterSubmitting) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return LoadingDialog();
            },
          );
        } else if (state is AddBookSuccess) {
          Navigator.pop(context);
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => HomePage()));
          // Navigator.pushReplacementNamed(context, 'home');
        } else if (state is AddBookFailure) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(("state.exception" + '.'))));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            toolbarHeight: 70,
            elevation: 0,
            title: Text("Add Book"),
            backgroundColor: MyColors.myPurble,
          ),
          body: Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        height: 70,
                      ),
                      BlocListener<AddBookCubit, AddBookState>(
                        listener: (context, state) {},
                        child: Container(
                          margin: EdgeInsets.all(20),
                          child: _cubit.imageFile != null
                              ? GestureDetector(
                                  onTap: () {
                                    pickone(context);
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        10), // Image border
                                    child: SizedBox.fromSize(
                                      size: Size.fromRadius(60),
                                      child: Image(
                                          image: FileImage(_cubit.imageFile!),
                                          fit: BoxFit.cover),
                                    ),
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
                      )
                    ],
                  ),
                  feild(nameController, "Name", 46,
                      Validation.validateRegisterFullName, context),
                  feild(summaryController, "Summary", 30,
                      Validation.validateRegisterFullName, context),
                  feild(pagesNumberController, "Pages number", 10,
                      Validation.validateNumericField, context),
                  feild(purchasingPriceController, "Purchasing Price", 25,
                      Validation.validateNumericField, context),
                  feild(sellingPriceController, "Selling Price", 51,
                      Validation.validateNumericField, context),
                  feild(newQuintityController, "Quantity", 30,
                      Validation.validateNumericField, context),
                  feild(authorcontroller, "Authors", 36,
                      Validation.validateRegisterFullName, context),
                  Container(
                    child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 3,
                            childAspectRatio: 2),
                        itemCount: _cubit.authors.length,
                        itemBuilder: (context, index) {
                          return Container(
                            // height: 200,
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(left: 20),
                            decoration: BoxDecoration(
                              color: MyColors.myGreen,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Row(
                              children: [
                                Text(_cubit.authors[index],
                                    style: p2.copyWith(
                                      color: MyColors.myBlack,
                                    )),
                                Spacer(),
                                IconButton(
                                    onPressed: () {
                                      BlocProvider.of<AddBookCubit>(context)
                                          .deleteAuthor(_cubit.authors[index]);
                                    },
                                    icon: Icon(
                                      Icons.close_rounded,
                                      size: 15,
                                    ))
                              ],
                            ),
                          );
                        }),
                  ),
                  feild(categoryController, "Category", 27,
                      Validation.validateNumericField, context),
                  Container(
                    child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 3,
                            crossAxisSpacing: 0,
                            childAspectRatio: 2),
                        itemCount: _cubit.Categories.length,
                        itemBuilder: (context, index) {
                          return Container(
                            // height: 200,
                            decoration: BoxDecoration(
                              color: MyColors.myGreen,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(left: 20),
                            child: Row(
                              children: [
                                Text(_cubit.Categories[index],
                                    style: p2.copyWith(
                                      color: MyColors.myBlack,
                                    )),
                                Spacer(),
                                IconButton(
                                    onPressed: () {
                                      BlocProvider.of<AddBookCubit>(context)
                                          .deleteCategory(
                                              _cubit.Categories[index]);
                                    },
                                    icon: Icon(
                                      Icons.close_rounded,
                                      size: 15,
                                    ))
                              ],
                            ),
                          );
                        }),
                  ),
                  Divider(
                    height: 20,
                    thickness: 0,
                    color: MyColors.myBlack,
                  ),
                  Text(
                    "book for borrow:",
                    style: p1,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: InputCard(
                              name: "Quantity",
                              controller: borrowQuintityController,
                              vlaidate: Validation.validateNumericField)),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: InputCard(
                              name: "price",
                              controller: borrowPriceController,
                              vlaidate: Validation.validateNumericField)),
                    ],
                  ),
                  MyButton(
                      child: Text("Done",
                          style: buttonfont.copyWith(
                            color: MyColors.myWhite,
                          )),
                      fun: () {
                        addNewBook(context);
                        addUtilizedBook(context);
                        // _cubit.imageFile = null;
                      },
                      context: context),
                ],
              ),
            ),
          ),
        );
      },
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
                  ? IconButton(
                      onPressed: () {
                        if (name == "Authors") {
                          BlocProvider.of<AddBookCubit>(context)
                              .addAuther(controller.value.text);
                          authorcontroller.clear();
                        } else if (name == "Category") {
                          BlocProvider.of<AddBookCubit>(context)
                              .addCategory(controller.value.text);
                          categoryController.clear();
                        }
                      },
                      icon: Icon(Icons.send_rounded))
                  : Container()
            ],
          ),
        ),
      ],
    );
  }

  addNewBook(BuildContext context) {
    print("new");
    var _cubit = BlocProvider.of<AddBookCubit>(context);

    if (nameController.value.text.isNotEmpty &&
        nameController.value.text != null &&
        _cubit.imageFile != null &&
        summaryController.value.text.isNotEmpty &&
        summaryController.value.text != null &&
        sellingPriceController.value.text.isNotEmpty &&
        sellingPriceController.value.text != null &&
        purchasingPriceController.value.text.isNotEmpty &&
        purchasingPriceController.value.text != null &&
        newQuintityController.value.text.isNotEmpty &&
        newQuintityController.value.text != '0' &&
        newQuintityController.value.text != null &&
        _cubit.authors.isNotEmpty &&
        _cubit.authors != null &&
        _cubit.Categories.isNotEmpty &&
        _cubit.Categories != null &&
        pagesNumberController.value.text.isNotEmpty &&
        pagesNumberController.value.text != null) {
      _cubit.postNewBook(
          image: _cubit.imageFile!,
          bookName: nameController.value.text,
          summary: summaryController.value.text,
          sellPrice: sellingPriceController.value.text,
          purchasingPrice: purchasingPriceController.value.text,
          quantity: newQuintityController.value.text,
          author: _cubit.authors,
          categories: _cubit.Categories,
          numberPage: pagesNumberController.value.text);
    }
  }

  addUtilizedBook(BuildContext context) {
    var _cubit = BlocProvider.of<AddBookCubit>(context);

    if (_cubit.imageFile != null &&
        nameController.value.text.isNotEmpty &&
        nameController.value.text != null &&
        summaryController.value.text.isNotEmpty &&
        summaryController.value.text != null &&
        borrowPriceController.value.text.isNotEmpty &&
        borrowPriceController.value.text != null &&
        purchasingPriceController.value.text.isNotEmpty &&
        purchasingPriceController.value.text != null &&
        borrowQuintityController.value.text.isNotEmpty &&
        borrowQuintityController.value.text != '0' &&
        borrowQuintityController.value.text != null &&
        _cubit.authors.isNotEmpty &&
        _cubit.authors != null &&
        _cubit.Categories.isNotEmpty &&
        _cubit.Categories != null &&
        pagesNumberController.value.text.isNotEmpty &&
        pagesNumberController.value.text != null) {
      _cubit.postUtilizedBook(
          image: _cubit.imageFile!,
          bookName: nameController.value.text,
          summary: summaryController.value.text,
          sellPrice: borrowPriceController.value.text,
          purchasingPrice: purchasingPriceController.value.text,
          quantity: borrowQuintityController.value.text,
          author: _cubit.authors,
          categories: _cubit.Categories,
          numberPage: pagesNumberController.value.text);
    }
  }
}
