import 'package:flutter/material.dart';
import 'package:healthapp/Models/sql_helper.dart';
import 'package:healthapp/Screens/data_screen.dart';
import 'package:healthapp/main_provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:provider/provider.dart';
import 'Screens/splash_screen.dart';
import 'notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initializeNotification();
  NotificationService().showNotification(
      1, 'Blood Pressure Tracker', 'It\'s time for your daily reading');

  runApp(const healthapp());
}

class healthapp extends StatelessWidget {
  const healthapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MainProvider()),
        ChangeNotifierProvider(create: (context) => SQLHelper()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Health_App",
        home: SplashScreen(),
       
      ),
    );
  }
}
