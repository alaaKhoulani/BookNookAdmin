import 'package:book_nook_admin/data/models/Book.dart';
import 'package:book_nook_admin/data/models/address.dart';
import 'package:book_nook_admin/data/models/admin.dart';
import 'package:book_nook_admin/data/models/offers.dart';
import 'package:book_nook_admin/data/models/order.dart';

class RecieveOrder {
  Admin? admin;
  Library? library;
  Address? address;
  int? totalPrice;
  List<SubOrder>? orders;
  int? id;
  String? status;
  User? user;

  RecieveOrder(
      {this.address,
      this.library,
      this.orders,
      this.totalPrice,
      this.admin,
      this.status,
      this.user,
      this.id});

  RecieveOrder fromJson(Map<String, dynamic> json) {
    return RecieveOrder(
        admin: Admin().fromJson1(json["user"]),
        library: Library().fromJson1(json["library"]),
        address: Address().fromJson(json["address"]),
        totalPrice: json["totalPrice"],
        id: json["id"],
        status: json['status'],
        user: User().fromJson(json['user']),
        orders: SubOrder().fromJsonList(json["sub_orders"]));
  }
}

class User {
  int? userId;
  int? roleId;
  String? email;
  int? isVerified;
  String? firstName;
  String? middleName;
  String? lastName;
  String? gender;
  String? phone;
  String? birthDay;

  User({
    this.userId,
    this.roleId,
    this.email,
    this.isVerified,
    this.firstName,
    this.middleName,
    this.lastName,
    this.gender,
    this.phone,
    this.birthDay,
  });

  User fromJson(Map<String, dynamic> json) {
    return User(
        userId: json['user_id'],
        roleId: json['role_id'],
        email: json['email'],
        isVerified: json['is_verified'],
        firstName: json['first_name'],
        middleName: json['middle_name'],
        lastName: json['last_name'],
        gender: json['gender'],
        phone: json['phone'],
        birthDay: json['birth_day']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['role_id'] = this.roleId;
    data['email'] = this.email;
    data['is_verified'] = this.isVerified;
    data['first_name'] = this.firstName;
    data['middle_name'] = this.middleName;
    data['last_name'] = this.lastName;
    data['gender'] = this.gender;
    data['phone'] = this.phone;
    data['birth_day'] = this.birthDay;
    return data;
  }
}

class SubOrder {
  BookInfo? book;
  Offer? offer;
  int? quantity;

  SubOrder({this.book, this.offer, this.quantity});

  SubOrder fromJson(Map<String, dynamic> json) {
    if(json['book']!=null)
    return SubOrder(
        book: BookInfo().fromJson1(json['book']),
        // offer: Offer().fromJson(json['offer']),
        quantity: json['quantity']);
    return SubOrder(
        // book: BookInfo().fromJson1(json['book']),
        offer: Offer().fromJson(json['offer']),
        quantity: json['quantity']);
  }

  List<SubOrder> fromJsonList(List json) {
    List<SubOrder> _list = [];
    for (var i = 0; i < json.length; i++) {
      _list.add(SubOrder().fromJson(json[i]));
    }
    return _list;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.book != null) {
      data['book'] = this.book!.toJson();
    }
    data['offer'] = this.offer;
    data['quantity'] = this.quantity;
    return data;
  }
}
