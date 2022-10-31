import 'package:book_nook_admin/business_logic/cubit/order/order_cubit.dart';
import 'package:book_nook_admin/consts/constant.dart';
import 'package:book_nook_admin/consts/myColors.dart';
import 'package:book_nook_admin/data/models/order.dart';
import 'package:book_nook_admin/data/models/recieve_order.dart';
import 'package:book_nook_admin/data/repository/order_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class MyOrder extends StatefulWidget {
  const MyOrder({Key? key}) : super(key: key);

  @override
  State<MyOrder> createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  List<RecieveOrder> orders = [];

  @override
  TextEditingController starConroller = TextEditingController();
  void initState() {
    // TODO: implement initState
    super.initState();
    print('myorder');
    BlocProvider.of<OrderCubit>(context).getOrders().then((value) => null);
    // OrderRepository().getOrders().then((value) => this.orders = value);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "My order",
          style: TextStyle(color: MyColors.myPurble),
        ),
        backgroundColor: MyColors.myWhite,
      ),
      body: BlocConsumer<OrderCubit, OrderState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is OrderGetListInitial ||
              state is OrderChangeStateInitial) {
            return _buildLoaddingListWidget();
          }
          this.orders = (state as OrderGetListSuccessful).orders;
          return ListView.builder(

              // physics: ClampingScrollPhysics(),
              // shrinkWrap: true,
              itemCount: this.orders.length,
              // reverse: true,
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
                      color: this.orders[index].status == 'Delivered'
                          ? MyColors.myGreen
                          : this.orders[index].status == 'Canceled'
                              ? Colors.red[10]
                              : MyColors.myWhite,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Expanded(
                      child: ListTile(
                        title: Text("Order  ${index + 1}"),
                        subtitle: Text(
                            " from:  ${orders[index].user!.firstName} ${orders[index].user!.lastName}"),
                        trailing: IconButton(
                            onPressed: () async {
                              await _showMyDialog(
                                  context, this.orders[index], index);
                            },
                            icon: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: MyColors.myPurble,
                              size: 20,
                            )),
                      ),
                    ));
              });
        },
      ),
    );
  }

  getStatusColor(String state) {
    if (state == "Processing")
      return Colors.black54;
    else if (state == "Delivery in progress")
      return MyColors.myPurble;
    else if (state == "Delivered")
      return Colors.green;
    else
      return Colors.red;
  }

  List<PopupMenuEntry<dynamic>> stateOfOrder(
      {required String state,
      required BuildContext context,
      required RecieveOrder order}) {
    if (state == "Processing") {
      return [
        PopupMenuItem(
            child: TextButton(
          onPressed: () async {
            await BlocProvider.of<OrderCubit>(context)
                .orderConfirmed(id: order.id!);
          },
          child: Text(
            "Delivery in progress",
            style: p1.copyWith(color: MyColors.myPurble),
          ),
        )),
        PopupMenuItem(
            child: TextButton(
          onPressed: () async {
            await BlocProvider.of<OrderCubit>(context)
                .orderDelivered(id: order.id!);
          },
          child: Text(
            "Delivered",
            style: p1.copyWith(color: Colors.green),
          ),
        )),
        PopupMenuItem(
            child: TextButton(
          onPressed: () async {
            await BlocProvider.of<OrderCubit>(context)
                .orderCanceled(id: order.id!);
          },
          child: Text(
            "Canceled",
            style: p1.copyWith(color: Colors.red),
          ),
        )),
      ];
    } else if (state == "Delivery in progress") {
      return [
        PopupMenuItem(
            child: TextButton(
          onPressed: () async {
            await BlocProvider.of<OrderCubit>(context)
                .orderDelivered(id: order.id!);
          },
          child: Text(
            "Delivered",
            style: p1.copyWith(color: Colors.green),
          ),
        )),
        PopupMenuItem(
            child: TextButton(
          onPressed: () async {
            await BlocProvider.of<OrderCubit>(context)
                .orderCanceled(id: order.id!);
          },
          child: Text(
            "Canceled",
            style: p1.copyWith(color: Colors.red),
          ),
        )),
      ];
    } else
      return [];
  }

  Future<void> _showMyDialog(
      BuildContext context, RecieveOrder order, int index) async {
    return showDialog(
        context: context,
        builder: (_) => AlertDialog(
              //ToDO:
              title: Column(
                children: [
                  ListTile(
                      title: Text("Order ${index + 1}"),
                      subtitle: Text(order.totalPrice.toString()),
                      trailing: PopupMenuButton(
                        position: PopupMenuPosition.under,
                        child: Text(
                          order.status!,
                          style: p2.copyWith(
                            color: getStatusColor(order.status!),
                          ),
                        ),
                        itemBuilder: (context) {
                          return stateOfOrder(
                              state: order.status!,
                              context: context,
                              order: order);
                        },
                      )),
                  ListTile(
                      isThreeLine: true,
                      title: Text(
                          "From ${order.user!.firstName} ${order.user!.firstName}"),
                      subtitle: Text(
                          "${order.address!.area!} - ${order.address!.street!} - ${order.address!.near!} - floor:${order.address!.floor!}")),
                ],
              ),
              // Row(children: [
              //
              // ]),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              content: Builder(
                builder: (context) {
                  return Container(
                    height: 500,
                    width: 300,
                    child: Column(
                      children: [
                        ListView.separated(
                          shrinkWrap: true,
                          // physics: ClampingScrollPhysics(),
                          itemCount: order.orders!.length,
                          separatorBuilder: (context, index) {
                            return Divider(
                              height: 1,
                              color: MyColors.myGrey,
                            );
                          },
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.all(18),
                              child: ListTile(
                                subtitle:
                                    order.orders![index].book!.name != null
                                        ? Text("Book")
                                        : Text("Offer"),
                                title: Container(
                                  child: order.orders![index].book!.name != null
                                      ? Text(order.orders![index].book!.name
                                          .toString())
                                      : Text(order.orders![index].offer!.title
                                          .toString()),
                                ),
                                trailing:
                                    Text("${order.orders![index].quantity}"),

                                // leading: Image.asset("assets/images/book2.png"),
                              ),
                            );
                          },
                        ),
                      ],
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
                    onPressed: () {},
                    child: Text("",
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
                        // width: 80,
                        height: 90,
                        decoration: BoxDecoration(
                            color: MyColors.myWhite,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                      ),
                      // Expanded(
                      //   child: ListTile(
                      //     title: Container(
                      //       height: 10,
                      //       width: 30,
                      //       color: MyColors.myWhite,
                      //     ),
                      //     subtitle: Container(
                      //       height: 10,
                      //       width: 40,
                      //       color: MyColors.myWhite,
                      //     ),
                      //   ),
                      // )
                    ],
                  )));
        });
  }
}
