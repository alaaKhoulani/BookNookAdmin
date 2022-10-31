part of 'order_cubit.dart';

@immutable
abstract class OrderState {}

class OrderInitial extends OrderState {}
class OrderChangeStateInitial extends OrderState {}
class OrderConfitmedSuccessful extends OrderState {}

class OrderPostSuccessful extends OrderState {}

class OrderRemoveFromList extends OrderState {
  final List<MyPair> orderes;

  OrderRemoveFromList(this.orderes);
}

class OrderAddToList extends OrderState {
  final List<MyPair> orderes;

  OrderAddToList(this.orderes);
}

class OrderGetListInitial extends OrderState {}

class OrderGetListSuccessful extends OrderState {
  final List<RecieveOrder> orders;
  OrderGetListSuccessful(this.orders);
}
