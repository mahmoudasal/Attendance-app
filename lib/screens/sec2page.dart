import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart' as path;

class S2 extends StatefulWidget {
  final String selectedDropdownValue;

  S2({required this.selectedDropdownValue});

  _S2State createState() => _S2State(selectedDropdownValue);
}

class _S2State extends State<S2> {
  int? editingRowIndex;
  String? selectedDropdownValue;
  String searchQuery = '';
  String newName = '';
  String newGphone = '';
  String newSphone = '';
  String newDropdownValue1 = '';
  String newDropdownValue2 = '';
  final _formKeysec1 = GlobalKey<FormState>();

  _S2State(this.selectedDropdownValue);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF6F35A5),
          centerTitle: true,
          title: Text(
            'الصف الثاني الثانوي',
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
                      if (key.startsWith("s2_name_")) {
                        String timestamp = key.substring(8);
                        String name = preferences.getString("s2_name_$timestamp") ?? '';
                        String gphone = preferences.getString("s2_gphone_$timestamp") ?? '';
                        String sphone = preferences.getString("s2_sphone_$timestamp") ?? '';
                        String dropdownValue2 = preferences.getString("s2_dropdownValue1_$timestamp") ?? '';
                        String dropdownValue1 = preferences.getString("s2_dropdownValue2_$timestamp") ?? '';

                        if (name.toLowerCase().contains(searchQuery.toLowerCase())) {
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
                      }
                    });

                    return Column(
                      children: [
                        TextFormField(
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            setState(() {
                              searchQuery = value;
                            });
                          },
                          decoration: InputDecoration(hintText: 'اسم الطالب'),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: DataTable(
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
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF6F35A5),
          onPressed: _exportToExcel,
          child: Icon(Icons.file_download),
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

    String name = newName.isNotEmpty ? newName : preferences.getString("s2_name_$timestamp") ?? '';
    String gphone = newGphone.isNotEmpty ? newGphone : preferences.getString("s2_gphone_$timestamp") ?? '';
    String sphone = newSphone.isNotEmpty ? newSphone : preferences.getString("s2_sphone_$timestamp") ?? '';
    String dropdownValue1 = newDropdownValue1.isNotEmpty ? newDropdownValue1 : preferences.getString("s2_dropdownValue1_$timestamp") ?? '';
    String dropdownValue2 = newDropdownValue2.isNotEmpty ? newDropdownValue2 : preferences.getString("s2_dropdownValue2_$timestamp") ?? '';
    if (_formKeysec1.currentState!.validate()) {
      // Update the values in SharedPreferences
      preferences.setString("s2_name_$timestamp", name);
      preferences.setString("s2_gphone_$timestamp", gphone);
      preferences.setString("s2_sphone_$timestamp", sphone);
      preferences.setString("s2_dropdownValue1_$timestamp", dropdownValue1);
      preferences.setString("s2_dropdownValue2_$timestamp", dropdownValue2);

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

    preferences.remove("s2_name_$timestamp");
    preferences.remove("s2_gphone_$timestamp");
    preferences.remove("s2_sphone_$timestamp");
    preferences.remove("s2_dropdownValue1_$timestamp");
    preferences.remove("s2_dropdownValue2_$timestamp");

    setState(() {});
  }

  void _exportToExcel() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    Excel excel = Excel.createExcel();
    Sheet sheet = excel['Sheet1'];

    // Add headers to the sheet
    sheet.appendRow([
      'الاسم',
      'رقم الطالب',
      'رقم ولي الأمر',
      'المجموعة',
      'السنة الدراسية'
    ]);

    // Iterate through the stored data and add rows to the sheet
    preferences.getKeys().forEach((key) {
      if (key.startsWith("s2_name_")) {
        String timestamp = key.substring(8);
        String name = preferences.getString("s2_name_$timestamp") ?? '';
        String gphone = preferences.getString("s2_gphone_$timestamp") ?? '';
        String sphone = preferences.getString("s2_sphone_$timestamp") ?? '';
        String dropdownValue2 = preferences.getString("s2_dropdownValue1_$timestamp") ?? '';
        String dropdownValue1 = preferences.getString("s2_dropdownValue2_$timestamp") ?? '';

        // Add data rows
        sheet.appendRow([
          name,
          gphone,
          sphone,
          dropdownValue1,
          dropdownValue2
        ]);
      }
    });
    // Get the document directory path to save the Excel file
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    String fileName = 's2_data.xlsx';
    String filePath = path.join(appDocPath, fileName);

    // Save the Excel file
    List<int>? excelBytes = await excel.encode();

    File(filePath)
      ..createSync(recursive: true)
      ..writeAsBytesSync(excelBytes!);

    // Show a dialog indicating the successful export
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Exported Successfully'),
          content: Text('File has been exported to excel '),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
