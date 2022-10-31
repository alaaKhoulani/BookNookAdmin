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
        title: Text("My Adresses",
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
          Text("add an address",style: p1.copyWith(color: Colors.grey),),
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
          title: Text("Title"),
          subtitle: Text("Middan"),
          trailing: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.edit,
                color: MyColors.myPurble,
              )),
        ),
      ),
    );
  }
}
