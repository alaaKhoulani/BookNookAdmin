import 'dart:io';
import 'dart:math';

import 'package:book_nook_admin/business_logic/cubit/add_book/add_book_cubit.dart';
import 'package:book_nook_admin/business_logic/cubit/register_cubit/register_cubit.dart';
import 'package:book_nook_admin/consts/constant.dart';
import 'package:book_nook_admin/consts/myColors.dart';
import 'package:book_nook_admin/data/models/Book.dart';
import 'package:book_nook_admin/services/storage/store.dart';
import 'package:book_nook_admin/services/validate/validation.dart';
import 'package:book_nook_admin/ui/widget/MyButton.dart';
import 'package:book_nook_admin/ui/widget/inputCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditBook extends StatefulWidget {
  final BookInfo book;
  EditBook({Key? key, required this.book}) : super(key: key);

  @override
  State<EditBook> createState() => _EditBookState();
}

class _EditBookState extends State<EditBook> {
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
  TextEditingController categoryController = new TextEditingController();

  TextEditingController quintityController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var cubit = BlocProvider.of<AddBookCubit>(context);
    // cubit.Categories = widget.book.categories;
    widget.book.categories!.forEach((element) {
      cubit.Categories.add(element.name!);
    });
    widget.book.authors!.forEach((element) {
      cubit.authors.add(element.name!);
    });
  }

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
    // BlocProvider.of<EditBookCubit>(context).setImage(File(image.path));
  }

  //from camera
  _pickimagecamera(BuildContext context) async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
    ); //pick image from camera
    if (image == null) {
      return;
    }
    // BlocProvider.of<AddBookCubit>(context).setImage(File(image.path));
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
    var _cubit = BlocProvider.of<AddBookCubit>(context);

    var screenSize = MediaQuery.of(context).size;
    var screenHeight = screenSize.height;
    var screenWidth = screenSize.width;
    var pickedimage;
    // var _cubit = BlocProvider.of<AddBookCubit>(context);
    // nameController.text = widget.book.name!;
    // summaryController.text = widget.book.summary!;
    // purchasingPriceController.text = widget.book.purchasingPrice!.toString();
    // sellingPriceController.text = widget.book.sellingPrice!.toString();
    // quintityController.text = widget.book.quantity.toString();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70,
        elevation: 0,
        title: Text("Edit Book"),
        backgroundColor: MyColors.myPurble,
      ),
      body: BlocConsumer<AddBookCubit, AddBookState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _cubit.imageFile != null
                      ? SizedBox(
                          child: CircleAvatar(
                              radius: 50,
                              child: _cubit.imageFile == null
                                  ? Container()
                                  : Image.file(_cubit.imageFile!)),
                        )
                      : widget.book.image != null
                          ? ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(10), // Image border
                              child: SizedBox.fromSize(
                                size: Size.fromRadius(60),
                                child: Image(
                                    image: NetworkImage(
                                        "${Store.baseURL}/${widget.book.image}"),
                                    fit: BoxFit.cover),
                              ),
                            )
                          : SizedBox(
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
                  feild(
                      nameController,
                      "Name",
                      32,
                      Validation.validateNumericField,
                      context,
                      widget.book.name!),
                  feild(
                      summaryController,
                      "summary",
                      10,
                      Validation.validateNumericField,
                      context,
                      widget.book.summary!),
                  feild(
                      purchasingPriceController,
                      "Purchasing Price",
                      25,
                      Validation.validateNumericField,
                      context,
                      widget.book.purchasingPrice!.toString()),
                  feild(
                      sellingPriceController,
                      "Selling Price",
                      51,
                      Validation.validateNumericField,
                      context,
                      widget.book.sellingPrice!.toString()),
                  feild(
                      quintityController,
                      "Quantity",
                      30,
                      Validation.validateNumericField,
                      context,
                      widget.book.quantity.toString()),
                  feild(
                      authorcontroller,
                      "Authors",
                      36,
                      Validation.validateNumericField,
                      context,
                      widget.book.authors!.last.name!),
                  Container(
                    // height: 200,
                    child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 2),
                        itemCount: widget.book.authors!.length,
                        itemBuilder: (context, index) {
                          return Container(
                            // height: 50,
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(left: 20),
                            decoration: BoxDecoration(
                              color: MyColors.myGreen,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Row(
                              children: [
                                Text(widget.book.authors![index].name!,
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
                  feild(
                      categoryController,
                      "Category",
                      27,
                      Validation.validateNumericField,
                      context,
                      widget.book.categories!.last.name!),
                  Container(
                    // height: 200,
                    child: GridView.builder(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 2),
                        itemCount: widget.book.categories!.length,
                        itemBuilder: (context, index) {
                          return Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(left: 20),
                            // height: 200,
                            decoration: BoxDecoration(
                              color: MyColors.myGreen,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Row(
                              children: [
                                Text(widget.book.categories![index].name!,
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
                  // Divider(
                  //   height: 20,
                  //   thickness: 0,
                  //   color: MyColors.myBlack,
                  // ),
                  // Text(
                  //   "book for borrow:",
                  //   style: p1,
                  // ),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //         child: InputCard(
                  //             name: "Quantity",
                  //             controller: borrowQuintityController,
                  //             vlaidate: Validation.validateNumericField)),
                  //     SizedBox(
                  //       width: 20,
                  //     ),
                  //     Expanded(
                  //         child: InputCard(
                  //             name: "price",
                  //             controller: borrowPriceController,
                  //             vlaidate: Validation.validateNumericField)),
                  //   ],
                  // ),
                  MyButton(
                      child: Text("Done",
                          style: buttonfont.copyWith(
                            color: MyColors.myWhite,
                          )),
                      fun: () {},
                      context: context),
                ],
              ),
            ),
          );
        },
      ),
    );
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
}
