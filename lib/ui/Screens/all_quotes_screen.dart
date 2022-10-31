import 'package:book_nook_admin/business_logic/cubit/quotes/quotes_cubit.dart';
import 'package:book_nook_admin/consts/constant.dart';
import 'package:book_nook_admin/consts/myColors.dart';
import 'package:book_nook_admin/data/models/Book.dart';
import 'package:book_nook_admin/data/models/quote.dart';
import 'package:book_nook_admin/ui/widget/MyButton.dart';
import 'package:book_nook_admin/ui/widget/loaading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class AllQuotes extends StatefulWidget {
  AllQuotes({Key? key, required this.id}) : super(key: key);
  final int id;
  @override
  State<AllQuotes> createState() => _userinfoState();
}

class _userinfoState extends State<AllQuotes> {
  List<Quote> quotes = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<QuotesCubit>(context)
        .getBookQuotes(id: widget.id)
        .then((value) => null);
  }

  TextEditingController quoteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var _cubit = BlocProvider.of<QuotesCubit>(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Quotes",
              style: h2.copyWith(
                color: MyColors.myBlack,
              )),
          elevation: 0,
          backgroundColor: MyColors.myWhite,
        ),
        body: BlocConsumer<QuotesCubit, QuotesState>(
          listener: (context, state) {
            if (state is QuotesPostSubmetting) {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return LoadingDialog();
                },
              );
            } else if (state is QuotesPostSuccess) {
              Navigator.pop(context);
              BlocProvider.of<QuotesCubit>(context)
                  .getBookQuotes(id: widget.id);
            } else if (state is QuotesFailure) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text((state.exception.toString() + '.'))));
            }
          },
          builder: (context, state) {
            if (state is QuotesInitial ||
                state is QuotesPostSubmetting ||
                state is QuotesPostSuccess) {
              return _buildLoaddingListWidget();
            } else if (state is QuotesSuccess) {
              this.quotes = state.quotes;
              return _buildSuccessWidget(context);
            } else {
              _showMyDialog(context);
              return Container();
            }
          },
        ));
  }

  Widget _buildSuccessWidget(BuildContext context) {
    var _cubit = BlocProvider.of<QuotesCubit>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: TextField(
                    controller: quoteController,
                    decoration: InputDecoration(
                        hintText: "Add Quote",
                        hintStyle: p2.copyWith(color: MyColors.myBlack),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none),
                    autofocus: false,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    if (quoteController.value.text.isNotEmpty &&
                        quoteController.value.text != null) {
                      await _cubit.addQuote(
                          quote: quoteController.value.text, id: widget.id);
                      quoteController.clear();
                      await _cubit.getBookQuotes(id: widget.id);
                    }
                  },
                  icon: Icon(
                    Icons.send,
                    color: MyColors.myPurble,
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: ListView.builder(
              reverse: true,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
                itemCount: quotes.length,
                itemBuilder: (context, index) {
                  var _cubit = BlocProvider.of<QuotesCubit>(context);
                  return _quote(
                      // image: quotes[index].image!,
                      name: quotes[index].role_id != 1
                          ? "${quotes[index].firstName} ${quotes[index].firstName}"
                          : "${quotes[index].library}",
                      quote: "${quotes[index].quote}");
                }),
          ),
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
          title: const Text('Failer'),
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

  Widget _quote(
      {required String name, required String quote}) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      // height: 160,
      // width: 300,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            // offset: Offset(0, 0), // changes position of shadow
          ),
        ],
        color: MyColors.myWhite,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.all(5),
                child: CircleAvatar(
                  backgroundColor: MyColors.myGreen,
                  child: Text('DJ'),
                ),
              ),
              Container(
                  margin: EdgeInsets.all(5),
                  child: Text(name,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.black54,
                      ))),
            ],
          ),
          Container(
              padding: EdgeInsets.all(10),
              child: Text(
                quote,
              ))
        ],
      ),
    );
  }
}
