// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, annotate_overrides

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/student.dart';

class Sec2 extends StatefulWidget {
  _Sec2State createState() => _Sec2State();
}

class _Sec2State extends State<Sec2> with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _gphoneController = TextEditingController();
  final TextEditingController _sphoneController = TextEditingController();
  static final RegExp nameRegex = RegExp(r'^[\u0621-\u064A]+\s[\u0621-\u064A]+\s[\u0621-\u064A]+$');
  static final RegExp phoneRegex = RegExp(r'^01[0125][0-9]{8}$');
  late TabController _tabController;

  String _selectedChoice = 'sat & tue6';

  late final Box<Student> _studentsBox6;
  late final Box<Student> _studentsBox7;
  late final Box<Student> _studentsBox8;
  late final Box<Student> _studentsBox9;
  late final Box<Student> _studentsBox10;

  @override
  void initState() {
    super.initState();

    _studentsBox6 = Hive.box<Student>('sat&tue6');
    _studentsBox7 = Hive.box<Student>('sat&tue7');
    _studentsBox8 = Hive.box<Student>('sat&tue8');
    _studentsBox9 = Hive.box<Student>('sat&tue9');
    _studentsBox10 = Hive.box<Student>('sat&tue10');

    _tabController = TabController(length: 6, vsync: this);
  }

  Future<void> editStudent(Box<Student> box, int index, Student studentParameter) async {
    final student = box.getAt(index) as Student;

    _nameController.text = student.name;
    _gphoneController.text = student.gphone.toString();
    _sphoneController.text = student.sphone.toString();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('تعديل بيانات الطالب'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey1,
              child: Column(
                children: [
                  TextFormField(
                    textAlign: TextAlign.center,
                    controller: _nameController,
                    decoration: const InputDecoration(hintText: 'اسم الطالب'),
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
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 70,
                    width: 750,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: _gphoneController,
                      decoration: const InputDecoration(hintText: 'رقم ولي الامر '),
                      validator: (sphoneCurrentValue) {
                        var sphoneNonNullValue = sphoneCurrentValue ?? "";
                        if (sphoneNonNullValue.isEmpty) {
                          return ("الرجاء ادخال رقم ولي الامر    ");
                        } else if (!phoneRegex.hasMatch(sphoneNonNullValue)) {
                          return ("الرجاء ادخال رقم صحيح");
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      height: 70,
                      width: 750,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        controller: _sphoneController,
                        decoration: const InputDecoration(hintText: 'رقم الطالب'),
                        validator: (sphoneCurrentValue) {
                          var sphoneNonNullValue = sphoneCurrentValue ?? "";
                          if (sphoneNonNullValue.isEmpty) {
                            return ("الرجاء ادخال رقم الطالب");
                          } else if (!nameRegex.hasMatch(sphoneNonNullValue)) {
                            return ("الرجاء ادخال رقم صحيح");
                          }
                          return null;
                        },
                      )),
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
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_formKey1.currentState!.validate()) {
                  final updatedStudent = Student(
                    name: _nameController.text,
                    gphone: int.parse(_gphoneController.text),
                    sphone: int.parse(_sphoneController.text),
                  );

                  box.putAt(index, updatedStudent);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Student data updated successfully!'),
                    ),
                  );

                  _nameController.clear();
                  _gphoneController.clear();
                  _sphoneController.clear();

                  Navigator.of(context).pop();
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void deleteStudent(Box<Student> box, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Student'),
          content: const Text('Are you sure you want to delete this student?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                box.deleteAt(index); // Remove student from the box
                setState(() {});

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Student deleted successfully!'),
                  ),
                );

                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
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
    // Get the selected box based on the dropdown value
    Box<Student> selectedBox;
    switch (_selectedChoice) {
      case 'sat & tue6':
        selectedBox = _studentsBox6;
        break;
      case 'sat & tue7':
        selectedBox = _studentsBox7;
        break;
      case 'sat & tue8':
        selectedBox = _studentsBox8;
        break;
      case 'sat & tue9':
        selectedBox = _studentsBox9;
        break;
      case 'sat & tue10':
        selectedBox = _studentsBox10;
        break;
      default:
        selectedBox = _studentsBox6; // Default to the first box
    }

    await selectedBox.add(student);

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
          backgroundColor: const Color(0xFF6F35A5),
          centerTitle: true,
          title: const Text(
            'الصف الثاني الثانوي ',
            style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
          ),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'تسجيل طالب جديد'),
              Tab(text: 'sat & tue6'),
              Tab(text: 'sat & tue7'),
              Tab(text: 'sat & tue8'),
              Tab(text: 'sat & tue9'),
              Tab(text: 'sat & tue10'),
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
                        const SizedBox(
                          height: 100,
                        ),
                        SizedBox(
                          height: 70,
                          width: 750,
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            controller: _nameController,
                            decoration: const InputDecoration(hintText: 'اسم الطالب'),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 70,
                          width: 750,
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            controller: _sphoneController,
                            decoration: const InputDecoration(hintText: 'رقم الطالب'),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        SizedBox(
                          height: 70,
                          width: 750,
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            controller: _gphoneController,
                            decoration: const InputDecoration(hintText: 'رقم ولي الامر'),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
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
                              'sat & tue6',
                              'sat & tue7',
                              'sat & tue8',
                              'sat & tue9',
                              'sat & tue10',
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
                                addStudent();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('تمت إضافة بيانات الطالب بنجاح!'),
                                  ),
                                );
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
            // Tab 2 - Student List
            Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: _studentsBox6.length,
                    separatorBuilder: (context, index) => const Divider(), // Add a divider between list items
                    itemBuilder: (context, index) {
                      final student = _studentsBox6.getAt(index) as Student;
                      return ListTile(
                        title: Text(student.name),
                        subtitle: Text(
                          ' رقم الطالب: ${student.sphone} , رقم ولي الأمر: ${student.gphone}',
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => editStudent(_studentsBox6, index, student),
                            ),
                            IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  deleteStudent(_studentsBox6, index);
                                  setState(() {});
                                }),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: _studentsBox7.length,
                    separatorBuilder: (context, index) => const Divider(), // Add a divider between list items
                    itemBuilder: (context, index) {
                      final student = _studentsBox7.getAt(index) as Student;
                      return ListTile(
                        title: Text(student.name),
                        subtitle: Text(
                          ' رقم الطالب: ${student.sphone} , رقم ولي الأمر: ${student.gphone}',
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => editStudent(_studentsBox7, index, student),
                            ),
                            IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  deleteStudent(_studentsBox7, index);
                                  setState(() {});
                                }),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: _studentsBox8.length,
                    separatorBuilder: (context, index) => const Divider(), // Add a divider between list items
                    itemBuilder: (context, index) {
                      final student = _studentsBox8.getAt(index) as Student;
                      return ListTile(
                        title: Text(student.name),
                        subtitle: Text(
                          ' رقم الطالب: ${student.sphone} , رقم ولي الأمر: ${student.gphone}',
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => editStudent(_studentsBox8, index, student),
                            ),
                            IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  deleteStudent(_studentsBox8, index);
                                  setState(() {});
                                }),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: _studentsBox9.length,
                    separatorBuilder: (context, index) => const Divider(), // Add a divider between list items
                    itemBuilder: (context, index) {
                      final student = _studentsBox9.getAt(index) as Student;
                      return ListTile(
                        title: Text(student.name),
                        subtitle: Text(
                          ' رقم الطالب: ${student.sphone} , رقم ولي الأمر: ${student.gphone}',
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => editStudent(_studentsBox9, index, student),
                            ),
                            IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  deleteStudent(_studentsBox9, index);
                                  setState(() {});
                                }),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: _studentsBox10.length,
                    separatorBuilder: (context, index) => const Divider(), // Add a divider between list items
                    itemBuilder: (context, index) {
                      final student = _studentsBox10.getAt(index) as Student;
                      return ListTile(
                        title: Text(student.name),
                        subtitle: Text(
                          ' رقم الطالب: ${student.sphone} , رقم ولي الأمر: ${student.gphone}',
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => editStudent(_studentsBox10, index, student),
                            ),
                            IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  deleteStudent(_studentsBox10, index);
                                  setState(() {});
                                }),
                          ],
                        ),
                      );
                    },
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
