import 'package:book_nook_admin/business_logic/cubit/offer/offer_cubit.dart';
import 'package:book_nook_admin/consts/constant.dart';
import 'package:book_nook_admin/consts/myColors.dart';
import 'package:book_nook_admin/data/models/Book.dart';
import 'package:book_nook_admin/data/models/offers.dart';
import 'package:book_nook_admin/services/storage/store.dart';
import 'package:book_nook_admin/ui/Screens/add%20offer/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class MyOffersScreen extends StatefulWidget {
  final int id;
  const MyOffersScreen({super.key, required this.id});

  @override
  State<MyOffersScreen> createState() => _MyOffersScreenState();
}

class _MyOffersScreenState extends State<MyOffersScreen> {
  List<Offer> offers = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<OfferCubit>(context)
        .getLibraryOffers(id: widget.id)
        .then((value) => this.offers = value);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer< OfferCubit, OfferState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: MyColors.myWhite,
            centerTitle: true,
            title: Text("My Offers",
                style: p1.copyWith(
                  color: MyColors.myBlack,
                )),
          ),
          body: _buildOfferWidget(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, 'addOfferScreen');
            },
            backgroundColor: MyColors.myPurble,
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }

  Widget _buildOfferWidget() {
    return BlocListener<OfferCubit, OfferState>(
      listener: (context, state) {
        if (state is OfferInitial) {
          _buildLoaddingListWidget();
        } else if (state is OfferGetSuccessful) {
          // Navigator.pop(context);
          this.offers = state.offers;
        } else {
          _showMyDialog(context);
        }
      },
      child: ListView.builder(
          itemCount: this.offers.length,
          itemBuilder: (context, index) {
            return Container(
                padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 5,
                      // offset: Offset(0, 0), // changes position of shadow
                    ),
                  ],
                  color: MyColors.myWhite,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Expanded(
                  child: ListTile(
                    title: Text("${offers[index].title}"),
                    subtitle: Text("    price:  ${offers[index].totalPrice}"),
                    trailing: IconButton(
                        onPressed: () async {
                          await _showMyDialogOffer(context, "name",
                              this.offers[index].books!, index);
                        },
                        icon: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: MyColors.myPurble,
                          size: 20,
                        )),
                  ),
                ));
          }),
    );
  }

  Future<void> _showMyDialogOffer(BuildContext context, String lable,
      List<BookInfo> books, int index) async {
    return showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              //ToDO:
              // title: Row(children: [
              //   Text("${books}")
              // ]),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              content: Builder(
                builder: (context) {
                  return Container(
                    height: 500,
                    width: 300,
                    child: ListView.builder(
                      // shrinkWrap: true,
                      // physics: ClampingScrollPhysics(),
                      itemCount: books.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.all(18),
                          child: ListTile(
                            title: Container(
                              child: Text("${books[index].name}"),
                            ),
                            leading: books[index].image!.isNotEmpty
                                ? FadeInImage.assetNetwork(
                                    fit: BoxFit.cover,
                                    image:
                                        ("${Store.baseURL}/${books[index].image!}"),
                                    // fit: BoxFit.cover,
                                    placeholder: "assets/images/book1.png",
                                  )
                                : Image(
                                    image:
                                        AssetImage("assets/images/book1.png")),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Close",
                      style: buttonfont.copyWith(color: MyColors.myBlack),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          //todo
                          return AddOfferScreen();
                        },
                      ));
                      // Navigator.pushNamed(context, "myOffersScreen",
                      //     arguments: this.offers[index]);
                    },
                    child: Text("Edit",
                        style: buttonfont.copyWith(
                          color: MyColors.myPurble,
                        ))),
              ],
            ));
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
          title: const Text('Failer'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                // Text('This is a demo alert dialog.'),
                Text('Some thing went wrong !!'),
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
