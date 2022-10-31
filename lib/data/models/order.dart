class Order {
  List<Orderes>? orderes;
  int? totalPrice;
  int? addressId;
  int? libraryId;
  

  Order({this.orderes, this.totalPrice, this.addressId, this.libraryId});

  Order fromJson(Map<String, dynamic> json) {
    return Order(
      orderes: Orderes().fromJsonList(json["orderes"]),
      totalPrice: json['totalPrice'],
      addressId: json['address_id'],
      libraryId: json['library_id'],
    );
  }

  

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orderes != null) {
      data['orderes'] = this.orderes!.map((v) => v.toJson()).toList();
    }
    data['totalPrice'] = this.totalPrice;
    data['address_id'] = this.addressId;
    data['library_id'] = this.libraryId;
    return data;
  }
}

class Orderes {
  int? bookId;
  String? type;
  int? quantity;
  int? offerId;

  Orderes({this.bookId, this.type, this.quantity, this.offerId});

  List<Orderes> fromJsonList(List json) {
    List<Orderes> _list = [];
    for (var i = 0; i < json.length; i++) {
      _list.add(Orderes().fromJson(json[i]));
    }
    return _list;
  }
  
  Orderes fromJson(Map<String, dynamic> json) {
    return Orderes(
      bookId: json['book_id'],
      type: json['type'],
      quantity: json['quantity'],
      offerId: json['offer_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['book_id'] = this.bookId.toString();
    data['type'] = this.type.toString();
    data['quantity'] = this.quantity.toString();
    data['offer_id'] = this.offerId.toString();
    return data;
  }
}
