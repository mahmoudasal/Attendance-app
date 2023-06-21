import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'constants.dart';
import 'models/student.dart';
import 'models/student.g.dart';
import 'screens/navbar.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Student>(StudentAdapter());
  await Hive.openBox<Student>('sat&tue1');
  await Hive.openBox<Student>('sat&tue2');
  await Hive.openBox<Student>('sat&tue3');
  await Hive.openBox<Student>('sat&tue4');
  await Hive.openBox<Student>('sat&tue5');
  await Hive.openBox<Student>('sat&tue6');
  await Hive.openBox<Student>('sat&tue7');
  await Hive.openBox<Student>('sat&tue8');
  await Hive.openBox<Student>('sat&tue9');
  await Hive.openBox<Student>('sat&tue10');
  await Hive.openBox<Student>('sat&tue11');
  await Hive.openBox<Student>('sat&tue12');
  await Hive.openBox<Student>('sat&tue13');
  await Hive.openBox<Student>('sat&tue14');
  await Hive.openBox<Student>('sat&tue15');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
        "WelcomeScreen": (context) => const NavigatorScreen(),
        "Navpage": (context) => const NavigatorScreen()
      },
    );
  }
}
