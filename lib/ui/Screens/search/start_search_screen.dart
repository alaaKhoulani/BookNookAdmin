
import 'package:book_nook_admin/business_logic/cubit/all_book/all_book_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../consts/myColors.dart';
import 'search_screen.dart';

class StartSearchScreen extends StatefulWidget {
  const StartSearchScreen({Key? key}) : super(key: key);

  @override
  State<StartSearchScreen> createState() => _StartSearchScreenState();
}

class _StartSearchScreenState extends State<StartSearchScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 1, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // SearchCubit.get(context).isSearched = true;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120.0),
        child: AppBar(
          shadowColor: Colors.white,
          backgroundColor: Colors.white,
          flexibleSpace: buildSearchField(context, true),
          bottom: TabBar(
            labelColor: MyColors.myPurble,
            indicatorColor: MyColors.myPurble,
            controller: _controller,
            tabs: const [
              Tab(
                text: "Books",
              ),
              // Tab(text: "Libraries"),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: TabBarView(
            controller: _controller,
            children: [
              buildCharactersList(
                  context, AllBookCubit.get(context).searchedBook),
              // buildCharactersList(
              //     context, AllBookCubit.get(context).searchedLib),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildCharactersList(context, searchedList) {
  return SingleChildScrollView(
    child: searchedList.length == 0
        ? Container(
            child: Image.asset(
            "assets/images/book1.png",
          ))
        : Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: searchedList.length,
                itemBuilder: (ctx, index) {
                  return buildTopBook(searchedList[index]);
                },
              ),
            ],
          ),
  );
}
