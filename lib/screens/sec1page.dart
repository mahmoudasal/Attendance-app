// ignore_for_file: library_private_types_in_public_api, annotate_overrides

import 'package:el_zareef_app/models/student.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Sec1 extends StatefulWidget {
  const Sec1({super.key});

  _Sec1State createState() => _Sec1State();
}

class _Sec1State extends State<Sec1> with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _gphoneController = TextEditingController();
  final TextEditingController _sphoneController = TextEditingController();

  late TabController _tabController;

  String _selectedChoice = 'sat & tue1';

  late final Box<Student> _studentsBox1;
  late final Box<Student> _studentsBox2;
  late final Box<Student> _studentsBox3;
  late final Box<Student> _studentsBox4;
  late final Box<Student> _studentsBox5;

  static final RegExp nameRegex = RegExp(r'^[\u0621-\u064A]+\s[\u0621-\u064A]+\s[\u0621-\u064A]+$');
  static final RegExp phoneRegex = RegExp(r'^01[0125][0-9]{8}$');

  @override
  void initState() {
    super.initState();
    _studentsBox1 = Hive.box<Student>('sat&tue1');
    _studentsBox2 = Hive.box<Student>('sat&tue2');
    _studentsBox3 = Hive.box<Student>('sat&tue3');
    _studentsBox4 = Hive.box<Student>('sat&tue4');
    _studentsBox5 = Hive.box<Student>('sat&tue5');

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
                      var nameNonNullValue = nameCurrentValue ?? "";
                      if (nameNonNullValue.isEmpty) {
                        return (" الرجاء ادخال اسم الطالب");
                      } else if (!nameRegex.hasMatch(nameNonNullValue)) {
                        return ("الرجاء ادخال اسم الطالب  ثلاثي");
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    textAlign: TextAlign.center,
                    controller: _gphoneController,
                    decoration: const InputDecoration(hintText: 'رقم ولي الامر '),
                    validator: (gphoneCurrentValue) {
                      RegExp regex = RegExp(r'^01[0125][0-9]{8}$');
                      var gphoneNonNullValue = gphoneCurrentValue ?? "";
                      if (gphoneNonNullValue.isEmpty) {
                        return ("الرجاء ادخال رقم ولي الامر    ");
                      } else if (!regex.hasMatch(gphoneNonNullValue)) {
                        return ("الرجاء ادخال رقم صحيح");
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    textAlign: TextAlign.center,
                    controller: _sphoneController,
                    decoration: const InputDecoration(hintText: 'رقم الطالب'),
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
                  )
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
      case 'sat & tue1':
        selectedBox = _studentsBox1;
        break;
      case 'sat & tue2':
        selectedBox = _studentsBox2;
        break;
      case 'sat & tue3':
        selectedBox = _studentsBox3;
        break;
      case 'sat & tue4':
        selectedBox = _studentsBox4;
        break;
      case 'sat & tue5':
        selectedBox = _studentsBox5;
        break;
      default:
        selectedBox = _studentsBox1; // Default to the first box
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
            'الصف الاول الثانوي ',
            style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
          ),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'تسجيل طالب جديد'),
              Tab(text: 'sat & tue1'),
              Tab(text: 'sat & tue2'),
              Tab(text: 'sat & tue3'),
              Tab(text: 'sat & tue4'),
              Tab(text: 'sat & tue5'),
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
                                } else if (!phoneRegex.hasMatch(sphoneNonNullValue)) {
                                  return ("الرجاء ادخال رقم صحيح");
                                }
                                return null;
                              },
                            )),
                        const SizedBox(
                          height: 25,
                        ),
                        SizedBox(
                          height: 70,
                          width: 750,
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            controller: _gphoneController,
                            decoration: const InputDecoration(hintText: 'رقم ولي الامر '),
                            validator: (gphoneCurrentValue) {
                              var gphoneNonNullValue = gphoneCurrentValue ?? "";
                              if (gphoneNonNullValue.isEmpty) {
                                return ("الرجاء ادخال رقم ولي الامر    ");
                              } else if (!phoneRegex.hasMatch(gphoneNonNullValue)) {
                                return ("الرجاء ادخال رقم صحيح");
                              }
                              return null;
                            },
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
                              'sat & tue1',
                              'sat & tue2',
                              'sat & tue3',
                              'sat & tue4',
                              'sat & tue5',
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
            // Tab 1 -----------------------------
            Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: _studentsBox1.length,
                    separatorBuilder: (context, index) => const Divider(), // Add a divider between list items
                    itemBuilder: (context, index) {
                      final student = _studentsBox1.getAt(index) as Student;
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
                              onPressed: () => editStudent(_studentsBox1, index, student),
                            ),
                            IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  deleteStudent(_studentsBox1, index);
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
            // Tap2-------------------------------------------------
            Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: _studentsBox2.length,
                    separatorBuilder: (context, index) => const Divider(), // Add a divider between list items
                    itemBuilder: (context, index) {
                      final student = _studentsBox2.getAt(index) as Student;
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
                              onPressed: () => editStudent(_studentsBox2, index, student),
                            ),
                            IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  deleteStudent(_studentsBox2, index);
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
            // Tap3--------------------------------------------
            Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: _studentsBox3.length,
                    separatorBuilder: (context, index) => const Divider(), // Add a divider between list items
                    itemBuilder: (context, index) {
                      final student = _studentsBox3.getAt(index) as Student;
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
                              onPressed: () => editStudent(_studentsBox3, index, student),
                            ),
                            IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  deleteStudent(_studentsBox3, index);
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
            // Tap4--------------------------
            Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: _studentsBox4.length,
                    separatorBuilder: (context, index) => const Divider(), // Add a divider between list items
                    itemBuilder: (context, index) {
                      final student = _studentsBox4.getAt(index) as Student;
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
                              onPressed: () => editStudent(_studentsBox4, index, student),
                            ),
                            IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  deleteStudent(_studentsBox4, index);
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
            // Tap5-------------------
            Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: _studentsBox5.length,
                    separatorBuilder: (context, index) => const Divider(), // Add a divider between list items
                    itemBuilder: (context, index) {
                      final student = _studentsBox5.getAt(index) as Student;
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
                              onPressed: () => editStudent(_studentsBox5, index, student),
                            ),
                            IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  deleteStudent(_studentsBox5, index);
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
