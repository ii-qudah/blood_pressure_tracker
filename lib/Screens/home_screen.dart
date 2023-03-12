import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:healthapp/Screens/data_screen.dart';
import 'package:healthapp/Screens/reading_screen.dart';
import 'package:healthapp/Screens/settings_screen.dart';
import 'package:healthapp/main.dart';
import 'package:provider/provider.dart';
import '../Models/chart_model.dart';
import '../Models/sql_helper.dart';
import '../main_provider.dart';
import 'analytics_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentpage = 0;

  @override
  Widget build(BuildContext context) {
    final mainProvider = context.watch<MainProvider>();
    List<Widget>? tabs = [
      Content(context),
      ReadingsPage(),
      AnalyticsPage(
        data: mainProvider.chartsData,
      ),
      SettingsPage(),
    ];
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(6, 22, 33, 1),
        extendBodyBehindAppBar: true,
        body: (tabs.isEmpty)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : tabs[currentpage],
        bottomNavigationBar: GNav(
          selectedIndex: currentpage,
          onTabChange: (newIndex) {
            print(newIndex.toString());
            setState(() {
              currentpage = newIndex;
            });
          },
          backgroundColor: Color.fromRGBO(12, 28, 38, 1),
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.grey.shade800,
          padding: EdgeInsets.all(16),
          tabs: [
            GButton(
              gap: 4,
              icon: Icons.home,
              text: "Home",
            ),
            GButton(
              gap: 4,
              icon: Icons.blur_linear_outlined,
              text: "Readings",
            ),
            GButton(
              gap: 4,
              icon: Icons.bar_chart_outlined,
              text: "Analytics",
            ),
            GButton(
              gap: 4,
              icon: Icons.settings,
              text: "Settings",
            ),
          ],
        ),
      ),
    );
  }
}

Widget Content(context) {
  return Container(
    child: SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Image.asset(
              "assets/heartbeat.png",
              color: Colors.red.shade800,
              width: 100,
            ),
          ),
          Text(
            "Blood Pressure",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Text(
            " Tracker",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Container(
            height: 500,
            child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10, top: 25),
                  height: 175,
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => SimpleDialog(
                          title: Text(
                            'what is high blood pressure (hypertension)?',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 5),
                              child: Text(
                                "Constantly measuring blood pressure above the normal range leads to a diagnosis of high blood pressure."
                                "The higher your blood levels, the greater your vulnerability to more diseases, such as heart disease, heart attack, and stroke.",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '- Signs and symptoms of high blood pressure',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 5),
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text(
                                  "",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '- Causes of high blood pressure',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 5),
                              child: Text(
                                "High blood pressure usually develops over time. It can happen because of unhealthy lifestyle choices, such as not getting enough regular "
                                "physical activity. Certain health conditions, such as diabetes and having obesity, can also increase the risk for developing high blood pressure. "
                                "High blood pressure can also happen during pregnancy.",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            SimpleDialogOption(
                                onPressed: () {},
                                child: ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Color.fromRGBO(6, 22, 33, 1),
                                    ),
                                    icon: Icon(Icons.done_outline_outlined),
                                    label: Text("Done"))),
                          ],
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFf363f93),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                        boxShadow: [
                          new BoxShadow(
                            color: Color(0xFF363f93).withOpacity(0.3),
                            offset: new Offset(0, 10),
                            blurRadius: 5,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "What is high blood ",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 27,
                            ),
                            maxLines: 2,
                          ),
                          Text(
                            "pressure (hypertension)?",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 27,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10, top: 25),
                  height: 175,
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => SimpleDialog(
                          title: Text(
                            '      What Are Systolic and \n Diastolic Blood Pressure?',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 5),
                              child: Text(
                                "The blood pressure reading is measured in millimeters of mercury (mmHg) and is written as systolic pressure, the force of the blood against the artery walls as your heart beats, over diastolic pressure, the blood pressure between heartbeats. For example, a blood pressure reading is written as 120/80 mmHg. The systolic pressure is 120 and the diastolic pressure is 80.",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            SimpleDialogOption(
                                onPressed: () {},
                                child: ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Color.fromRGBO(6, 22, 33, 1),
                                    ),
                                    icon: Icon(Icons.done_outline_outlined),
                                    label: Text("Done"))),
                          ],
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFf363f93),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                        boxShadow: [
                          new BoxShadow(
                            color: Color(0xFF363f93).withOpacity(0.3),
                            offset: new Offset(0, 10),
                            blurRadius: 5,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "What Are Systolic and ",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 27,
                            ),
                            maxLines: 2,
                          ),
                          Text(
                            "Diastolic Blood Pressure?",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 27,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10, top: 25),
                  height: 175,
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => SimpleDialog(
                          title: Text(
                            '      How to lower your \n blood pressure naturally?',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '1. Exercise regularly',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 5),
                              child: Text(
                                "Regular physical activity can lower high blood pressure. It's important to keep exercising to keep blood pressure from rising again. As a general goal, aim for at least 30 minutes of moderate physical activity every day."
                                " Exercise can also help keep elevated blood pressure from turning into high blood pressure (hypertension). For those who have hypertension, regular physical activity can bring blood pressure down to safer levels.",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '2. Eat a healthy diet',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 5),
                              child: Text(
                                "Eating a diet rich in whole grains, fruits, vegetables and low-fat dairy products and low in saturated fat and cholesterol can lower high blood pressure."
                                " Potassium in the diet can lessen the effects of salt (sodium) on blood pressure. The best sources of potassium are foods, such as fruits and vegetables, rather than supplements.",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '3. Quit smoking',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 5),
                              child: Text(
                                "Smoking increases blood pressure. Stopping smoking helps lower blood pressure. It can also reduce the risk of heart disease and improve overall health, possibly leading to a longer life.",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '4. Reduce stress',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 20),
                              child: Text(
                                "Long-term (chronic) emotional stress may contribute to high blood pressure. More research is needed on the effects of stress reduction techniques to find out whether they can reduce blood pressure."
                                " Avoid trying to do too much. Plan your day and focus on your priorities. Learn to say no. Allow enough time to get done what needs to be done.",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            SimpleDialogOption(
                                onPressed: () {},
                                child: ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Color.fromRGBO(6, 22, 33, 1),
                                    ),
                                    icon: Icon(Icons.done_outline_outlined),
                                    label: Text("Done"))),
                          ],
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFf363f93),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                        boxShadow: [
                          new BoxShadow(
                            color: Color(0xFF363f93).withOpacity(0.3),
                            offset: new Offset(0, 10),
                            blurRadius: 5,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "How to lower ",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 27,
                            ),
                            maxLines: 2,
                          ),
                          Text(
                            "blood pressure naturally?",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 27,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10, top: 25),
                  height: 175,
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => SimpleDialog(
                          title: Text(
                            '   What Are the Side Effects \n     of High Blood Pressure \n                    Drugs?',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '1. Diuretics:',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 5),
                              child: Text(
                                "Headache, weakness, low potassium blood levels",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '2. ACE inhibitors:',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 5),
                              child: Text(
                                "Dry and persistent cough, headache, diarrhea, high potassium blood levels",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '3. Angiotensin receptor blockers:',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 5),
                              child: Text(
                                "Fatigue, dizziness or fainting, diarrhea, congestion, high potassium blood levels",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '4. Calcium channel blockers:',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 20),
                              child: Text(
                                "Dizziness, heart rhythm problems, ankle swelling, constipation",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            SimpleDialogOption(
                                onPressed: () {},
                                child: ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Color.fromRGBO(6, 22, 33, 1),
                                    ),
                                    icon: Icon(Icons.done_outline_outlined),
                                    label: Text("Done"))),
                          ],
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFf363f93),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                        boxShadow: [
                          new BoxShadow(
                            color: Color(0xFF363f93).withOpacity(0.3),
                            offset: new Offset(0, 10),
                            blurRadius: 5,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "What Are the Side Effects of ",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                            maxLines: 2,
                          ),
                          Text(
                            "High Blood Pressure Drugs?",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
