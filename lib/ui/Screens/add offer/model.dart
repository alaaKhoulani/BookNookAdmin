class AddOfferModel {
  late String title;
  late int totalPrice;
  late List<int> books;
  late int quantity;

  AddOfferModel(
      {required this.title,
      required this.totalPrice,
      required this.books,
      required this.quantity});

  AddOfferModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    totalPrice = json['totalPrice'];
    books = json['books'].cast<int>();
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = this.title;
    data['totalPrice'] = this.totalPrice;
    data['books'] = this.books;
    data['quantity'] = this.quantity;
    return data;
  }
}

class Pair {
  final String name;
  final int id;

  Pair({required this.name,required this.id});
}
