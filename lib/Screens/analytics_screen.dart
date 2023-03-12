import 'dart:math';
import 'package:healthapp/Screens/reading_screen.dart';

import '../Models/chart_model.dart';
import '../Models/line_titles.dart';
import '../Models/sql_helper.dart';
import 'data_screen.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class AnalyticsPage extends StatefulWidget {
  final List<ChartModel> data;

  const AnalyticsPage({Key? key, required this.data}) : super(key: key);

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  SQLHelper sqlDb = SQLHelper();

  void initState() {
    super.initState();
    // getMyData();
  }

  @override
  Widget build(BuildContext context) {
    List<ChartModel> data = widget.data;
    print(data);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Readings'),
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              title: ChartTitle(text: 'Readings'),
              //legend: Legend(isVisible: true),
              series: [
                for (var data in widget.data)
                  LineSeries<ChartModel, String>(
                    dataSource: widget.data,
                    xValueMapper: (ChartModel chart, _) => chart.date,
                    yValueMapper: (ChartModel chart, _) => chart.systolic,

                    name: 'Readings',
                    // Enable data label
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                  ),
                for (var data in widget.data)
                  LineSeries<ChartModel, String>(
                      dataSource: widget.data,
                      xValueMapper: (ChartModel chart, _) => chart.date,
                      yValueMapper: (ChartModel chart, _) => chart.diastolic,
                      name: 'Readings',
                      // Enable data label
                      dataLabelSettings: DataLabelSettings(isVisible: true))
              ],
              tooltipBehavior: TooltipBehavior(enable: true),
              // series: <ChartSeries<ChartModel, String>>[
              //   LineSeries<ChartModel, String>(
              //       dataSource: data,
              //       xValueMapper: (ChartModel chart, _) => chart.date,
              //       yValueMapper: (ChartModel chart, _) => chart.systolic,
              //
              //       name: 'Readings',
              //       // Enable data label
              //       dataLabelSettings: DataLabelSettings(isVisible: true))
              // ]
            ),
          ),
        ]));
  }
}
