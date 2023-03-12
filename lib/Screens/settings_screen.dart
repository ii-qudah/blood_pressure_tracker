import 'package:flutter/material.dart';

import '../Models/sql_helper.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  SQLHelper sqlDb = SQLHelper();

  @override
  Widget build(BuildContext context) {
      return MaterialButton(onPressed: () async{
        await sqlDb.mydeleteDatabase();
      },child: Text("delete DB",style: TextStyle(color: Colors.white),),
      );


  }
}
