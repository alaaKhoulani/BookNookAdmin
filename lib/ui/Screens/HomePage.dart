import 'package:book_nook_admin/business_logic/cubit/all_book/all_book_cubit.dart';
import 'package:book_nook_admin/business_logic/cubit/profile/profile_cubit.dart';
import 'package:book_nook_admin/consts/constant.dart';
import 'package:book_nook_admin/consts/myColors.dart';
import 'package:book_nook_admin/data/models/Book.dart';
import 'package:book_nook_admin/data/repository/book_repository.dart';
import 'package:book_nook_admin/data/web_services/book_web_services.dart';
import 'package:book_nook_admin/services/storage/store.dart';
import 'package:book_nook_admin/ui/widget/CategoriesRow.dart';
import 'package:book_nook_admin/ui/widget/book_Item.dart';
import 'package:book_nook_admin/ui/widget/my_drawer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/retry.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // String _lastMessage = "last Meesage******";
  late List<BookInfo> allBook = [];
  late Future<List> books;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProfileCubit>(context).profile().then((value) => null);
    BlocProvider.of<AllBookCubit>(context)
        .getBooks()
        .then((value) => null);
  }

  Widget title(String title, double fontsize, Color color) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
      child: Text(
        title,
        textAlign: TextAlign.start,
        style: TextStyle(
            fontSize: fontsize, fontWeight: FontWeight.bold, color: color),
      ),
    );
  }

  Widget bookItem(BookInfo book) {
    // int n = index % 6;
    return Card(
        margin: EdgeInsets.all(8),
        child: Dismissible(
          key: UniqueKey(),
          background: Container(
            color: Colors.red,
            child: Icon(Icons.delete),
          ),
          direction: DismissDirection.endToStart,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.start,
              // mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    margin: EdgeInsets.fromLTRB(10, 15, 15, 15),
                    width: 90,
                    height: 130,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10), // Image border
                      child: SizedBox.fromSize(
                        size: const Size.fromRadius(100),
                        child: book.image!.isNotEmpty
                            ? FadeInImage.assetNetwork(
                                fit: BoxFit.fill,
                                image: ("${Store.baseURL}/${book.image!}"),
                                // fit: BoxFit.cover,
                                placeholder: "assets/images/loading.gif",
                              )
                            : Image(
                                image: AssetImage("assets/images/book1.png")),
                      ),
                    )),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${book.name}",
                        style: p1.copyWith(color: MyColors.myBlack),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "exist: ${book.quantity}",
                            style: p2.copyWith(
                              color: MyColors.myPurble2,
                            ),
                          ),
                          Text(
                            "salling Price:${book.sellingPrice}",
                            style: p2.copyWith(
                              color: MyColors.myPurble2,
                            ),
                          ),
                        ],
                      ),
                      // Text(
                      //   "exist: ${index * 7 + 2}      sale:${index * 6 + 6}       price: ${index * 77 + 100}",
                      //   style: TextStyle(fontSize: 15, color: MyColors.myPurble2),
                      // ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: MyColors.myPurble, //change your color here
            ),
            backgroundColor: MyColors.myWhite,
            elevation: 0,
            title: Text("My Library",
                style: p1.copyWith(
                  color: MyColors.myPurble,
                )),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'searchHomeScreen');
                  },
                  icon: Icon(Icons.search)),
              // IconButton(onPressed: () {}, icon: Icon(Icons.playlist_add_check))
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: MyColors.myPurble,
            onPressed: () {
              Store.store.remove('token');
              Navigator.pushNamed(context, "addBook");
            },
            label: Text("add book"),
          ),
          //appBar: AppBar(),
          backgroundColor: MyColors.myWhite,
          drawer: MyDrawer(),
          // body: _buildBlocWidget(),),
          body: _buildBlocWidget()),
    );
  }

  Widget _buildBlocWidget() {
    // return _buildLoaddingListWidget();
    return BlocBuilder<AllBookCubit, AllBookState>(
      builder: (context, state) {
        if (state is AllBookLoading) {
          return _buildLoaddingListWidget();
        } else if (state is AllBookSuccessful) {
          return _buildSuccessfuListWidget(state.allBooks);
        } else {
          _showMyDialog(context);
          return Container();
        }
      },
    );
  }

  Widget _buildSuccessfuListWidget(List<BookInfo> books) {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: books.length,
        itemBuilder: (context, index) {
          return _buildBookItem(books[index]);
          // return bookItem();
        },
      ),
    );
  }

  Widget _buildBookItem(BookInfo book) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "details", arguments: book);
      },
      child: Row(
        children: [
          // Container(
          //   alignment: Alignment.center,
          //   // margin: EdgeInsets.fromLTRB(10, 2, 10, 0),
          //   padding: EdgeInsets.all(5),
          //   child: Text(
          //     book.name!,
          //     style: p2.copyWith(
          //       color: MyColors.myBlack,
          //     ),
          //   ),
          // ),
          Container(
              margin: EdgeInsets.fromLTRB(10, 15, 15, 15),
              width: 90,
              height: 130,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10), // Image border
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(100),
                  child: book.image!.isNotEmpty
                      ? FadeInImage.assetNetwork(
                          fit: BoxFit.fill,
                          image: ("${Store.baseURL}/${book.image!}"),
                          // fit: BoxFit.cover,
                          placeholder: "assets/images/loading.gif",
                        )
                      : Image(image: AssetImage("assets/images/book1.png")),
                ),
              ),
              decoration: BoxDecoration(
                color: MyColors.myGrey,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 10,
                    // offset: Offset(0, 0), // changes position of shadow
                  ),
                ],
              )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Book ${book.name}",
                style: p1.copyWith(color: MyColors.myBlack),
              ),
              Text(
                "${book.state}",
                style: p1.copyWith(
                    color: book.state == "new" ? Colors.green : Colors.red),
              ),
              Text(
                "Quantity: ${book.quantity}",
                style: p2.copyWith(
                  color: MyColors.myPurble2,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                "salling Price:${book.sellingPrice}",
                style: p2.copyWith(
                  color: MyColors.myPurble2,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                "Purchasing Price: ${book.purchasingPrice}",
                style: p2.copyWith(
                  color: MyColors.myPurble2,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildLoaddingListWidget() {
    return ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
              child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Row(
                    children: [
                      Container(
                        width: 80,
                        height: 90,
                        decoration: BoxDecoration(
                            color: MyColors.myWhite,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                      ),
                      Expanded(
                        child: ListTile(
                          title: Container(
                            height: 10,
                            width: 30,
                            color: MyColors.myWhite,
                          ),
                          subtitle: Container(
                            height: 10,
                            width: 40,
                            color: MyColors.myWhite,
                          ),
                        ),
                      )
                    ],
                  )));
        });
  }

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                // Text('This is a demo alert dialog.'),
                Text('please swap to try again..'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
