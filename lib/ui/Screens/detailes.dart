import 'dart:developer';
import 'package:book_nook_admin/business_logic/cubit/comment/comment_cubit.dart';
import 'package:book_nook_admin/business_logic/cubit/details/details_cubit.dart';
import 'package:book_nook_admin/consts/constant.dart';
import 'package:book_nook_admin/consts/myColors.dart';
import 'package:book_nook_admin/data/models/Book.dart';
import 'package:book_nook_admin/data/models/comment.dart';
import 'package:book_nook_admin/services/storage/store.dart';
import 'package:book_nook_admin/ui/widget/MyButton.dart';
import 'package:book_nook_admin/ui/widget/loaading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:like_button/like_button.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';

class Detailes extends StatefulWidget {
  Detailes({Key? key, required this.book}) : super(key: key);
  BookInfo book;
  @override
  State<Detailes> createState() => _detalesState();
}

class _detalesState extends State<Detailes> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<DetailsCubit>(context).getBook(id: widget.book.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: TextButton(
        //   onPressed: (){},
        //   child: Text("Library",style: buttonfont.copyWith(color: MyColors.myBlack),)),
        centerTitle: true,
        elevation: 0,
        actions: [
          // TextButton(
          //     onPressed: () {},
          //     child: Text(
          //       "library",
          //       style:
          //           buttonfont.copyWith(color: MyColors.myPurble, fontSize: 20),
          //     )),
          IconButton(
            icon: Icon(
              Icons.share_rounded,
              color: MyColors.myPurble,
            ),
            onPressed: () async {
              await Share.share(
                  'http://play.google.com/stor/apps/details?id-com.instructivetech.testapp');
            },
          ),
          PopupMenuButton(
            position: PopupMenuPosition.under,
            child: Icon(
              Icons.more_vert_rounded,
              color: MyColors.myPurble,
            ),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                    child: TextButton(
                  onPressed: () {
                    Navigator.popAndPushNamed(context, 'editBook',arguments: widget.book);
                  },
                  child: Text(
                    "Edit",
                    style: p1.copyWith(color: MyColors.myBlack),
                  ),
                )),
                PopupMenuItem(
                    child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Delete",
                    style: p1.copyWith(color: Colors.red),
                  ),
                )),
              ];
            },
          )
          // IconButton(
          //     onPressed: () {

          //     },
          //     icon: Icon(
          //       Icons.more_vert_rounded,
          //       color: MyColors.myPurble,
          //     )),
        ],
        // title: Text("Detail", style: h2.copyWith(color: MyColors.myBlack)),
        backgroundColor: MyColors.myWhite,
      ),
      body:
          BlocConsumer<DetailsCubit, DetailsState>(listener: (context, state) {
        if (state is DetailsSubmitting) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return LoadingDialog();
            },
          );
        } else if (state is DetailsSuccess) {
          // Navigator.pop(context);
          widget.book = state.book;
          // Navigator.pushReplacementNamed(context, 'addAddress');
        } else if (state is DetailsFailure) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(("${state.exception}" + '.'))));
        }
      }, builder: (context, state) {
        return ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: [
              Container(
                  margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox.fromSize(
                      // size: const Size.fromRadius(100),
                      child: widget.book.image != null ||
                              widget.book.image!.isNotEmpty
                          ? FadeInImage.assetNetwork(
                              width: 100,
                              height: 300,
                              fit: BoxFit.contain,
                              image: ("${Store.baseURL}/${widget.book.image!}"),
                              // fit: BoxFit.cover,
                              placeholder: "assets/images/loading.gif",
                            )
                          : Image(image: AssetImage("assets/images/book1.png")),
                    ),
                  )),

              Center(
                child: Text(
                  "${widget.book.name}",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: MyColors.myBlack),
                ),
              ),
              Container(
                height: 30,
                width: 50,
                margin: EdgeInsets.only(top: 10, left: 120),
                child: RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemSize: 20,
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
              ),
              Center(
                  // margin: EdgeInsets.only(left: 140),
                  // height: 20,
                  child: Text(
                "num of pages : ${widget.book.numOfPage}",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: MyColors.myBlack),
              )),
              SizedBox(
                height: 20,
              ),
              Container(
                child: GridView(
                    // padding: EdgeInsets.zero,
                    padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 0,
                        crossAxisSpacing: 10,
                        childAspectRatio: 0.8),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: [
                      MyGridTileIcon(
                        child: Text(
                          "Comment",
                          style: p2.copyWith(
                              color: MyColors.myBlack, fontSize: 13),
                          textAlign: TextAlign.center,
                        ),
                        icon: Icon(
                          Icons.comment,
                          color: MyColors.myPurble,
                          size: 35,
                        ),
                        function: () => Navigator.pushNamed(context, "comment",
                            arguments: widget.book),
                      ),
                      MyGridTileIcon(
                        child: Text(
                          "Quotes",
                          style: p2.copyWith(
                              color: MyColors.myBlack, fontSize: 13),
                          textAlign: TextAlign.center,
                        ),
                        icon: Icon(
                          Icons.format_quote_sharp,
                          color: MyColors.myPurble,
                          size: 35,
                        ),
                        function: () {
                          Navigator.pushNamed(context, "allQuotes",
                              arguments: widget.book.id);
                        },
                      ),
                      // MySave(
                      //   child: Text(
                      //     "Save",
                      //     style: p2.copyWith(
                      //         color: MyColors.myBlack, fontSize: 13),
                      //     textAlign: TextAlign.center,
                      //   ),
                      //   // icon: ,
                      //   icon: Icons.bookmark_rounded,

                      //   function: () {},
                      // ),
                    ]),
              ),
              Container(
                  child: GridView(
                // padding: EdgeInsets.zero,
                padding: EdgeInsets.fromLTRB(20, 0, 20, 5),
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.7),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: [
                  myGridTile(
                    child: Text(
                      "Purchasing price",
                      style: p2.copyWith(color: MyColors.myBlack, fontSize: 13),
                      textAlign: TextAlign.center,
                    ),
                    text: Text(
                      "${widget.book.purchasingPrice}",
                      style: p2.copyWith(
                          color: MyColors.myPurble,
                          fontWeight: FontWeight.bold),
                    ),
                    function: () {},
                  ),
                  myGridTile(
                    child: Text(
                      "Selling price",
                      style: p2.copyWith(color: MyColors.myBlack, fontSize: 13),
                      textAlign: TextAlign.center,
                    ),
                    text: Text(
                      "${widget.book.sellingPrice}",
                      style: p2.copyWith(
                          color: MyColors.myPurble,
                          fontWeight: FontWeight.bold),
                    ),
                    function: () {},
                  ),
                  myGridTile(
                    child: Text(
                      "State",
                      style: p2.copyWith(color: MyColors.myBlack, fontSize: 13),
                      textAlign: TextAlign.center,
                    ),
                    text: Text(
                      "${widget.book.state}",
                      style: p2.copyWith(
                          color: MyColors.myPurble,
                          fontWeight: FontWeight.bold),
                    ),
                    function: () {},
                  ),
                  myGridTile(
                    child: Text(
                      "Quanitiy",
                      style: p2.copyWith(
                        color: MyColors.myBlack,
                        fontSize: 13,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    text: Text(
                      "${widget.book.quantity}",
                      style: p2.copyWith(
                          color: MyColors.myPurble,
                          fontWeight: FontWeight.bold),
                    ),
                    function: () {},
                  ),
                ],
              )),
              Container(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.fromLTRB(20, 40, 20, 5),
                child: Text(
                  "Auothers :",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black38),
                ),
              ),
              Container(
                  height: 100,
                  child: GridView.builder(
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 5,
                              crossAxisCount: 3,
                              childAspectRatio: 3,
                              crossAxisSpacing: 10),
                      scrollDirection: Axis.vertical,
                      itemCount: widget.book.authors!.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(5),
                          // margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: MyColors.myGreen,
                            // border: Border.all(color: MyColors.myGrey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          // offset: Offset(0, 0), // changes position of shadow

                          child: Text(
                            "${widget.book.authors![index].name}",
                            style: p2.copyWith(color: Colors.black54),
                          ),
                        );
                      })),
              Container(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                child: Text(
                  "Categories :",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black38),
                ),
              ),
              Container(
                  height: 100,
                  child: GridView.builder(
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 5,
                              crossAxisCount: 3,
                              childAspectRatio: 3,
                              crossAxisSpacing: 10),
                      scrollDirection: Axis.vertical,
                      itemCount: widget.book.categories!.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(5),
                          // margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: MyColors.myGreen,
                            // border: Border.all(color: MyColors.myGrey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          // offset: Offset(0, 0), // changes position of shadow

                          child: Text(
                            "${widget.book.categories![index].name}",
                            style: p2.copyWith(color: Colors.black54),
                          ),
                        );
                      })),

              Container(
                margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
                child: Text(
                  "Summary :",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black38),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                margin: EdgeInsets.only(left: 10),
                child: Text(widget.book.summary!,
                    style: p2.copyWith(
                      color: MyColors.myBlack,
                    )
                    // 'he secret power of the universe how to use the law of attraction fof manifestation '
                    // "Have you ever noticed that this world was made to complete perfection ?There is areason and use for every single"
                    // "thing that you can see,taste,toush,hear and feel on this planet"
                    // ".Everything works and fits together in perfect harmony ."
                    // "From the functions and shaoes of our bodies Are you eager to learn about the Law of"
                    // " Attraction? In this the Law of Attraction summary and book review, we will go into the"
                    // " book’s basic lessons"
                    ),
              ),
              SizedBox(
                height: 60,
              )
              // Container(
              //   margin: EdgeInsets.fromLTRB(40, 10, 40, 10),
              //   child: MyButton(
              //       child: Text(
              //         "Add to card",
              //         style: buttonfont.copyWith(color: MyColors.myWhite),
              //       ),
              //       fun: () {},
              //       context: context),
              // ),
            ]);
      }),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: FloatingActionButton.extended(
      //   backgroundColor: MyColors.myPurble,
      //   onPressed: () {},
      //   label: Text(
      //     "Add to card",
      //     style: buttonfont.copyWith(color: MyColors.myWhite),
      //   ),
      // ),
    );
  }

  Widget MySave(
      {required Widget child,
      required VoidCallback function,
      required IconData icon}) {
    return GridTile(
        child: Column(
      children: [
        Container(
          height: 60,
          // padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                // blurRadius: 10,
                // offset: Offset(0, 0), // changes position of shadow
              ),
            ],
            color: MyColors.myGrey,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: LikeButton(
            likeBuilder: (bool isLiked) {
              return Icon(
                icon,
                color: isLiked ? MyColors.myPurble : Colors.grey,
                size: 30,
              );
            },
          ),
        ),
        SizedBox(
          height: 15,
        ),
        child
      ],
    ));
  }

  Widget MyGridTileIcon(
      {required Widget child,
      required VoidCallback function,
      required Icon icon}) {
    return GestureDetector(
      onTap: function,
      child: GridTile(
        child: Column(
          children: [
            Container(
              height: 60,
              // padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                  ),
                ],
                color: MyColors.myGrey,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: icon,
            ),
            SizedBox(
              height: 15,
            ),
            child
          ],
        ),

        //  footer: Container(
        //   height: 30,
        //   decoration: BoxDecoration(
        //     color: MyColors.myBlack.withOpacity(0.5),
        //     borderRadius: BorderRadius.only(
        //       bottomLeft:Radius.circular(20),
        //       bottomRight: Radius.circular(20)
        //     )
        //   ),
        //   child: child,
        //   ),
      ),
    );
  }

  Widget myGridTile(
      {required Widget child,
      required VoidCallback function,
      required Text text}) {
    return GestureDetector(
      onTap: function,
      child: GridTile(
        child: Column(
          children: [
            Container(
              height: 60,
              // padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    // blurRadius: 10,
                    // offset: Offset(0, 0), // changes position of shadow
                  ),
                ],
                color: MyColors.myGrey,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: text,
            ),
            SizedBox(
              height: 15,
            ),
            child
          ],
        ),
      ),
    );
  }
}
