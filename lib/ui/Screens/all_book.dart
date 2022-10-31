
import 'package:book_nook_admin/data/models/Book.dart';
import 'package:flutter/material.dart';

import '../../../consts/constant.dart';
import '../../../consts/myColors.dart';

class AllBook extends StatefulWidget {
  const AllBook({ Key? key }) : super(key: key);

  @override
  State<AllBook> createState() => _AllBookState();
}

class _AllBookState extends State<AllBook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: MyColors.myPurble, //change your color here
        ),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.search))
        ],
        toolbarHeight: 70,
        elevation: 0,
        title: Text("Category name",style:p1.copyWith(color: MyColors.myPurble),),
        backgroundColor: MyColors.myWhite,
      ),
      //backgroundColor: MyColors().test4,
      body: Container(
        //margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              // SearchBox(),
              GridView.builder(
                padding: EdgeInsets.all(10),
                physics:NeverScrollableScrollPhysics() ,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 7,
                  crossAxisSpacing: 7,
                  childAspectRatio: 0.6
                  ),
                  itemCount: 50,
                 itemBuilder: (context,index){
                     return _bookItem(book: Book("name", "description",index), index: index%6);
                 }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bookItem({required Book book,required int index}){
    
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Container(
              margin: EdgeInsets.fromLTRB(5, 5, 10, 5),
              height: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10), // Image border
                child: SizedBox.fromSize(
                  size: Size.fromRadius(100),
                  child: Image(
                      image: AssetImage("assets/images/cover$index.jpg"),
                      fit: BoxFit.cover),
                ),
              ),
              decoration: BoxDecoration(
                // color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
              )),
          Container(
            alignment: Alignment.center,
            // margin: EdgeInsets.fromLTRB(10, 2, 10, 0),
            padding: EdgeInsets.all(5),
            child: Text(
              book.name,
              style: p2.copyWith(
                color: MyColors.myBlack,
              ),
            ),
          ),
        ],
      ),
    );
  }
}