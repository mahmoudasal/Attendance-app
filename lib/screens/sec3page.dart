// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, annotate_overrides, unused_field, unused_local_variable

import 'package:flutter/material.dart';
import 'package:el_zareef_app/sqlDb.dart';

class Sec3 extends StatefulWidget {
  _Sec3State createState() => _Sec3State();
}

class _Sec3State extends State<Sec3> with TickerProviderStateMixin {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _gphoneController = TextEditingController();
  final TextEditingController _sphoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FormState? _formState;

  late TabController _tabController;
  List<DataRow> dataRowsTab2 = [];
  String _selectedChoice = 'sat & tue11';

  static final RegExp nameRegex =
      RegExp(r'^([\u0621-\u064A]+\s){2,}[\u0621-\u064A]+$');
  static final RegExp phoneRegex = RegExp(r'^01[0125][0-9]{8}$');
  SqlDb sqlDb = SqlDb();

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 6, vsync: this);
  }

  void _saveDataToTable(String tableName) async {
    String sql =
        "INSERT INTO '$tableName' ('name', 'sPhone', 'gPhone') VALUES (?, ?, ?)";

    String name = _nameController.text;
    String sPhone = _sphoneController.text;
    String gPhone = _gphoneController.text;

    int response = await sqlDb.insertData(sql, name, sPhone, gPhone);
  }

  void _editData(Map rowData, String tableName) {
    // Extract the necessary data from the rowData map
    String name = rowData['name'].toString();
    String sPhone = rowData['sPhone'].toString();
    String gPhone = rowData['gPhone'].toString();
    int id = rowData['id'];

    // Populate the form fields with the existing data
    _nameController.text = name;
    _sphoneController.text = sPhone;
    _gphoneController.text = gPhone;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Data'),
          content: Form(
            key: _formKey,
            child: Builder(
              // Use Builder widget to access the FormState
              builder: (BuildContext context) {
                _formState = Form.of(context);
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Name'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _sphoneController,
                      decoration: const InputDecoration(labelText: 'sPhone'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter an sPhone';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _gphoneController,
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
                if (_formState != null && _formState!.validate()) {
                  // Save the updated data to the database
                  String sql =
                      "UPDATE $tableName SET name = ?, sPhone = ?, gPhone = ? WHERE id = ?";
                  await sqlDb.updatetData(
                      sql,
                      id,
                      _nameController.text,
                      _sphoneController.text,
                      _gphoneController.text,
                      Navigator.pop(context));

                  // Refresh the data table
                  _refreshDataTable(tableName);

                  _nameController.clear();
                  _sphoneController.clear();
                  _gphoneController.clear();
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
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF6F35A5),
          centerTitle: true,
          title: const Text(
            'الصف الثالث الثانوي ',
            style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
          ),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'تسجيل طالب جديد'),
              Tab(text: 'sat & tue11'),
              Tab(text: 'sat & tue12'),
              Tab(text: 'sat & tue13'),
              Tab(text: 'sat & tue14'),
              Tab(text: 'sat & tue15'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        const SizedBox(height: 100),
                        SizedBox(
                          height: 70,
                          width: 750,
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            controller: _nameController,
                            decoration:
                                const InputDecoration(hintText: 'اسم الطالب'),
                            validator: (nameCurrentValue) {
                              var nameNonNullValue = nameCurrentValue ?? "";
                              if (nameNonNullValue.isEmpty) {
                                return (" الرجاء ادخال اسم الطالب");
                              } else if (!nameRegex
                                  .hasMatch(nameNonNullValue)) {
                                return ("الرجاء ادخال اسم الطالب  ثلاثي");
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 70,
                          width: 750,
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            controller: _sphoneController,
                            decoration:
                                const InputDecoration(hintText: 'رقم الطالب'),
                            validator: (sphoneCurrentValue) {
                              var sphoneNonNullValue = sphoneCurrentValue ?? "";
                              if (sphoneNonNullValue.isEmpty) {
                                return ("الرجاء ادخال رقم الطالب");
                              } else if (!phoneRegex
                                  .hasMatch(sphoneNonNullValue)) {
                                return ("الرجاء ادخال رقم صحيح");
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 25),
                        SizedBox(
                          height: 70,
                          width: 750,
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            controller: _gphoneController,
                            decoration: const InputDecoration(
                                hintText: 'رقم ولي الامر'),
                            validator: (gphoneCurrentValue) {
                              var gphoneNonNullValue = gphoneCurrentValue ?? "";
                              if (gphoneNonNullValue.isEmpty) {
                                return ("الرجاء ادخال رقم ولي الامر    ");
                              } else if (!phoneRegex
                                  .hasMatch(gphoneNonNullValue)) {
                                return ("الرجاء ادخال رقم صحيح");
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 25),
                        SizedBox(
                          height: 70,
                          width: 550,
                          child: DropdownButtonFormField<String>(
                            focusColor: Colors.white,
                            autofocus: true,
                            value: _selectedChoice,
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedChoice = newValue!;
                              });
                            },
                            items: <String>[
                              'sat & tue11',
                              'sat & tue12',
                              'sat & tue13',
                              'sat & tue14',
                              'sat & tue15',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(
                          width: 500,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
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
                                _nameController.clear();
                                _sphoneController.clear();
                                _gphoneController.clear();
                              }
                            },
                            child: const Text('اضافه'),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Tab 1 -----------------------------
            Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () async {
                      // Read data from the database
                      List<Map> response =
                          await sqlDb.readData("SELECT * FROM 'satwtue11'");
                      // Update the data table source
                      setState(() {
                        dataRowsTab2 = response.map<DataRow>((row) {
                          return DataRow(cells: [
                            DataCell(Text(row['name'].toString())),
                            DataCell(Text(row['sPhone'].toString())),
                            DataCell(Text(row['gPhone'].toString())),
                            DataCell(
                              IconButton(
                                onPressed: () {
                                  _editData(row, 'satwtue11');
                                },
                                icon:
                                    Icon(Icons.edit), // Use the edit icon here
                              ),
                            ),
                            DataCell(
                              IconButton(
                                onPressed: () {
                                  _editData(row, 'satwtue11');
                                },
                                icon: Icon(
                                    Icons.delete), // Use the edit icon here
                              ),
                            ),
                          ]);
                        }).toList();
                      });
                    },
                    child: const Text('عرض بيانات المجموعه'),
                  ),
                ),
                SizedBox(height: 16.0),
                Expanded(
                  child: SingleChildScrollView(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('الاسم')),
                          DataColumn(label: Text('رقم الطالب')),
                          DataColumn(label: Text('رقم ولي الامر')),
                          DataColumn(label: Text('تعديل')),
                          DataColumn(label: Text('مسح')),
                        ],
                        rows: dataRowsTab2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Tap2-------------------------------------------------
            Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () async {
                      // Read data from the database
                      List<Map> response =
                          await sqlDb.readData("SELECT * FROM 'satwtue12'");
                      // Update the data table source
                      setState(() {
                        dataRowsTab2 = response.map<DataRow>((row) {
                          return DataRow(cells: [
                            DataCell(Text(row['name'].toString())),
                            DataCell(Text(row['sPhone'].toString())),
                            DataCell(Text(row['gPhone'].toString())),
                            DataCell(
                              IconButton(
                                onPressed: () {
                                  _editData(row, 'satwtue12');
                                },
                                icon:
                                    Icon(Icons.edit), // Use the edit icon here
                              ),
                            ),
                            DataCell(
                              IconButton(
                                onPressed: () {
                                  _editData(row, 'satwtue12');
                                },
                                icon: Icon(
                                    Icons.delete), // Use the edit icon here
                              ),
                            ),
                          ]);
                        }).toList();
                      });
                    },
                    child: const Text('عرض بيانات المجموعه'),
                  ),
                ),
                SizedBox(height: 16.0),
                Expanded(
                  child: SingleChildScrollView(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('الاسم')),
                          DataColumn(label: Text('رقم الطالب')),
                          DataColumn(label: Text('رقم ولي الامر')),
                          DataColumn(label: Text('تعديل')),
                          DataColumn(label: Text('مسح')),
                        ],
                        rows: dataRowsTab2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Tap3--------------------------------------------
            Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () async {
                      // Read data from the database
                      List<Map> response =
                          await sqlDb.readData("SELECT * FROM 'satwtue13'");
                      // Update the data table source
                      setState(() {
                        dataRowsTab2 = response.map<DataRow>((row) {
                          return DataRow(cells: [
                            DataCell(Text(row['name'].toString())),
                            DataCell(Text(row['sPhone'].toString())),
                            DataCell(Text(row['gPhone'].toString())),
                            DataCell(
                              IconButton(
                                onPressed: () {
                                  _editData(row, 'satwtue13');
                                },
                                icon: Icon(Icons.edit),
                              ),
                            ),
                            DataCell(
                              IconButton(
                                onPressed: () {
                                  _editData(row, 'satwtue13');
                                },
                                icon: Icon(Icons.delete),
                              ),
                            ),
                          ]);
                        }).toList();
                      });
                    },
                    child: const Text('عرض بيانات المجموعه'),
                  ),
                ),
                SizedBox(height: 16.0),
                Expanded(
                  child: SingleChildScrollView(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('الاسم')),
                          DataColumn(label: Text('رقم الطالب')),
                          DataColumn(label: Text('رقم ولي الامر')),
                          DataColumn(label: Text('تعديل')),
                          DataColumn(label: Text('مسح')),
                        ],
                        rows: dataRowsTab2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Tap4--------------------------
            Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () async {
                      // Read data from the database
                      List<Map> response =
                          await sqlDb.readData("SELECT * FROM 'satwtue14'");
                      // Update the data table source
                      setState(() {
                        dataRowsTab2 = response.map<DataRow>((row) {
                          return DataRow(cells: [
                            DataCell(Text(row['name'].toString())),
                            DataCell(Text(row['sPhone'].toString())),
                            DataCell(Text(row['gPhone'].toString())),
                            DataCell(
                              IconButton(
                                onPressed: () {
                                  _editData(row, 'satwtue14');
                                },
                                icon:
                                    Icon(Icons.edit), // Use the edit icon here
                              ),
                            ),
                            DataCell(
                              IconButton(
                                onPressed: () {
                                  _editData(row, 'satwtue14');
                                },
                                icon: Icon(
                                    Icons.delete), // Use the edit icon here
                              ),
                            ),
                          ]);
                        }).toList();
                      });
                    },
                    child: const Text('عرض بيانات المجموعه'),
                  ),
                ),
                SizedBox(height: 16.0),
                Expanded(
                  child: SingleChildScrollView(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('الاسم')),
                          DataColumn(label: Text('رقم الطالب')),
                          DataColumn(label: Text('رقم ولي الامر')),
                          DataColumn(label: Text('تعديل')),
                          DataColumn(label: Text('مسح')),
                        ],
                        rows: dataRowsTab2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Tap5-------------------
            Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () async {
                      // Read data from the database
                      List<Map> response =
                          await sqlDb.readData("SELECT * FROM 'satwtue15'");
                      // Update the data table source
                      setState(() {
                        dataRowsTab2 = response.map<DataRow>((row) {
                          return DataRow(cells: [
                            DataCell(Text(row['name'].toString())),
                            DataCell(Text(row['sPhone'].toString())),
                            DataCell(Text(row['gPhone'].toString())),
                            DataCell(
                              IconButton(
                                onPressed: () {
                                  _editData(row, 'satwtue15');
                                },
                                icon:
                                    Icon(Icons.edit), // Use the edit icon here
                              ),
                            ),
                            DataCell(
                              IconButton(
                                onPressed: () {
                                  _editData(row, 'satwtue15');
                                },
                                icon: Icon(
                                    Icons.delete), // Use the edit icon here
                              ),
                            ),
                          ]);
                        }).toList();
                      });
                    },
                    child: const Text('عرض بيانات المجموعه'),
                  ),
                ),
                SizedBox(height: 16.0),
                Expanded(
                  child: SingleChildScrollView(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('الاسم')),
                          DataColumn(label: Text('رقم الطالب')),
                          DataColumn(label: Text('رقم ولي الامر')),
                          DataColumn(label: Text('تعديل')),
                          DataColumn(label: Text('مسح')),
                        ],
                        rows: dataRowsTab2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
