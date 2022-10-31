import 'dart:io';

import 'package:flutter/material.dart';

class Book {
  final int id;
  final String name;
  final String description;

  Book(this.name, this.description, this.id);
  //late final Image image;

  /* Book.fromJson(Map<String, dynamic> json) {
    this.name = json[''];
    this.description = json[''];
    //this.image = json[''];
  }*/

}

class BookInfo {
  late int? bookId;
  late int? id;
  late Library? library;
  late String? name;
  late int? numOfPage;
  late String? summary;
  late String? pdf;
  late String? image;
  late int? searches;
  late int? rate;
  late List<Category>? categories;
  late List<Author>? authors;
  late int? purchasingPrice;
  late int? sellingPrice;
  late String? state;
  late int? quantity;
  late String? createdAt;
  late String? updatedAt;
  late String? deletedAt;

  BookInfo(
      {this.id,
      this.bookId,
      this.library,
      this.name,
      this.numOfPage,
      this.summary,
      this.pdf,
      this.image,
      this.searches,
      this.rate,
      this.categories,
      this.authors,
      this.purchasingPrice,
      this.sellingPrice,
      this.state,
      this.quantity,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  BookInfo fromJson1(Map<String, dynamic> json) {
    print("fromjsonbook");
    print(json["categories"]);
    late BookInfo book;
    return BookInfo(
        id: json['id'],
        bookId: json['book_id'],
        name: json['name'],
        summary: json['summary'],
        pdf: json['pdf'],
        image: json['image'],
        searches: json['searches'],
        rate: json['rate'],
        purchasingPrice: json['purchasing_price'],
        sellingPrice: json['selling_price'],
        state: json['state'],
        quantity: json['quantity'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        deletedAt: json['deleted_at'],
        numOfPage: json['num_of_page'],
        categories: Category().arrayFromJson1(json["categories"]),
        authors: Author().arrayFromJson1(json["authors"])
        // authors:
        );
  }

  BookInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookId = json['book_id'];
    library = Library.fromJson(json['library']);
    name = json['name'];
    numOfPage = json['num_of_page'];
    summary = json['summary'];
    pdf = json['pdf'];
    image = json['image'];
    searches = json['searches'];
    rate = json['rate'];
    if (json['categories'] != null) {
      categories = <Category>[];
      json['categories'].forEach((v) {
        categories!.add(Category.fromJson(v));
      });
    }
    if (json['authors'] != null) {
      authors = <Author>[];
      json['authors'].forEach((v) {
        authors!.add(Author.fromJson(v));
      });
    }
    purchasingPrice = json['purchasing_price'];
    sellingPrice = json['selling_price'];
    state = json['state'];
    quantity = json['quantity'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['book_id'] = this.bookId;
    if (this.library != null) {
      data['library'] = this.library!.toJson();
    }
    data['name'] = this.name;
    data['num_of_page'] = this.numOfPage;
    data['summary'] = this.summary;
    data['pdf'] = this.pdf;
    data['image'] = this.image;
    data['searches'] = this.searches;
    data['rate'] = this.rate;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    if (this.authors != null) {
      data['authors'] = this.authors!.map((v) => v.toJson()).toList();
    }
    data['purchasing_price'] = this.purchasingPrice;
    data['selling_price'] = this.sellingPrice;
    data['state'] = this.state;
    data['quantity'] = this.quantity;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class Library {
  late int? id;
  late int? roleId;
  late String? email;
  late int? isVerified;
  late String? firstName;
  late String? middleName;
  late String? lastName;
  late String? libraryName;
  late String? phoneNumber;
  late String? image;
  late String? status;
  late String? openTime;
  late String? closeTime;
  late String? createdAt;
  late String? updatedAt;

  Library(
      { this.id,
       this.roleId,
       this.email,
       this.isVerified,
       this.firstName,
       this.middleName,
       this.lastName,
       this.libraryName,
       this.phoneNumber,
       this.image,
       this.status,
       this.openTime,
       this.closeTime,
       this.createdAt,
       this.updatedAt});

  Library fromJson1(Map<String, dynamic> json) {
    return Library(
        id: json['id'],
        roleId: json['role_id'],
        email: json['email'],
        isVerified: json['is_verified'],
        firstName: json['first_name'],
        middleName: json['middle_name'],
        lastName: json['last_name'],
        libraryName: json['library_name'],
        phoneNumber: json['phone_number'],
        image: json['image'],
        status: json['status'],
        openTime: json['open_time'],
        closeTime: json['close_time'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at']);
  }

  Library.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roleId = json['role_id'];
    email = json['email'];
    isVerified = json['is_verified'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    libraryName = json['library_name'];
    phoneNumber = json['phone_number'];
    image = json['image'];
    status = json['status'];
    openTime = json['open_time'];
    closeTime = json['close_time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['role_id'] = this.roleId;
    data['email'] = this.email;
    data['is_verified'] = this.isVerified;
    data['first_name'] = this.firstName;
    data['middle_name'] = this.middleName;
    data['last_name'] = this.lastName;
    data['library_name'] = this.libraryName;
    data['phone_number'] = this.phoneNumber;
    data['image'] = this.image;
    data['status'] = this.status;
    data['open_time'] = this.openTime;
    data['close_time'] = this.closeTime;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}



class Category {
  int? id;
  String? name;

  Category({this.id, this.name});
  List<Category> arrayFromJson1(List json) {
    print("json category");
    print(json);
    List<Category> _list = [];
    for (var i = 0; i < json.length; i++) {
      _list.add(Category().fromJson1(json[i]));
    }
    return _list;
  }

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
  Category fromJson1(Map<String, dynamic> json) {
    return Category(id: json["id"], name: json["name"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Author {
  int? id;
  String? name;

  Author({this.id, this.name});
  Author fromJson1(Map<String, dynamic> json) {
    return Author(id: json["id"], name: json["name"]);
  }

  Author.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
  List<Author> arrayFromJson1(List json) {
    print("json author");
    print(json);
    List<Author> _list = [];
    for (var i = 0; i < json.length; i++) {
      _list.add(Author().fromJson1(json[i]));
    }
    return _list;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
