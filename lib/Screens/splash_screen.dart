import 'package:flutter/material.dart';
import 'package:healthapp/Screens/home_screen.dart';
import 'package:healthapp/main_provider.dart';
import 'package:healthapp/theme/extention.dart';
import 'package:provider/provider.dart';
import '../theme/light_color.dart';
import '../theme/text_styles.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    final mainProvider = context.read<MainProvider>();
    mainProvider.readData();
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage()));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/doctor_face.jpg"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned.fill(
            child: Opacity(
              opacity: .6,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [LightColor.purpleExtraLight, LightColor.purple],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      tileMode: TileMode.mirror,
                      stops: [.5, 6]),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: SizedBox(),
              ),
              Center(child: Image.asset("assets/heartbeat.png", color: Colors.white,height: 100,)),
              Text(
                "Blood Pressure\n       Tracker",
                style: TextStyle(color: Colors.white,fontSize: 25),

              ),
              Text(
                "",
                style: TextStyles.bodySm.white.bold,
              ),
              Expanded(
                flex: 7,
                child: SizedBox(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
