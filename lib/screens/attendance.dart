// ignore_for_file: unused_field, must_be_immutable
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentEntryPage extends StatefulWidget {
  @override
  _StudentEntryPageState createState() => _StudentEntryPageState();
}

class _StudentEntryPageState extends State<StudentEntryPage> {
  final List<Map<String, dynamic>> _data = [];
  String firstDropdownValue = '          الصف الاول الثانوي         ';
  String secondDropdownValue = '         سبت  و  ثلاثاء  الساعه 1:30         ';
  String? selectedItem;
  String? selectedItem1;
  int _selectedIndex = -1;

  final _formKey = GlobalKey<FormState>();
  final _dropdownController = TextEditingController();

  Map<String, List<String>> _choices = {
    '          الصف الاول الثانوي         ': [
      '         سبت  و  ثلاثاء  الساعه  1:30         ',
      '         سبت  و  ثلاثاء  الساعه  2:30         ',
      '         سبت  و  ثلاثاء  الساعه 3:30         '
    ],
    '          الصف الثاني الثانوي          ': [
      '         سبت  و  ثلاثاء  الساعه  4:30         ',
      '         سبت  و  ثلاثاء  الساعه  5:30         ',
      '         سبت  و  ثلاثاء  الساعه 6:30         '
    ],
    '          الصف الثالث الثانوي          ': [
      '         سبت  و  ثلاثاء  الساعه  7:30         ',
      '         سبت  و  ثلاثاء  الساعه  8:30         ',
      '         سبت  و  ثلاثاء  الساعه 9:30         '
    ]
  };

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _gphoneController = TextEditingController();
  final TextEditingController _sphoneController = TextEditingController();
  final TextEditingController _classsController = TextEditingController();
  final TextEditingController _yearOfStudyController = TextEditingController();

  savePref(String name, gphone, sphone, classs, yearOfStudy) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();

    preferences.setString("name_$timestamp", name);
    preferences.setString("gphone_$timestamp", gphone);
    preferences.setString("sphone_$timestamp", sphone);
    preferences.setString("classs_$timestamp", classs);
    preferences.setString("yearOfStudy_$timestamp", yearOfStudy);
    preferences.setString("dropdownValue1_$timestamp", firstDropdownValue);
    preferences.setString("dropdownValue2_$timestamp", selectedItem1 ?? ''); // Update the selected value
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
              backgroundColor: Color(0xFF6F35A5),
              centerTitle: true,
              title: Text(
                'تسجيل الطلبه',
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              )),
          body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                  child: Center(
                      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 70,
                  width: 750,
                  child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: _nameController,
                      decoration: InputDecoration(hintText: 'اسم الطالب'),
                      validator: (nameCurrentValue) {
                        RegExp regex = RegExp(r'^[\u0621-\u064A]+\s[\u0621-\u064A]+\s[\u0621-\u064A]+$');
                        var nameNonNullValue = nameCurrentValue ?? "";
                        if (nameNonNullValue.isEmpty) {
                          return (" الرجاء ادخال اسم الطالب");
                        } else if (!regex.hasMatch(nameNonNullValue)) {
                          return ("الرجاء ادخال اسم الطالب  ثلاثي");
                        }
                        return null;
                      }),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                    height: 70,
                    width: 750,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: _sphoneController,
                      decoration: InputDecoration(hintText: 'رقم الطالب'),
                      validator: (sphoneCurrentValue) {
                        RegExp regex = RegExp(r'^01[0125][0-9]{8}$');
                        var sphoneNonNullValue = sphoneCurrentValue ?? "";
                        if (sphoneNonNullValue.isEmpty) {
                          return ("الرجاء ادخال رقم الطالب");
                        } else if (!regex.hasMatch(sphoneNonNullValue)) {
                          return ("الرجاء ادخال رقم صحيح");
                        }
                        return null;
                      },
                    )),
                SizedBox(
                  height: 25,
                ),
                SizedBox(
                  height: 70,
                  width: 750,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: _gphoneController,
                    decoration: InputDecoration(hintText: 'رقم ولي الامر '),
                    validator: (sphoneCurrentValue) {
                      RegExp regex = RegExp(r'^01[0125][0-9]{8}$');
                      var sphoneNonNullValue = sphoneCurrentValue ?? "";
                      if (sphoneNonNullValue.isEmpty) {
                        return ("الرجاء ادخال رقم ولي الامر    ");
                      } else if (!regex.hasMatch(sphoneNonNullValue)) {
                        return ("الرجاء ادخال رقم صحيح");
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: 300,
                  child: DropdownButtonFormField<String>(
                    focusColor: Colors.white,
                    validator: (newValue) => newValue == null ? 'الرجاء اختيار السنه الدراسيه' : null,
                    hint: Text("         السنه الدراسيه          "),
                    onChanged: (String? newValue) {
                      setState(() {
                        firstDropdownValue = newValue!;
                        selectedItem1 = null; // Reset the selected value of the second dropdown
                      });
                    },
                    items: <String>[
                      '          الصف الاول الثانوي         ',
                      '          الصف الثاني الثانوي          ',
                      '          الصف الثالث الثانوي          '
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: 300,
                  child: DropdownButtonFormField<String>(
                    focusColor: Colors.white,
                    validator: (value1) => value1 == null ? 'الرجاء اختيار المجموعه' : null,
                    hint: Text("         ادخل المجموعه         "),
                    onChanged: (String? value1) {
                      setState(() {
                        selectedItem1 = value1; // update the selected item value
                      });
                    },
                    value: selectedItem1,
                    items: _choices[firstDropdownValue]?.map<DropdownMenuItem<String>>((String? value1) {
                      return DropdownMenuItem<String>(
                        value: value1,
                        child: Text(value1!),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                SizedBox(
                    width: 500,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          savePref(
                            _nameController.text,
                            _gphoneController.text,
                            _sphoneController.text,
                            secondDropdownValue,
                            firstDropdownValue,
                          );
                          _formKey.currentState!.reset();
                          _nameController.clear();
                          _gphoneController.clear();
                          _sphoneController.clear();
                        }
                      },
                      child: Text('Add Data'),
                    ))
              ])))),
        ));
  }
}

Future<void> savePref(BuildContext context, String name, String gphone, String sphone, String classs, String yearOfStudy) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString("name", name);
  preferences.setString("gphone", gphone);
  preferences.setString("sphone", sphone);
  preferences.setString("classs", classs);
  preferences.setString("yearOfStudy", yearOfStudy);
}
