import 'package:book_nook_admin/data/models/recieve_order.dart';
import 'package:book_nook_admin/data/web_services/order_web_services.dart';

class OrderRepository {
  OrderWebServices _orderWebRepository = OrderWebServices();

  Future<List<RecieveOrder>> getOrders() async {
    print("===============");
    List<RecieveOrder> list = [];
    List json = await _orderWebRepository.getOrders();
    for (var i = 0; i < json.length; i++) {
      list.add(RecieveOrder().fromJson(json[i]));
    }
    print(list.length);
    return list;
  }

  Future<bool> orderConfirmed({required int id}) async {
    return await _orderWebRepository.orderConfirmed(id: id);
  }

  Future<bool> orderDelivered({required int id}) async {
    return await _orderWebRepository.orderDelivered(id: id);
  }

  Future<bool> orderCanceled({required int id}) async {
    return await _orderWebRepository.orderCanceled(id: id);
  }
}
