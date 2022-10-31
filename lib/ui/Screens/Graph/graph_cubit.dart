import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:book_nook_admin/services/storage/store.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'graph_model.dart';
import 'graph_state.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class GraphCubit extends Cubit<GraphStates> {
  GraphCubit() : super(GraphInitial());
  List<String> allMonth = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'sep',
    'Aoc',
    'Nov',
    'Dec'
  ];

  static GraphCubit get(context) => BlocProvider.of(context);

  DateTime selectedyear = DateTime.now();

  void selectYear(DateTime date) {
    selectedyear = date;
    emit(SelectStartYear());
  }

  var start = 2022;
  var end = 2023;
  void getYear() {
    emit(GraphInitial());
    getYearsApi();
    print("year");
    print(yearApi);
    // start = yearApi.elementAt(0);

    // yearApi.last;
    // end = yearApi[0];
    // log("$start , $end");
    emit(GetYears());
  }

  List yearApi = [];
  Future getYearsApi() async {
    try {
      log('inside getYearsApi');
      var response = await http
          .get(Uri.parse("${Store.baseURL}/api/statistics/years"), headers: {
        'Accept': 'application/json',
        'Authorization': "Bearer ${Store.token}"
      });
      print(response.statusCode);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        print("${jsonResponse['data']}");
        log('Request success with status: ${response.statusCode}.');
        yearApi = jsonResponse['data'];
        log("${jsonResponse['data']}");
        //log('$jsonResponse');
      } else {
        log('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  List pie = [];
  void makeCat() {
    pie = [];
    catApi.forEach((val) {
      var data = GraphModel(name: val["category_name"], value: val["cnt"]);
      if (val["cnt"] != 0) {
        pie.add(data);
        data.getColor();
      }
    });
    log("$pie");
    emit(GetCategory());
  }

  List catApi = [];
  Future getCategoryApi({required int year}) async {
    try {
      log('inside getCategoryApi $year');
      var response = await http.get(
          Uri.parse(
              "${Store.baseURL}/api/statistics/category_sales_borrows/$year"),
          headers: {
            'Accept': 'application/json',
            'Authorization':'Bearer ${Store.token}' });

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        print("${jsonResponse["data"]["response"]}");
        log('Request success with status: ${response.statusCode}.');
        catApi = jsonResponse["data"]["response"].toList();
        makeCat();
        log("${jsonResponse["data"]["response"]}");

        //log('$jsonResponse');
      } else {
        log('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  List<FlSpot> point = [];
  List salesApi = [];
  void make() {
    point = [];

    salesApi.forEach((val) {
      var po = FlSpot(val[0] - 1.0, val[1] + 0.0);
      point.add(po);
    });
    log("$point");
    emit(Getpoint());
  }

  Future getSalesApi({required int year}) async {
    try {
      log('inside getSalesApi');
      var response = await http.get(
          Uri.parse(
              "${Store.baseURL}/api/statistics/years_sales/$year"),
          headers: {
            'Accept': 'application/json',
            'Authorization':'Bearer ${Store.token}' });

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        print("${jsonResponse["data"]}");
        log('Request success with status: ${response.statusCode}.');
        salesApi = jsonResponse["data"].toList();
        make();
        log("${salesApi}");

        //log('$jsonResponse');
      } else {
        log('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
