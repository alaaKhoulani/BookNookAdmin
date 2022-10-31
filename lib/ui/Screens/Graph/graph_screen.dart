import 'package:book_nook_admin/services/translate/locale_keys.g.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../consts/myColors.dart';
import 'graph_cubit.dart';
import 'graph_state.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

//
class GraphScreen extends StatefulWidget {
  const GraphScreen({Key? key}) : super(key: key);

  @override
  State<GraphScreen> createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var cubit = GraphCubit.get(context);
    print('init');
    cubit.getYear();
    // cubit.getCategoryApi(year: year);
  }

  DateTime _selected = DateTime.now();
  void buildSelectYear(context, cubit) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(LocaleKeys.selectYear.tr()),
          content: Container(
            // Need to use container to add size constraint.
            width: 300,
            height: 300,
            child: YearPicker(
              firstDate: DateTime(cubit.start, 1),
              lastDate: DateTime(cubit.end, 1),
              initialDate: DateTime.now(),
              selectedDate: _selected,
              onChanged: (DateTime dateTime) {
                // close the dialog when year is selected.
                Navigator.pop(context);
                cubit.selectYear(dateTime);
                cubit.getCategoryApi(year: dateTime.year);
                cubit.getSalesApi(year: dateTime.year);
                // Do something with the dateTime selected.
                // Remember that you need to use dateTime.year to get the year
              },
            ),
          ),
        );
      },
    );
  }

  FlTitlesData getTitles() => FlTitlesData(
        show: true,
        topTitles: SideTitles(
          showTitles: false,
        ),
        rightTitles: SideTitles(
          showTitles: false,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          margin: 10,
          reservedSize: 40,
          getTextStyles: (_, value) => TextStyle(color: MyColors.myPurble),
        ),
        bottomTitles: SideTitles(
          showTitles: true,
          margin: 10,
          reservedSize: 30, //bottom space
          getTextStyles: (_, value) => TextStyle(color: MyColors.myPurble),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return 'Jan';
              case 1:
                return 'Feb';
              case 2:
                return 'Mar';
              case 3:
                return 'Apr';
              case 4:
                return 'May';
              case 5:
                return 'Jun';
              case 6:
                return 'Jul';
              case 7:
                return 'Aug';
              case 8:
                return 'Sep';
              case 9:
                return 'Aoc';
              case 10:
                return 'Nov';
              case 11:
                return 'Des';
            }
            return ' ';
          },
        ),
      );

  List<PieChartSectionData> getSections(cubit) =>
      cubit.pie.map<PieChartSectionData>((val) {
        return PieChartSectionData(
          title: "${val.value}%",
          color: val.color,
          value: val.value + 0.0,
          titleStyle: TextStyle(color: Colors.white),
        );
      }).toList();
  Widget buildDesc(cubit, context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 100,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2),
      itemCount: cubit.pie.length,
      itemBuilder: (context, index) {
        return Container(
          width: 100,
          height: 10,
          child: Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: cubit.pie[index].color),
              ),
              SizedBox(width: 8),
              Text(
                cubit.pie[index].name,
                style: TextStyle(fontSize: 16),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GraphCubit, GraphStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = GraphCubit.get(context);
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: MyColors.myPurble,
                actions: [
                  TextButton(
                      child: Text("${cubit.selectedyear.year}^",
                          style: TextStyle(color: MyColors.myGreen)),
                      onPressed: () {
                        buildSelectYear(context, cubit);
                        cubit.getYearsApi();
                      })
                ],
                title: Text(
                  LocaleKeys.sales.tr(),
                  style: TextStyle(color: MyColors.myWhite),
                ),
                bottom: TabBar(
                  indicatorColor: MyColors.myPurble,
                  onTap: (cnt) {},
                  tabs: <Widget>[
                    Tab(
                      icon: Icon(Icons.show_chart, color: MyColors.myWhite),
                    ),
                    Tab(
                      icon: Icon(Icons.pie_chart, color: MyColors.myWhite),
                    ),
                  ],
                ),
              ),
              body: TabBarView(children: [
                Container(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      height: 600,
                      width: 600,
                      padding: EdgeInsets.all(50),
                      child: LineChart(
                        LineChartData(
                          minX: 0,
                          maxX: 11,
                          minY: 10,
                          maxY: 100,
                          titlesData: getTitles(),
                          lineTouchData: LineTouchData(
                              touchTooltipData: LineTouchTooltipData(
                                  tooltipBgColor: MyColors.myWhite,
                                  showOnTopOfTheChartBoxArea: false)),
                          lineBarsData: [
                            LineChartBarData(
                              dotData: FlDotData(show: true),
                              spots: cubit.point,
                              barWidth: 2,
                              colors: [MyColors.myPurble, MyColors.myGreen],
                              belowBarData: BarAreaData(
                                show: true,
                                colors: [
                                  MyColors.myPurble.withOpacity(0.1),
                                  MyColors.myGreen.withOpacity(0.1)
                                ],
                              ),
                            ),
                          ],
                        ),

                        swapAnimationDuration:
                            Duration(milliseconds: 150), // Optional
                        swapAnimationCurve: Curves.linear,
                      ),
                    ),
                  ),
                ),
                Card(
                  child: Column(
                    children: [
                      Expanded(
                        child: PieChart(
                          PieChartData(
                            borderData: FlBorderData(show: false),
                            sectionsSpace: 0.0,
                            centerSpaceRadius: 40.0,
                            sections: getSections(cubit),
                          ),
                        ),
                      ),
                      Container(
                          height: 200,
                          width: double.infinity,
                          padding: EdgeInsets.all(16),
                          child: buildDesc(cubit, context))
                    ],
                  ),
                )
              ]),
            ),
          );
        });
  }
}
