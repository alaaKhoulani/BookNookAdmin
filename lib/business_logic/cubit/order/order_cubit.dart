import 'package:bloc/bloc.dart';
import 'package:book_nook_admin/data/models/order.dart';
import 'package:book_nook_admin/data/models/pair.dart';
import 'package:book_nook_admin/data/models/recieve_order.dart';
import 'package:book_nook_admin/data/repository/order_repository.dart';
import 'package:book_nook_admin/data/web_services/order_web_services.dart';
import 'package:meta/meta.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());
  OrderRepository _orderRepository = OrderRepository();
  List<RecieveOrder> ordersList = [];
  List<MyPair> myPair = [];
  void add(MyPair myPair) {
    this.myPair.add(myPair);
    emit(OrderAddToList(this.myPair));
  }

  void remove(MyPair myPair) {
    List<MyPair> _temp = this.myPair;
    _temp.remove(myPair);
    this.myPair = _temp;
    emit(OrderRemoveFromList(this.myPair));
  }

  Future<void> postOrder() async {
    emit(OrderInitial());
    int totalPrice = 0;
    Order order = Order();
    order.orderes = [];
    for (int i = 0; i < myPair.length; i++) {
      order.orderes!.add(myPair[i].orders);
      if (myPair[i].orders.type == "offer") {
        totalPrice += myPair[i].offer!.totalPrice! * myPair[i].orders.quantity!;
      } else {
        totalPrice +=
            myPair[i].orders.quantity! * myPair[i].book!.sellingPrice!;
      }
    }
    order.totalPrice = totalPrice;

    order.addressId = 1;
    order.libraryId = myPair[0].book == null
        ? myPair[0].offer!.libraryId
        : myPair[0].book!.library!.id;

    await OrderWebServices().PostOrder(order);
    emit(OrderPostSuccessful());
    return;
  }

  Future<void> getOrders() async {
    emit(OrderGetListInitial());
    this.ordersList = await _orderRepository.getOrders();
    emit(OrderGetListSuccessful(this.ordersList));
  }

  Future<void> orderConfirmed({required int id}) async {
    emit(OrderChangeStateInitial());
    bool ok = await _orderRepository.orderConfirmed(id: id);
    if (ok == true) {
      for (var i = 0; i < this.ordersList.length; i++) {
        if (this.ordersList[i].id == id) {
          this.ordersList[i].status = 'Delivery in progress';
          break;
        }
      }
      emit(OrderGetListSuccessful(this.ordersList));
    }
  }

  Future<void> orderDelivered({required int id}) async {
    emit(OrderChangeStateInitial());
    bool ok = await _orderRepository.orderDelivered(id: id);
    if (ok == true) {
      for (var i = 0; i < this.ordersList.length; i++) {
        if (this.ordersList[i].id == id) {
          this.ordersList[i].status = 'Delivered';
          break;
        }
      }
      emit(OrderGetListSuccessful(this.ordersList));
    }
  }

  Future<void> orderCanceled({required int id}) async {
    emit(OrderChangeStateInitial());
    bool ok = await _orderRepository.orderDelivered(id: id);
    if (ok == true) {
      for (var i = 0; i < this.ordersList.length; i++) {
        if (this.ordersList[i].id == id) {
          this.ordersList[i].status = 'Delivered';
          break;
        }
      }
      emit(OrderGetListSuccessful(this.ordersList));
    }
  }
}
