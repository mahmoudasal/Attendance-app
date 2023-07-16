// ignore_for_file: library_private_types_in_public_api, annotate_overrides, unused_field, unused_local_variable

import 'package:el_zareef_app/sqlDb.dart';
import 'package:flutter/material.dart';

class Sec1 extends StatefulWidget {
  const Sec1({super.key});

  _Sec1State createState() => _Sec1State();
}

class _Sec1State extends State<Sec1> with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _gphoneController = TextEditingController();
  final TextEditingController _sphoneController = TextEditingController();

  late TabController _tabController;

  String _selectedChoice = 'sat & tue1';

  static final RegExp nameRegex =
      RegExp(r'^[\u0621-\u064A]+\s[\u0621-\u064A]+\s[\u0621-\u064A]+$');
  static final RegExp phoneRegex = RegExp(r'^01[0125][0-9]{8}$');
  SqlDb sqlDb = SqlDb();
  String name = 'mahmoud asalll';
  int sPhone = 123456789;
  int gPhone = 987654321;
  String sql =
      "INSERT INTO 'studentList' ('name', 'sPhone', 'gPhone') VALUES (?, ?, ?)";

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _sphoneController.dispose();
    _gphoneController.dispose();
    _tabController.dispose();

    super.dispose();
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
                            decoration:
                                const InputDecoration(hintText: 'اسم الطالب'),
                            validator: (nameCurrentValue) {
                              RegExp regex = RegExp(
                                  r'^[\u0621-\u064A]+\s[\u0621-\u064A]+\s[\u0621-\u064A]+$');
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
                              decoration:
                                  const InputDecoration(hintText: 'رقم الطالب'),
                              validator: (sphoneCurrentValue) {
                                var sphoneNonNullValue =
                                    sphoneCurrentValue ?? "";
                                if (sphoneNonNullValue.isEmpty) {
                                  return ("الرجاء ادخال رقم الطالب");
                                } else if (!phoneRegex
                                    .hasMatch(sphoneNonNullValue)) {
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
                            decoration: const InputDecoration(
                                hintText: 'رقم ولي الامر '),
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
                            onPressed: () async {
                              int response = await sqlDb.insertData(
                                  sql, name, sPhone, gPhone);

                              // if (_formKey.currentState!.validate()) {
                              //   addStudent();
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //     const SnackBar(
                              //       content:
                              //           Text('تمت إضافة بيانات الطالب بنجاح!'),
                              //     ),
                              //   );
                              // }
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
            Column(),
            // Tap2-------------------------------------------------
            Column(),
            // Tap3--------------------------------------------
            Column(),
            // Tap4--------------------------
            Column(),
            // Tap5-------------------
            Column(),
          ],
        ),
      ),
    );
  }
}
