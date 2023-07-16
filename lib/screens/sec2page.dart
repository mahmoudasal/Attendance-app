// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, annotate_overrides, unused_field

import 'package:flutter/material.dart';

class Sec2 extends StatefulWidget {
  _Sec2State createState() => _Sec2State();
}

class _Sec2State extends State<Sec2> with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _gphoneController = TextEditingController();
  final TextEditingController _sphoneController = TextEditingController();
  static final RegExp phoneRegex = RegExp(r'^01[0125][0-9]{8}$');
  late TabController _tabController;

  String _selectedChoice = 'sat & tue6';

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
                            decoration:
                                const InputDecoration(hintText: 'اسم الطالب'),
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
                            decoration: const InputDecoration(
                                hintText: 'رقم ولي الامر'),
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
                              // if (_formKey.currentState!.validate()) {

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
            // Tab 2 - Student List
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
