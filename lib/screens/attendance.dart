// ignore_for_file: unused_field

import 'package:flutter/material.dart';

class DataTableExample extends StatefulWidget {
  @override
  _DataTableExampleState createState() => _DataTableExampleState();
}

class _DataTableExampleState extends State<DataTableExample> {
  final List<Map<String, dynamic>> _data = [];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final _dropdownController = TextEditingController();
  String? selectedItem;
  String? selectedItem1;

  int _selectedIndex = -1;

  void _addData() {
    final name = _nameController.text;
    final age = _ageController.text;
    final gender = _genderController.text;

    setState(
      () {
        _data.add({
          'name': name,
          'age': age,
          'gender': gender
        });
        _nameController.clear();
        _ageController.clear();
        _genderController.clear();
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
          title: Text('تسجيل غياب الطلبه'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 55,
                  width: 800,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: _nameController,
                    decoration: InputDecoration(hintText: 'اسم الطالب'),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: 300,
                  child: DropdownButtonFormField<String>(
                      value: selectedItem,
                      hint: Text("ادخل المجموعه"),
                      items: <String>[
                        ' سبت  و  ثلاثاء  الساعه  2:30 ',
                        ' سبت  و  ثلاثاء  الساعه  22:30 ',
                        ' 3سبت  و  ثلاثاء  الساعه  2:30 '
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedItem = value; // update the selected item value
                        });
                      }),
                ),
                SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: 300,
                  child: DropdownButtonFormField<String>(
                      value: selectedItem1,
                      hint: Text("السنه الدراسيه"),
                      items: <String>[
                        'الصف الاول الثانوي',
                        'الصف الثاني الثانوي',
                        'الصف الثالث الثانوي'
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedItem1 = value; // update the selected item value
                        });
                      }),
                ),
                SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: 500,
                  child: ElevatedButton(
                    onPressed: _addData,
                    child: Text('Add Data'),
                  ),
                ),
                DataTable(
                  columns: [
                    DataColumn(label: Text('الاسم')),
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
                              DataCell(Text(data['age'].toString())),
                              DataCell(Text(data['gender'])),
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
    );
  }
}
