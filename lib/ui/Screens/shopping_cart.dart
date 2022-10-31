import 'package:book_nook_admin/consts/constant.dart';
import 'package:flutter/material.dart';

import '../../consts/myColors.dart';

class MyAddresses extends StatelessWidget {
  const MyAddresses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: MyColors.myPurble, //change your color here
        ),
        title: Text("Shopping cart",
            style: p1.copyWith(
              color: MyColors.myPurble,
            )),
        elevation: 0,
        backgroundColor: MyColors.myWhite,
      ),
      body: SafeArea(
          child: ListView(

        children: [
          add(),
          _myCard(),
          _myCard(),
          _myCard(),
        ],
      )),
    );
  }

  Widget add() {
    return TextButton(
      onPressed: () {
        
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 20,),
          IconButton(onPressed: (){}, icon: Icon(Icons.add,color: MyColors.myPurble,)),
          // SizedBox(width: 20,),
          Text("add Book",style: p1.copyWith(color: Colors.grey),),
        ],
      ),
    );
  }

  Widget _myCard() {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Card(
        color: MyColors.myGrey,
        child: ListTile(
          title: Text("Book name"),
          subtitle: Row(
            children: [
              Text("Quantity: 5"),
              Text("Price: 5000"),
            ],
          ),
          trailing: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.delete,
                color: MyColors.myPurble,
              )),
        ),
      ),
    );
  }
}
