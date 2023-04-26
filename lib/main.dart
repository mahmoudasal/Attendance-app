import 'package:el_zareef_app/screens/Welcome/welcome_screen.dart';
import 'package:el_zareef_app/screens/attendance.dart';
import 'package:el_zareef_app/screens/navbar.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: kPrimaryColor,
            shape: const StadiumBorder(),
            maximumSize: const Size(double.infinity, 56),
            minimumSize: const Size(double.infinity, 56),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: kPrimaryLightColor,
          iconColor: kPrimaryColor,
          prefixIconColor: kPrimaryColor,
          contentPadding: EdgeInsets.symmetric(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      initialRoute: "WelcomeScreen",
      routes: {
        "WelcomeScreen": (context) => NavigatorScreen(),
        "Navpage": (context) => NavigatorScreen()
      },
      // home: WelcomeScreen(),
      // // home: StudentEntryPage(),
    );
  }
}
