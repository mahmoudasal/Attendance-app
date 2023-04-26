// ignore_for_file: unused_field

import 'package:flutter/material.dart';

class StudentEntryPage extends StatefulWidget {
  @override
  _StudentEntryPageState createState() => _StudentEntryPageState();
}

class _StudentEntryPageState extends State<StudentEntryPage> {
  final List<Map<String, dynamic>> _data = [];
  String firstDropdownValue = 'الصف الاول الثانوي';
  String secondDropdownValue = 'سبت  و  ثلاثاء  الساعه  1:30 ';
  final _formKey = GlobalKey<FormState>();
  final _dropdownController = TextEditingController();
  String? selectedItem;
  String? selectedItem1;
  int _selectedIndex = -1;

  Map<String, List<String>> _choices = {
    'الصف الاول الثانوي': [
      'سبت  و  ثلاثاء  الساعه  1:30 ',
      'سبت  و  ثلاثاء  الساعه  2:30 ',
      ' سبت  و  ثلاثاء  الساعه 3:30 '
    ],
    'الصف الثاني الثانوي': [
      ' سبت  و  ثلاثاء  الساعه  4:30 ',
      ' سبت  و  ثلاثاء  الساعه  5:30 ',
      ' سبت  و  ثلاثاء  الساعه 6:30 '
    ],
    'الصف الثالث الثانوي': [
      ' سبت  و  ثلاثاء  الساعه  7:30 ',
      ' سبت  و  ثلاثاء  الساعه  8:30 ',
      ' سبت  و  ثلاثاء  الساعه 9:30 '
    ]
  };

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _sphoneController = TextEditingController();
  final TextEditingController _classsController = TextEditingController();
  final TextEditingController _yearOfStudyController = TextEditingController();

  void _addData() {
    final name = _nameController.text;
    final phone = _phoneController.text;
    final sphone = _sphoneController.text;
    final classs = secondDropdownValue;
    final yearOfStudy = firstDropdownValue;

    setState(
      () {
        _data.add({
          'name': name,
          'phone': phone,
          'sphone': sphone,
          'classs': classs,
          'yearOfStudy': yearOfStudy
        });
        _nameController.clear();
        _phoneController.clear();
        _sphoneController.clear();
        _classsController.clear();
        _yearOfStudyController.clear();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF6F35A5),
          title: Text('تسجيل الطلبه'),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                      },
                    ),
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
                      validator: (phoneCurrentValue) {
                        RegExp regex = RegExp(r'^01[0125][0-9]{8}$');
                        var phoneNonNullValue = phoneCurrentValue ?? "";
                        if (phoneNonNullValue.isEmpty) {
                          return ("الرجاء ادخال رقم الطالب");
                        } else if (!regex.hasMatch(phoneNonNullValue)) {
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
                    height: 70,
                    width: 750,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: _phoneController,
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
                      validator: (newValue) => newValue == null ? 'الرجاء اختيار السنه الدراسيه' : null,
                      hint: Text("         السنه الدراسيه             "),
                      onChanged: (String? newValue) {
                        setState(() {
                          firstDropdownValue = newValue!;
                          secondDropdownValue = _choices[firstDropdownValue]![0];
                        });
                      },
                      items: <String>[
                        'الصف الاول الثانوي',
                        'الصف الثاني الثانوي',
                        'الصف الثالث الثانوي'
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
                  // لسته المواعيد
                  SizedBox(
                    width: 300,
                    child: DropdownButtonFormField<String>(
                      validator: (value1) => value1 == null ? 'الرجاء اختيار المجموعه' : null,
                      hint: Text("     ادخل المجموعه         "),
                      onChanged: (String? value1) {
                        setState(() {
                          selectedItem1 = value1; // update the selected item value
                        });
                      },
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
                          _addData();
                        }
                      },
                      child: Text('Add Data'),
                    ),
                  ),
                  DataTable(
                    columns: [
                      DataColumn(label: Text('الاسم')),
                      DataColumn(label: Text('رقم الطالب')),
                      DataColumn(label: Text('رقم ولي الامر')),
                      DataColumn(label: Text('المجموعه')),
                      DataColumn(label: Text('السنه الدراسيه')),
                      DataColumn(label: Text('')),
                    ],
                    rows: _data
                        .asMap()
                        .map(
                          (index, data) => MapEntry(
                            index,
                            DataRow(
                              cells: [
                                DataCell(Text(data['name'])),
                                DataCell(Text(data['sphone'].toString())),
                                DataCell(Text(data['phone'].toString())),
                                DataCell(Text(data['classs'])),
                                DataCell(Text(data['yearOfStudy'])),
                                DataCell(
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      setState(() {
                                        _selectedIndex = index;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .values
                        .toList(),
                  ),
                  if (_selectedIndex != -1)
                    SizedBox(
                      width: 500,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(
                            () {
                              _data.removeAt(_selectedIndex);
                              _selectedIndex = -1;
                            },
                          );
                        },
                        child: Text('Remove Selected Data'),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
