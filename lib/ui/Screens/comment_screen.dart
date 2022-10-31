import 'package:book_nook_admin/business_logic/cubit/comment/comment_cubit.dart';
import 'package:book_nook_admin/consts/constant.dart';
import 'package:book_nook_admin/consts/myColors.dart';
import 'package:book_nook_admin/data/models/Book.dart';
import 'package:book_nook_admin/data/models/comment.dart';
import 'package:book_nook_admin/ui/widget/loaading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class CommentScreen extends StatefulWidget {
  final BookInfo book;
  const CommentScreen({super.key, required this.book});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  TextEditingController commentController = TextEditingController();
  List<Comment> comments = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<CommentCubit>(context).getBookComment(id: widget.book.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: MyColors.myBlack),
          backgroundColor: MyColors.myWhite,
          elevation: 0,
          centerTitle: true,
          title: Text("Comments",
              style: p1.copyWith(
                color: MyColors.myBlack,
              )),
        ),
        body: BlocConsumer<CommentCubit, CommentState>(
          listener: (context, state) {
            if (state is CommentPostSubmetting) {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return LoadingDialog();
                },
              );
            } else if (state is CommentPostSuccess) {
              Navigator.pop(context);
              BlocProvider.of<CommentCubit>(context)
                  .getBookComment(id: widget.book.id!);
            } else if (state is CommentFailure) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text((state.exception.toString() + '.'))));
            }
          },
          builder: (context, state) {
            // return _buildLoaddingListWidget();
            if (state is CommentInitial || state is CommentPostSubmetting || state is CommentPostSuccess) {
              return _buildLoaddingListWidget();
            } else if (state is CommentGetSuccess) {
              comments = state.comment;
              return _buildSuccessfullWidget(comments);
            } else {
              _showMyDialog(context);
              return Container();
            }
          },
        ));
  }

  Widget _buildSuccessfullWidget(List<Comment> comments) {
    return SafeArea(
      child: SizedBox(
        // height: 800,
        child: SingleChildScrollView(
          // physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              // Container(
              //   height: 5,
              // ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                    // color: MyColors.myGreen,
                    borderRadius: BorderRadius.circular(40.0)),
                child: ListTile(
                  title: TextField(
                    controller: commentController,
                    decoration: InputDecoration(
                      hintText: '   addcomment',
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        color: MyColors.myPurble,
                        onPressed: () {
                          if (commentController.value.text.isNotEmpty &&
                              commentController.value.text != null) {
                            BlocProvider.of<CommentCubit>(context).addComment(
                                comment: commentController.value.text,
                                id: widget.book.id!);
                            commentController.clear();
                          }
                        },
                        icon: const Icon(
                          Icons.send,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                  child: ListView.builder(
                    reverse: true,
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Image.asset("assets/images/book-nook.png"),
                    title: comments[index].role_id != 1
                        ? Text(
                            "${comments[index].firstName} ${comments[index].lastName}")
                        : Text("${comments[index].library}"),
                    subtitle: Text("${comments[index].comment}"),
                  );
                },
              ))
            ],
          ),
        ),
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
}
