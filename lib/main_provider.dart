import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Models/chart_model.dart';
import 'Models/sql_helper.dart';

class MainProvider extends ChangeNotifier {
  List<ChartModel> chartsData = [];

  Future<List<ChartModel>> readData() async {
    chartsData.clear();
    List<Map> response = await SQLHelper().readData("SELECT * FROM health");
    for (var snap in response) {
      chartsData.add(
        ChartModel(
          date: snap["date"],
          pulse: int.parse(snap['pulse'].toString()),
          time: snap['time'],
          id: snap['id'],
          systolic: snap["systolic"],
          diastolic: int.parse(snap['diastolic']),
        ),
      );
    }

    notifyListeners();

    return chartsData;
  }
}
