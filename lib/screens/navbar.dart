import 'package:el_zareef_app/screens/sec1page.dart';
import 'package:el_zareef_app/screens/sec2page.dart';
import 'package:el_zareef_app/screens/sec3page.dart';
import 'package:flutter/material.dart';

import 'attendance.dart';

class NavigatorScreen extends StatefulWidget {
  const NavigatorScreen({Key? key}) : super(key: key);

  @override
  State<NavigatorScreen> createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {
  int currentIndex = 0;
  List<Widget> listOfScreens = [
    StudentEntryPage(),
    sec1page(),
    sec2Page(),
    sec3Page(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.indigo,
        backgroundColor: Colors.white,
        selectedFontSize: 16.0,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "تسجيل الطلبه",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "الصف الاول الثانوي ",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "الصف الثاني الثانوي ",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "الصف الثالث الثانوي",
          ),
        ],
      ),
      body: listOfScreens[currentIndex],
    );
  }
}
