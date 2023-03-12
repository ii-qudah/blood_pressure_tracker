import 'package:flutter/material.dart';
import 'package:healthapp/main.dart';
import 'package:healthapp/main_provider.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../Models/sql_helper.dart';
import 'reading_screen.dart';

final TextEditingController systolicController = TextEditingController();
final TextEditingController diastolicController = TextEditingController();
final TextEditingController pulseController = TextEditingController();

class DataPage extends StatefulWidget {
  void setStateFromMotherScreen;
  DataPage({Key? key, required this.setStateFromMotherScreen})
      : super(key: key);
  @override
  State<DataPage> createState() => DataPageState();
}

DateTime dateTime = DateTime.now();
final hours = dateTime.hour.toString().padLeft(2, '0');
final minutes = dateTime.minute.toString().padLeft(2, '0');

@override
class DataPageState extends State<DataPage> {
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    final sqlDb = context.watch<SQLHelper>();
    final mainProvider = context.watch<MainProvider>();

    double Width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Readings"),
        titleSpacing: -12,
      ),
      backgroundColor: Color.fromRGBO(6, 22, 33, 1),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 10),
              child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10, bottom: 7),
                  child: Text(
                    "New Reading",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 10, 8, 15),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(width: 0.5),
                          borderRadius: BorderRadius.circular(25)),
                      tileColor: Colors.white,
                      title: Text('Date'),
                      //isThreeLine: true,
                      subtitle: Text(
                        '${dateTime.year}/${dateTime.month}/${dateTime.day}',
                        style: TextStyle(fontSize: 18),
                      ),
                      leading: Icon(Icons.date_range_outlined),
                      trailing: TextButton(
                        onPressed: () async {
                          final date = await pickDate();
                          if (date == null) return;

                          final newDateTime = DateTime(
                            date.year,
                            date.month,
                            date.day,
                            dateTime.hour,
                            dateTime.minute,
                          );
                          setState(() {});
                          dateTime = newDateTime;
                        },
                        child: Text('Change'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 10, 8, 15),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(width: 0.5),
                          borderRadius: BorderRadius.circular(25)),
                      tileColor: Colors.white,

                      title: Text('Time'),
                      //isThreeLine: true,
                      subtitle: Text(
                        '${dateTime.hour}:${(dateTime.minute < 10) ? "0" + dateTime.minute.toString() : dateTime.minute}',
                        style: TextStyle(fontSize: 19),
                      ),
                      leading: Icon(Icons.access_time_outlined),
                      trailing: TextButton(
                        onPressed: () async {
                          final time = await pickTime();
                          if (time == null) return;

                          final newDateTime = DateTime(
                            dateTime.year,
                            dateTime.month,
                            dateTime.day,
                            time.hour,
                            time.minute,
                          );
                          setState(() {
                            dateTime = newDateTime;
                          });
                        },
                        child: Text('Change'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        "Systolic",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 40,
                        width: 70,
                        child: TextFormField(
                          
                          controller: systolicController,
                          keyboardType: TextInputType.number,
                          //maxLength: 5,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            labelText: '120',
                            floatingLabelAlignment:
                                FloatingLabelAlignment.start,
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Diastolic",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 40,
                        width: 70,
                        child: TextFormField(
                          controller: diastolicController,
                          keyboardType: TextInputType.number,
                          //maxLength: 5,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            labelText: ' 60',
                            floatingLabelAlignment:
                                FloatingLabelAlignment.start,
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Pulse",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 40,
                        width: 70,
                        child: TextFormField(
                          controller: pulseController,
                          keyboardType: TextInputType.number,
                          //maxLength: 5,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            labelText: ' 80',
                            floatingLabelAlignment:
                                FloatingLabelAlignment.start,
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: ElevatedButton(
                child: Text(
                  'Save Reading',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () async {
                  bool sc = true;
                  bool dc = true;
                  bool pc = true;
                  if (systolicController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('please fill systolic filed')));
                    sc = false;
                  } else if (int.parse(systolicController.text) > 300 ||
                      int.parse(systolicController.text) <= 0) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text('please enter valid range in systolic fild')));
                    sc = false;
                  }
                  if (diastolicController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('please fill diastolic filed')));
                    dc = false;
                  } else if (int.parse(diastolicController.text) > 300 ||
                      int.parse(diastolicController.text) <= 0) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            'please enter valid range in diastolic fild')));
                    dc = false;
                  }
                  if (pulseController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('please fill pulse filed')));
                    pc = false;
                  } else if (int.parse(pulseController.text) > 300 ||
                      int.parse(pulseController.text) <= 0) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text('please enter valid range in pulse fild')));
                    pc = false;
                  }

                  if ((pc && dc && sc) == true) {
                    int response = await sqlDb.insertData('''
                   INSERT INTO health ('systolic' , 'diastolic', 'pulse' , 'date' , 'time')
                   VALUES ("${systolicController.text}", "${diastolicController.text}","${pulseController.text}", "${dateTime.day}/${dateTime.month}/${dateTime.year}", "${dateTime.hour}:${dateTime.minute}")
                   ''');

                    print("response ==========");
                    print(response);

                    setState(() {
                      if (response > 0) {
                        systolicController.clear();
                        diastolicController.clear();
                        pulseController.clear();
                        widget.setStateFromMotherScreen;
                        mainProvider.readData();
                        Navigator.of(context).pop();
                      }
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                  maximumSize: const Size(200, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<DateTime?> pickDate() => showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2200));

  Future<TimeOfDay?> pickTime() => showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        //initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute),
      );
}
