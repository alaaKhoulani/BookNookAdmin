import 'package:book_nook_admin/business_logic/cubit/quotes/quotes_cubit.dart';
import 'package:book_nook_admin/consts/constant.dart';
import 'package:book_nook_admin/consts/myColors.dart';
import 'package:book_nook_admin/data/models/quote.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widget/longWavyContainer.dart';

class page extends StatefulWidget {
  @override
  _pageState createState() => _pageState();
}

class _pageState extends State<page> {
  late List<Quote> _quotes;
  late Quote quote;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("object");
    print("Started");
    BlocProvider.of<QuotesCubit>(context).getRandomQuote().then((value) => quote=value);
  }
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    screenHeight = screenSize.height;
    screenWidth = screenSize.width;


    return Scaffold(
      backgroundColor: MyColors.myWhite,
      body: SafeArea(
        // child: SingleChildScrollView(

          child: Stack(
              
              alignment:Alignment.bottomLeft ,
              children:  <Widget>[

                Container(

                 height: screenHeight,

                   child: LongWaveContainer()
                ),

                Positioned(
                  top: 150,
                  left: 40,
                   child: BlocBuilder<QuotesCubit, QuotesState>(
                builder: (context, state) {
                  if (state is QuotesLoaded) {
                    return AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          quote.quote!,
                          textStyle: const TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          speed: const Duration(milliseconds: 200),
                        ),
                      ],
                      totalRepeatCount: 6,
                      pause: const Duration(milliseconds: 1000),
                      displayFullTextOnTap: true,
                      stopPauseOnTap: true,
                    );
                  } else {
                    return Container();
                  }
                  ;
                },
           ),
                ),
                ListTile(
                 // leading: Icon(Icons.logout, color: MyColors.myGreen),
                  title: Text("Let's get started",style: TextStyle(color: MyColors.myBlack,fontWeight:FontWeight.bold
                  )),
                  trailing: IconButton(
                    icon: Icon(Icons.logout,
                        color: MyColors.myBlack),
                    onPressed: () {
                      Navigator.of(context).pushNamed("myhome");
                     // Get.to(()=>home());
                    },
                  ),
                ),
//                 Positioned(
//                   top: 670,
//                   right: 40,
//                   child:
//                   Container(
//
//                     width:100,
//                     height:60,
//                     // padding:EdgeInsets .all(5.0),
//                     //   margin: EdgeInsets.only(top: 5,left: 100,right: 100),
//                     decoration: BoxDecoration(
//                         color: MyColors.myPink,
// borderRadius: BorderRadius.circular(20),
//                     ),
//                     // child:Row(
//                     //   mainAxisAlignment: MainAxisAlignment.center,
//                     //   children:<Widget> [
//
//                     //    Text('enter',
//                     //  style: TextStyle(fontSize: 20),
//                     //   ),
//                     // NavigationBar(destinations: home(),)
//                     child:
//
//                     InkWell(child: GridTile(
//                       child:Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children:<Widget> [
//
//                             Text('enter',
//                               style: TextStyle(fontSize: 20),
//                             ),
//                           ] ),
//                       //  footer: Container(color: Colors.yellow, child: Text(
//                       //  'one', style: TextStyle(color: Colors.white70),
//                     ), onTap: () {
//                       Navigator.of(context).pushNamed("myhome");
//                     },), ), ),
//





              ])
      ),


    );

  }
}
