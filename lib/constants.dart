import 'package:flutter/material.dart';

import 'sqlDb.dart';

const kPrimaryColor = Color(0xFF6F35A5);
const kPrimarybackgroundColor = Color(0xFF6F35A5);
const kPrimaryLightColor = Color(0xFFF1E6FF);
const kAttendanceBox = 'Attendance_box';
final RegExp nameRegex = RegExp(r'^([\u0621-\u064A]+\s){2,}[\u0621-\u064A]+$');
final RegExp phoneRegex = RegExp(r'^01[0125][0-9]{8}$');
final SqlDb sqlDb = SqlDb();
final TextEditingController nameController = TextEditingController();
final TextEditingController gphoneController = TextEditingController();
final TextEditingController sphoneController = TextEditingController();
final GlobalKey<FormState> formKey = GlobalKey<FormState>();
FormState? formState; // Variable to store the FormState object
late TabController tabController;
List<DataRow> dataRowsTab2 = [];
const List<String> sec1G = [
  'sat & tue1',
  'sat & tue2',
  'sat & tue3',
  'sat & tue4',
  'sat & tue5',
];
const List<String> sec2G = [
  'sat & tue6',
  'sat & tue7',
  'sat & tue8',
  'sat & tue9',
  'sat & tue10',
];
const List<String> sec3G = [
  'sat & tue11',
  'sat & tue12',
  'sat & tue13',
  'sat & tue14',
  'sat & tue15',
];
const List1G = [
  Tab(text: 'تسجيل طالب جديد'),
  Tab(text: 'sat & tue1'),
  Tab(text: 'sat & tue2'),
  Tab(text: 'sat & tue3'),
  Tab(text: 'sat & tue4'),
  Tab(text: 'sat & tue5'),
];
const List2G = [
  Tab(text: 'تسجيل طالب جديد'),
  Tab(text: 'sat & tue6'),
  Tab(text: 'sat & tue7'),
  Tab(text: 'sat & tue8'),
  Tab(text: 'sat & tue9'),
  Tab(text: 'sat & tue10'),
];
const List3G = [
  Tab(text: 'تسجيل طالب جديد'),
  Tab(text: 'sat & tue11'),
  Tab(text: 'sat & tue12'),
  Tab(text: 'sat & tue13'),
  Tab(text: 'sat & tue14'),
  Tab(text: 'sat & tue15'),
];
