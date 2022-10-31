import 'dart:convert';

import 'package:book_nook_admin/data/models/Book.dart';

class Offer {
  int? id;
  int? libraryId;
  String? title;
  int? totalPrice;
  int? quantity;
  List<BookInfo>? books;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

  Offer(
      {this.id,
      this.libraryId,
      this.title,
      this.totalPrice,
      this.quantity,
      this.books,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Offer fromJson(Map<String, dynamic> json) {
    // print("json[]");
    // print(json["books"]);
    Offer offer = Offer(
      id: json['id'],
      libraryId: json['library_id'],
      title: json['title'],
      totalPrice: json['total_price'],
      quantity: json['quantity'],
      // books: BookInfo.fromJsonList(json["books"]),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
    );
    // print(offer.title);
    return offer;
  }

  Offer listBooks(Offer offer, Map<String, dynamic> json) {
    print("list offer book");
    // print(json);
    List<BookInfo> _list = [];
    for (int i = 0; i < json.length; i++) {
      _list.add(BookInfo().fromJson1(json[i]));
    }
    offer.books = _list;
    return offer;
  }

  // Offer.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   libraryId = json['library_id'];
  //   title = json['title'];
  //   totalPrice = json['total_price'];
  //   quantity = json['quantity'];
  //   if (json['books'] != null) {
  //     books = <BookInfo>[];
  //     json['books'].forEach((v) {
  //       books!.add(new BookInfo().fromJson1(v));
  //     });
  //   }
  //   createdAt = json['created_at'];
  //   updatedAt = json['updated_at'];
  //   deletedAt = json['deleted_at'];
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['library_id'] = this.libraryId;
    data['title'] = this.title;
    data['total_price'] = this.totalPrice;
    data['quantity'] = this.quantity;
    if (this.books != null) {
      data['books'] = this.books!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
