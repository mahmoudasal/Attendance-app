import 'package:flutter/material.dart';

import '../constants.dart';
import 'studentTaps.dart';
import 'inputFields.dart';

class Sec3 extends StatefulWidget {
  _Sec3State createState() => _Sec3State();
}

class _Sec3State extends State<Sec3> with TickerProviderStateMixin {
  static const String _selectedChoice = 'sat & tue11';

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 6, vsync: this);
  }

  void _saveDataToTable(String tableName) async {
    String sql =
        "INSERT INTO '$tableName' ('name', 'sPhone', 'gPhone') VALUES (?, ?, ?)";

    String name = nameController.text;
    String sPhone = sphoneController.text;
    String gPhone = gphoneController.text;

    // ignore: unused_local_variable
    int response = await sqlDb.insertData(sql, name, sPhone, gPhone);
  }

  void _editData(Map rowData, String tableName) {
    // Extract the necessary data from the rowData map
    String name = rowData['name'].toString();
    String sPhone = rowData['sPhone'].toString();
    String gPhone = rowData['gPhone'].toString();
    int id = rowData['id'];

    // Populate the form fields with the existing data
    nameController.text = name;
    sphoneController.text = sPhone;
    gphoneController.text = gPhone;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Data'),
          content: Form(
            key: formKey,
            child: Builder(
              // Use Builder widget to access the FormState
              builder: (BuildContext context) {
                formState = Form.of(context);
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: 'Name'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: sphoneController,
                      decoration: const InputDecoration(labelText: 'sPhone'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter an sPhone';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: gphoneController,
                      decoration: const InputDecoration(labelText: 'gPhone'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a gPhone';
                        }
                        return null;
                      },
                    ),
                  ],
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (formState != null && formState!.validate()) {
                  // Save the updated data to the database
                  String sql =
                      "UPDATE $tableName SET name = ?, sPhone = ?, gPhone = ? WHERE id = ?";
                  await sqlDb.updatetData(
                      sql,
                      id,
                      nameController.text,
                      sphoneController.text,
                      gphoneController.text,
                      Navigator.pop(context));

                  // Refresh the data table
                  _refreshDataTable(tableName);

                  nameController.clear();
                  sphoneController.clear();
                  gphoneController.clear();
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _deleteData(int id, String tableName) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Data'),
          content: const Text('Are you sure you want to delete this data?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Delete the data from the database
                await sqlDb.deleteData(tableName, id);
                Navigator.pop(context);

                // Refresh the data table
                _refreshDataTable(tableName);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _refreshDataTable(String tableName) async {
    List<Map> response = await sqlDb.readData("SELECT * FROM '$tableName'");
    setState(() {
      dataRowsTab2 = response.map<DataRow>((row) {
        return DataRow(cells: [
          DataCell(Text(row['name'].toString())),
          DataCell(Text(row['sPhone'].toString())),
          DataCell(Text(row['gPhone'].toString())),
          DataCell(
            ElevatedButton(
              onPressed: () {
                _editData(row, tableName);
              },
              child: const Text('Edit'),
            ),
          ),
          DataCell(
            ElevatedButton(
              onPressed: () {
                _deleteData(row['id'], tableName);
              },
              child: const Text('Delete'),
            ),
          ),
        ]);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimarybackgroundColor,
          centerTitle: true,
          title: const Text(
            'الصف الثالث الثانوي ',
            style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
          ),
          bottom: TabBar(controller: tabController, tabs: List3G),
        ),
        body: TabBarView(
          controller: tabController,
          children: [
            Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        const SizedBox(height: 100),
                        CustomTextField(
                          controller: nameController,
                          hintText: 'اسم الطالب',
                          emptyValueError: 'الرجاء ادخال اسم الطالب',
                          validationError: 'الرجاء ادخال اسم الطالب ثلاثي',
                          regex: nameRegex,
                        ),
                        const SizedBox(height: 25),
                        CustomTextField(
                          controller: sphoneController,
                          hintText: 'رقم الطالب',
                          emptyValueError: 'الرجاء ادخال رقم الطالب',
                          validationError: 'الرجاء ادخال رقم صحيح',
                          regex: phoneRegex,
                        ),
                        const SizedBox(height: 25),
                        CustomTextField(
                          controller: gphoneController,
                          hintText: 'رقم ولي الامر',
                          emptyValueError: 'الرجاء ادخال رقم ولي الامر',
                          validationError: 'الرجاء ادخال رقم صحيح',
                          regex: phoneRegex,
                        ),
                        const SizedBox(height: 25),
                        CustomDropdown(
                          selectedChoice: _selectedChoice,
                          items: sec3G,
                        ),
                        SizedBox(
                          width: 500,
                          child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                switch (_selectedChoice) {
                                  case 'sat & tue11':
                                    _saveDataToTable('satwtue11');
                                    break;
                                  case 'sat & tue12':
                                    _saveDataToTable('satwtue12');
                                    break;
                                  case 'sat & tue13':
                                    _saveDataToTable('satwtue13');
                                    break;
                                  case 'sat & tue14':
                                    _saveDataToTable('satwtue14');
                                    break;
                                  case 'sat & tue15':
                                    _saveDataToTable('satwtue15');
                                    break;
                                }
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('تمت إضافة بيانات الطالب بنجاح!'),
                                  ),
                                );
                                nameController.clear();
                                sphoneController.clear();
                                gphoneController.clear();
                              }
                            },
                            child: const Text('اضافه'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            CustomDataTable(
              tableName: 'satwtue11',
              editData: _editData,
            ),
            CustomDataTable(
              tableName: 'satwtue12',
              editData: _editData,
            ),
            CustomDataTable(
              tableName: 'satwtue13',
              editData: _editData,
            ),
            CustomDataTable(
              tableName: 'satwtue14',
              editData: _editData,
            ),
            CustomDataTable(
              tableName: 'satwtue15',
              editData: _editData,
            ),
          ],
        ),
      ),
    );
  }
}
