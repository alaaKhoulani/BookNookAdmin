import 'package:book_nook_admin/data/models/Book.dart';
import 'package:book_nook_admin/data/models/offers.dart';
import 'package:book_nook_admin/data/models/order.dart';
import 'package:http/http.dart';

class MyPair {
  final Orderes orders;
  Offer? offer;
  BookInfo? book;

  MyPair({this.offer, this.book, required this.orders});
  
}
