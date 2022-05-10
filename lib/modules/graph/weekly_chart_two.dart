import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sup/controller/history_controller.dart';
import 'package:sup/utils/constant_value.dart';

class BarChartSample3 extends StatefulWidget {


  @override
  State<StatefulWidget> createState() => BarChartSample3State();
}

class BarChartSample3State extends State<BarChartSample3> {


  HistoryController _historyController=Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.7,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        // color: const Color(0xff2c4260),
        color: Colors.transparent,
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: double.parse(maxStep.toString()),
            barTouchData: BarTouchData(
              enabled: false,
              touchTooltipData: BarTouchTooltipData(
                tooltipBgColor: Colors.transparent,
                tooltipPadding: const EdgeInsets.all(0),
                getTooltipItem: (
                  BarChartGroupData group,
                  int groupIndex,
                  BarChartRodData rod,
                  int rodIndex,
                ) {
                  return BarTooltipItem(
                    rod.y.round().toString(),
                    TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: SideTitles(
                showTitles: true,
                // getTextStyles: (value) => const TextStyle(
                //     color: Color(0xff7589a2),
                //     fontWeight: FontWeight.bold,
                //     fontSize: 14),
                margin: 50,
                getTitles: (double value) {
                  switch (value.toInt()) {
                    case 0:
                      return _historyController.arrOfWeekHistory[0].dayName!
                          .substring(0, 1)
                          .toUpperCase();
                    case 1:
                      return _historyController.arrOfWeekHistory[1].dayName!
                          .substring(0, 1)
                          .toUpperCase();
                    case 2:
                      return _historyController.arrOfWeekHistory[2].dayName!
                          .substring(0, 1)
                          .toUpperCase();
                    case 3:
                      return _historyController.arrOfWeekHistory[3].dayName!.substring(0,1).toUpperCase();
                    case 4:
                      return _historyController.arrOfWeekHistory[4].dayName!.substring(0,1).toUpperCase();
                    case 5:
                      return _historyController.arrOfWeekHistory[5].dayName!.substring(0,1).toUpperCase();
                    case 6:
                      return _historyController.arrOfWeekHistory[6].dayName!.substring(0,1).toUpperCase();
                    case 7:
                      return _historyController.arrOfWeekHistory[7].dayName!.substring(0,1).toUpperCase();
                    default:
                      return '';
                  }
                },
              ),
              leftTitles: SideTitles(showTitles: false),
            ),
            borderData: FlBorderData(
              show: true,
            ),
            barGroups: [
              BarChartGroupData(
                x: 0,
                barRods: [
                  BarChartRodData(
                      y: double.parse(_historyController.arrOfWeekHistory[0].steps.toString()),
                      colors: [Color(0xffEF4723),Color(0xffFBFF8D) ])
                ],
                showingTooltipIndicators: [0],
              ),
              BarChartGroupData(
                x: 1,
                barRods: [
                  BarChartRodData(
                      y: double.parse(_historyController.arrOfWeekHistory[1].steps.toString()),
                      colors: [Color(0xffEF4723),Color(0xffFBFF8D) ])
                ],
                showingTooltipIndicators: [0],
              ),
              BarChartGroupData(
                x: 2,
                barRods: [
                  BarChartRodData(
                      y: double.parse(_historyController.arrOfWeekHistory[2].steps.toString()),
                      colors: [Color(0xffEF4723),Color(0xffFBFF8D) ])
                ],
                showingTooltipIndicators: [0],
              ),
              BarChartGroupData(
                x: 3,
                barRods: [
                  BarChartRodData(
                      y: double.parse(_historyController.arrOfWeekHistory[3].steps.toString()),
                      colors: [Color(0xffEF4723),Color(0xffFBFF8D) ])
                ],
                showingTooltipIndicators: [0],
              ),
              BarChartGroupData(
                x: 4,
                barRods: [
                  BarChartRodData(
                      y: double.parse(_historyController.arrOfWeekHistory[4].steps.toString()),
                      colors: [Color(0xffEF4723),Color(0xffFBFF8D) ])
                ],
                showingTooltipIndicators: [0],
              ),
              BarChartGroupData(
                x: 5,
                barRods: [
                  BarChartRodData(
                      y: double.parse(_historyController.arrOfWeekHistory[5].steps.toString()),
                      colors: [Color(0xffEF4723),Color(0xffFBFF8D) ])
                ],
                showingTooltipIndicators: [0],
              ),
              BarChartGroupData(
                x: 6,
                barRods: [
                  BarChartRodData(
                      y: double.parse(_historyController.arrOfWeekHistory[6].steps.toString()),
                      colors: [Color(0xffEF4723),Color(0xffFBFF8D) ])
                ],
                showingTooltipIndicators: [0],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
