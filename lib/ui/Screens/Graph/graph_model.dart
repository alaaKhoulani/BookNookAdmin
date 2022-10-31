import "dart:math";


import 'package:flutter/material.dart';

import '../../../consts/myColors.dart';

class GraphModel {
  late String name;
  late int value;
  late var color = MyColors.myGreen;

  GraphModel({
    required this.name,
    required this.value,
  });

  GraphModel.fromJson(Map<String, dynamic> json) {
    name = json["category_name"];
    value = json["cnt"];
    getColor();
  }

  void getColor() {
    var list = [Colors.greenAccent, MyColors.myPurble, MyColors.myPurble2];
    final _random = new Random();
    this.color = list[_random.nextInt(list.length)];
    print(this.color);
  }
}
