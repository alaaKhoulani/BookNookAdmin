
import 'package:book_nook_admin/consts/constant.dart';
import 'package:book_nook_admin/consts/myColors.dart';
import 'package:flutter/material.dart';


class BuyBook extends StatefulWidget {
  const BuyBook({Key? key}) : super(key: key);

  @override
  State<BuyBook> createState() => _orderbookState();
}

class _orderbookState extends State<BuyBook> {
  int count = 0;
  int price=200;
 void _priceincrementcount() {
    setState(() {

      count++;
      price++;
    });
  }
   void _pricedecrementcount() {
    setState(() {
       if(count==0){
        return;


      }
    price--;
      count--;
    });
  }
  void _incrementcount() {
    setState(() {

      count++;
    });
  }

  void _decrementcount() {
    setState(() {
      if(count==0){
        return;


      }
      count--;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Center(child: Text(
        "Order Book", style: TextStyle(color: Colors.black54),)),
    backgroundColor: MyColors.myPurble,
    ),
        floatingActionButtonLocation : FloatingActionButtonLocation.centerFloat,
    floatingActionButton: FloatingActionButton.extended(
      backgroundColor: MyColors.myPurble,
      onPressed: () {  },

      label:Center(

        child:
        Row(
          children: [

                Text("Add to shopping cart   "),
               

              Icon( Icons.add_shopping_cart) ,


   ] ),
        /*decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 10,
              // offset: Offset(0, 0), // changes position of shadow
            ),
          ],

          color: MyColors.myWhite,
          borderRadius: BorderRadius.circular(30),
        ),*/
      ) ,

    ),

    body: ListView(
    children: [
    Container(
    height: 200,
    width: 200,
    margin: EdgeInsets .only(top: 30,left: 10),
    child: Image.asset("assets/books/the law.jpg"),
    ),
     Container(
        padding: EdgeInsets .only(top: 10,left: 20,right: 20),
        margin: EdgeInsets .only(top: 20,left: 60,right: 60),

        height: 70,
        width: 70,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 10,
              // offset: Offset(0, 0), // changes position of shadow
            ),
          ],

          color: MyColors.myWhite,
          borderRadius: BorderRadius.circular(30),
        ),
        child:
        Row(

          children: [

            Text("Book quantity",  style: p2.copyWith(color: MyColors.myBlack,fontSize: 13)),
            Container(
              margin: EdgeInsets .only(left: 20,bottom: 5),
              height: 70,
              width: 50,
                child:IconButton(
                  icon:Icon(Icons.add,color: Colors.black),
                  onPressed: (){
                    _incrementcount();
                  },
                ),
              ),
            Text("$count"),
        Container(
           margin: EdgeInsets .only(left: 10,bottom: 10),
          height: 70,
          width: 50,
          child:
        IconButton(
          icon:Icon(Icons.minimize,color: Colors.black),
          onPressed: (){
            _decrementcount();
          },
        ),






        ),
          ],


        ),
      ),
      Container(
        padding: EdgeInsets .only(top: 5,left: 20,right: 20),
        margin: EdgeInsets .only(top: 20,left: 60,right: 60),

        height: 70,
        width: 70,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 10,
              // offset: Offset(0, 0), // changes position of shadow
            ),
          ],

          color: MyColors.myWhite,
          borderRadius: BorderRadius.circular(30),
        ),
        child:
        Row(

          children: [

            Text("price"),
            Container(
              margin: EdgeInsets .only(left: 20,bottom: 5),
              height: 70,
              width: 50,
                child:IconButton(
                  icon:Icon(Icons.add,color: Colors.black),
                  onPressed: (){
                    _priceincrementcount();
                  },
                ),
              ),
            Text("$price"),
        Container(
           margin: EdgeInsets .only(left: 10,bottom: 10),
          height: 70,
          width: 50,
          child:
        IconButton(
          icon:Icon(Icons.minimize,color: Colors.black),
          onPressed: (){
            _pricedecrementcount();
          },
        ),






        ),
          ],


        ),
      ),
      Container(
        padding: EdgeInsets .only(top: 5,left: 20,right: 20),
        margin: EdgeInsets .only(top: 20,left: 60,right: 60),

        height: 70,
        width: 70,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 10,
              // offset: Offset(0, 0), // changes position of shadow
            ),
          ],

          color: MyColors.myWhite,
          borderRadius: BorderRadius.circular(30),
        ),
        child:
        Row(

          children: [

            Text("quantity"),
            Container(
              margin: EdgeInsets .only(left: 20,bottom: 5),
              height: 70,
              width: 50,
              child:IconButton(
                icon:Icon(Icons.add,color: Colors.black),
                onPressed: (){
                  _incrementcount();
                },
              ),
            ),
            Text("$count"),
            Container(
              margin: EdgeInsets .only(left: 10,bottom: 10),
              height: 70,
              width: 50,
              child:
              IconButton(
                icon:Icon(Icons.minimize,color: Colors.black),
                onPressed: (){
                  _decrementcount();
                },
              ),

            ),
          ],
        ),
      ),
     /* Container(
          padding: EdgeInsets .only(top: 50,left: 20,right: 20),
          margin: EdgeInsets .only(top: 100,left: 60,right: 60),

          height: 70,
          width: 70,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 10,
                // offset: Offset(0, 0), // changes position of shadow
              ),
            ],

            color: MyColors.myWhite,
            borderRadius: BorderRadius.circular(30),
          ),
      ),

      */
    ]),
    );
  }
}
