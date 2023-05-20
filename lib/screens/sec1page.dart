import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class S1 extends StatefulWidget {
  @override
  _S1State createState() => _S1State();
}

class _S1State extends State<S1> {
  int? editingRowIndex;

  String newName = '';
  String newGphone = '';
  String newSphone = '';
  String newDropdownValue1 = '';
  String newDropdownValue2 = '';
  final _formKeysec1 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF6F35A5),
          centerTitle: true,
          title: Text(
            'الصف الاول الثانوي',
            style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
          ),
        ),
        body: Form(
          key: _formKeysec1,
          child: Center(
            child: Container(
              padding: EdgeInsets.all(15.0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: FutureBuilder<SharedPreferences>(
                future: SharedPreferences.getInstance(),
                builder: (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
                  if (snapshot.hasData) {
                    SharedPreferences preferences = snapshot.data!;
                    List<DataRow> rows = [];

                    preferences.getKeys().forEach((key) {
                      if (key.startsWith("name_")) {
                        String timestamp = key.substring(5);
                        String name = preferences.getString("name_$timestamp") ?? '';
                        String gphone = preferences.getString("gphone_$timestamp") ?? '';
                        String sphone = preferences.getString("sphone_$timestamp") ?? '';
                        String dropdownValue2 = preferences.getString("dropdownValue1_$timestamp") ?? '';
                        String dropdownValue1 = preferences.getString("dropdownValue2_$timestamp") ?? '';

                        rows.add(DataRow(cells: [
                          DataCell(Text(name)),
                          DataCell(Text(gphone)),
                          DataCell(Text(sphone)),
                          DataCell(Text(dropdownValue1)),
                          DataCell(Text(dropdownValue2)),
                          DataCell(
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                _editData(timestamp);
                              },
                            ),
                          ),
                          DataCell(
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                _deleteData(timestamp);
                              },
                            ),
                          ),
                        ]));

                        if (editingRowIndex == int.parse(timestamp)) {
                          rows.add(buildEditingRow(
                            timestamp,
                            name,
                            gphone,
                            sphone,
                            dropdownValue1,
                            dropdownValue2,
                          ));
                        }
                      }
                    });

                    return DataTable(
                      columns: [
                        DataColumn(label: Text('الاسم')),
                        DataColumn(label: Text('رقم الطالب')),
                        DataColumn(label: Text('رقم ولي الأمر')),
                        DataColumn(label: Text('المجموعة')),
                        DataColumn(label: Text('السنة الدراسية')),
                        DataColumn(label: Text('تعديل')),
                        DataColumn(label: Text('حذف')),
                      ],
                      rows: rows,
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  DataRow buildEditingRow(String timestamp, String name, String gphone, String sphone, String dropdownValue1, String dropdownValue2) {
    return DataRow(cells: [
      DataCell(TextFormField(
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
        initialValue: name,
        onChanged: (value) {
          setState(() {
            newName = value;
          });
        },
      )),
      DataCell(TextFormField(
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
        initialValue: gphone,
        onChanged: (value) {
          setState(() {
            newGphone = value;
          });
        },
      )),
      DataCell(TextFormField(
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
        initialValue: sphone,
        onChanged: (value) {
          setState(() {
            newSphone = value;
          });
        },
      )),
      DataCell(TextFormField(
        initialValue: dropdownValue1,
        onChanged: (value) {
          setState(() {
            newDropdownValue1 = value;
          });
        },
      )),
      DataCell(TextFormField(
        initialValue: dropdownValue2,
        onChanged: (value) {
          setState(() {
            newDropdownValue2 = value;
          });
        },
      )),
      DataCell(
        IconButton(
          icon: Icon(Icons.save),
          onPressed: () {
            _saveData(timestamp);
          },
        ),
      ),
      DataCell(IconButton(
          icon: Icon(Icons.cancel),
          onPressed: () {
            setState(() {
              editingRowIndex = null;
            });
          }))
    ]);
  }

  void _saveData(String timestamp) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // Implement the save functionality here
    // You can access the data using the provided timestamp and state variables

    String name = newName.isNotEmpty ? newName : preferences.getString("name_$timestamp") ?? '';
    String gphone = newGphone.isNotEmpty ? newGphone : preferences.getString("gphone_$timestamp") ?? '';
    String sphone = newSphone.isNotEmpty ? newSphone : preferences.getString("sphone_$timestamp") ?? '';
    String dropdownValue1 = newDropdownValue1.isNotEmpty ? newDropdownValue1 : preferences.getString("dropdownValue1_$timestamp") ?? '';
    String dropdownValue2 = newDropdownValue2.isNotEmpty ? newDropdownValue2 : preferences.getString("dropdownValue2_$timestamp") ?? '';
    if (_formKeysec1.currentState!.validate()) {
      // Update the values in SharedPreferences
      preferences.setString("name_$timestamp", name);
      preferences.setString("gphone_$timestamp", gphone);
      preferences.setString("sphone_$timestamp", sphone);
      preferences.setString("dropdownValue1_$timestamp", dropdownValue1);
      preferences.setString("dropdownValue2_$timestamp", dropdownValue2);

      setState(() {
        editingRowIndex = null;
      });
    }
  }

  void _editData(String timestamp) {
    setState(() {
      editingRowIndex = int.parse(timestamp);
    });
  }

  void _deleteData(String timestamp) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // Implement the delete functionality here
    // You can access the data using the provided timestamp

    preferences.remove("name_$timestamp");
    preferences.remove("gphone_$timestamp");
    preferences.remove("sphone_$timestamp");
    preferences.remove("dropdownValue1_$timestamp");
    preferences.remove("dropdownValue2_$timestamp");

    setState(() {});
  }
}
