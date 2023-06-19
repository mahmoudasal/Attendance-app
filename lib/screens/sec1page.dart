// ignore_for_file: must_be_immutable, unused_import, unused_field
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/student.dart';
import 'package:flutter/scheduler.dart';

class Sec1 extends StatefulWidget {
  _Sec1State createState() => _Sec1State();
}

class _Sec1State extends State<Sec1> with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _gphoneController = TextEditingController();
  final TextEditingController _sphoneController = TextEditingController();
  late Box<Student> _studentsBox;
  late ValueListenable<Box<Student>> _studentsListenable;
  int _selectedIndex = -1;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _studentsBox = Hive.box<Student>('students1');
    _studentsListenable = _studentsBox.listenable();
    _tabController = TabController(length: 4, vsync: this);
  }

  Future<void> editStudent(int index, Student student) async {
    final student = _studentsBox.getAt(index) as Student;

    _nameController.text = student.name;
    _gphoneController.text = student.gphone.toString();
    _sphoneController.text = student.sphone.toString();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Student'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey1,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'الاسم'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'الرجاء ادخل اسم الطالب ';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _gphoneController,
                    decoration: InputDecoration(labelText: 'رقم ولي الامر'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'ادخل رقم ولي الامر';
                      }
                      if (int.tryParse(value) == null) {
                        return 'رقم غير صالح';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _sphoneController,
                    decoration: InputDecoration(labelText: 'رقم الطالب '),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'الرجاء ادخال رقم الطالب';
                      }
                      if (int.tryParse(value) == null) {
                        return 'رقم غير صحيح';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _nameController.clear();
                _gphoneController.clear();
                _sphoneController.clear();

                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_formKey1.currentState!.validate()) {
                  final updatedStudent = Student(
                    name: _nameController.text,
                    gphone: int.parse(_gphoneController.text),
                    sphone: int.parse(_sphoneController.text),
                  );

                  _studentsBox.putAt(index, updatedStudent);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Student data updated successfully!'),
                    ),
                  );

                  _nameController.clear();
                  _gphoneController.clear();
                  _sphoneController.clear();

                  Navigator.of(context).pop();
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteStudent(int index) async {
    await _studentsBox.deleteAt(index);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Student data deleted successfully!'),
      ),
    );
    _nameController.clear();
    _gphoneController.clear();
    _sphoneController.clear();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _sphoneController.dispose();
    _gphoneController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  Future<void> addStudent() async {
    final student = Student(
      name: _nameController.text,
      gphone: int.parse(_gphoneController.text),
      sphone: int.parse(_sphoneController.text),
    );

    // await _studentsBox.clear(); // Clear the box before adding new data
    await _studentsBox.add(student);

    setState(() {
      _nameController.clear();
      _gphoneController.clear();
      _sphoneController.clear();
    });
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
          ),
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: 'اضافه طالب'),
              Tab(text: 'سبت و ثلاثاء 2:30'),
              Tab(text: 'احد واربعاء 3:30'),
              Tab(text: 'اثنين و خميس 4:30'),
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
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 100,
                        ),
                        SizedBox(
                          height: 70,
                          width: 750,
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            controller: _nameController,
                            decoration: InputDecoration(hintText: 'اسم الطالب'),
                            // validator: (nameCurrentValue) {
                            //   RegExp regex = RegExp(r'^[\u0621-\u064A]+\s[\u0621-\u064A]+\s[\u0621-\u064A]+$');
                            //   var nameNonNullValue = nameCurrentValue ?? "";
                            //   if (nameNonNullValue.isEmpty) {
                            //     return (" الرجاء ادخال اسم الطالب");
                            //   } else if (!regex.hasMatch(nameNonNullValue)) {
                            //     return ("الرجاء ادخال اسم الطالب  ثلاثي");
                            //   }
                            //   return null;
                            // }
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
                              // validator: (sphoneCurrentValue) {
                              //   RegExp regex = RegExp(r'^01[0125][0-9]{8}$');
                              //   var sphoneNonNullValue = sphoneCurrentValue ?? "";
                              //   if (sphoneNonNullValue.isEmpty) {
                              //     return ("الرجاء ادخال رقم الطالب");
                              //   } else if (!regex.hasMatch(sphoneNonNullValue)) {
                              //     return ("الرجاء ادخال رقم صحيح");
                              //   }
                              //   return null;
                              // },
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
                            // validator: (sphoneCurrentValue) {
                            //   RegExp regex = RegExp(r'^01[0125][0-9]{8}$');
                            //   var sphoneNonNullValue = sphoneCurrentValue ?? "";
                            //   if (sphoneNonNullValue.isEmpty) {
                            //     return ("الرجاء ادخال رقم ولي الامر    ");
                            //   } else if (!regex.hasMatch(sphoneNonNullValue)) {
                            //     return ("الرجاء ادخال رقم صحيح");
                            //   }
                            //   return null;
                            // },
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
                                addStudent();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('تمت إضافة بيانات الطالب بنجاح!'),
                                  ),
                                );
                              }
                            },
                            child: Text('Add Data'),
                          ),
                        ),
                        SizedBox(height: 16.0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // tap2 -------------------------------------------------------------------------------------------------------------------------------
            Container(
              child: ListView.builder(
                itemCount: _studentsBox.length,
                itemBuilder: (context, index) {
                  final student = _studentsBox.getAt(index) as Student;
                  return ListTile(
                    title: Text(student.name),
                    subtitle: Text(
                      'رقم ولي الأمر: ${student.gphone}, رقم الطالب: ${student.sphone}',
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => editStudent(index, student),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => deleteStudent(index),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            // tap3 -------------------------------------------------------------------------------------------------------------------------------
            Container(
              child: ListView.builder(
                itemCount: _studentsBox.length,
                itemBuilder: (context, index) {
                  final student = _studentsBox.getAt(index) as Student;
                  return ListTile(
                    title: Text(student.name),
                    subtitle: Text(
                      'رقم ولي الأمر: ${student.gphone}, رقم الطالب: ${student.sphone}',
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => editStudent(index, student),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => deleteStudent(index),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            // tap4 -------------------------------------------------------------------------------------------------------------------------------
            Container(
              child: ListView.builder(
                itemCount: _studentsBox.length,
                itemBuilder: (context, index) {
                  final student = _studentsBox.getAt(index) as Student;
                  return ListTile(
                    title: Text(student.name),
                    subtitle: Text(
                      'رقم ولي الأمر: ${student.gphone}, رقم الطالب: ${student.sphone}',
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => editStudent(index, student),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => deleteStudent(index),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
