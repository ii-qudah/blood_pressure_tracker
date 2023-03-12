import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '../Models/sql_helper.dart';
import '../main_provider.dart';
import 'data_screen.dart';
import '../Models/sql_helper.dart';
import 'package:sqflite/sqflite.dart';

class ReadingsPage extends StatefulWidget {
  const ReadingsPage({Key? key}) : super(key: key);

  @override
  State<ReadingsPage> createState() => _ReadingsPageState();
}

class _ReadingsPageState extends State<ReadingsPage> {
  @override
  void initState() {
    final mainProvider = context.read<MainProvider>();
    mainProvider.readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mainProvider = context.watch<MainProvider>();
    final sqlDb = context.watch<SQLHelper>();

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DataPage(
                        setStateFromMotherScreen: setState,
                      )));
        },
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          for (var read in mainProvider.chartsData.reversed)
            Container(
              margin: const EdgeInsets.only(bottom: 0, top: 25),
              //height: 85,
              height: 150,
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 7),
                      child: Text(
                        "${read.date} at ${read.time}",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 5, top: 6),
                                child: Text(
                                  "Blood Pressure",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 36),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: "${read.systolic}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 28)),
                                    TextSpan(
                                        text: "",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 28)),
                                    TextSpan(
                                        text: "/",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 28)),
                                    TextSpan(
                                        text: "${read.diastolic}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 28)),
                                    TextSpan(
                                        text: " mmHg",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 28)),
                                  ],
                                ),
                                textScaleFactor: 0.5,
                              )
                              //Text(currentItem['systolic,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 13),),
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 5, top: 6),
                                child: Text(
                                  "Pulse",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 36),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: "${read.pulse}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30)),
                                    TextSpan(
                                        text: "",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30)),
                                    TextSpan(
                                        text: " bpm",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30)),
                                  ],
                                ),
                                textScaleFactor: 0.5,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                        width: 300,
                        child: Divider(
                          color: Colors.white,
                          thickness: 0.8,
                        )),
                    IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                    "Are you sure you want to delete this reading?"),
                                actions: [
                                  MaterialButton(
                                    onPressed: () async {
                                      int response = await sqlDb.deleteData(
                                          "DELETE FROM health WHERE id = ${read.id}");
                                      mainProvider.readData();
                                      setState(() {});
                                      Navigator.pop(context);
                                    },
                                    child: Text("Yes"),
                                  ),
                                  MaterialButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Cancel"),
                                  ),
                                ],
                              );
                            });

                        setState(() {});
                      },
                      icon: Icon(
                        Icons.delete_forever,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ]),
      ),
    );
  }
}
