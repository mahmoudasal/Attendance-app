import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class dailyAttend extends StatefulWidget {
  @override
  _dailyAttendState createState() => _dailyAttendState();
}

class _dailyAttendState extends State<dailyAttend> {
  String firstDropdownValue = '     الصف الاول الثانوي     ';
  String secondDropdownValue = '         سبت  و  ثلاثاء  الساعه 1:30         ';
  String? selectedItem;
  String? selectedItem1;
  int? editingRowIndex;
  String searchQuery = '';
  String newName = '';
  String newGphone = '';
  String newSphone = '';
  String newDropdownValue1 = '';
  String newDropdownValue2 = '';
  final _formKey = GlobalKey<FormState>();
  Map<String, List<String>> _choices = {
    '     الصف الاول الثانوي     ': [
      '         سبت  و  ثلاثاء  الساعه  1:30         ',
      '         سبت  و  ثلاثاء  الساعه  2:30         ',
      '         سبت  و  ثلاثاء  الساعه 3:30         '
    ],
    '     الصف الثاني الثانوي     ': [
      '         سبت  و  ثلاثاء  الساعه  4:30         ',
      '         سبت  و  ثلاثاء  الساعه  5:30         ',
      '         سبت  و  ثلاثاء  الساعه 6:30         '
    ],
    '     الصف الثالث الثانوي     ': [
      '         سبت  و  ثلاثاء  الساعه  7:30         ',
      '         سبت  و  ثلاثاء  الساعه  8:30         ',
      '         سبت  و  ثلاثاء  الساعه 9:30         '
    ]
  };

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Color(0xFF6F35A5),
            centerTitle: true,
            title: Text(
              'الغياب  و الدرجات ',
              style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
            )),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 300,
                    child: DropdownButtonFormField<String>(
                      focusColor: Colors.white,
                      validator: (newValue) => newValue == null ? 'الرجاء اختيار السنه الدراسيه' : null,
                      hint: Text("         السنه الدراسيه          "),
                      onChanged: (String? newValue) {
                        setState(() {
                          firstDropdownValue = newValue!;
                          selectedItem1 = null; // Reset the selected value of the second dropdown
                        });
                      },
                      items: <String>[
                        '     الصف الاول الثانوي     ',
                        '     الصف الثاني الثانوي     ',
                        '     الصف الثالث الثانوي     '
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                      width: 300,
                      child: DropdownButtonFormField<String>(
                        focusColor: Colors.white,
                        validator: (value1) => value1 == null ? 'الرجاء اختيار المجموعه' : null,
                        hint: Text("         ادخل المجموعه         "),
                        onChanged: (String? value1) {
                          setState(() {
                            selectedItem1 = value1; // update the selected item value
                          });
                        },
                        value: selectedItem1,
                        items: _choices[firstDropdownValue]?.map<DropdownMenuItem<String>>((String? value1) {
                          return DropdownMenuItem<String>(
                            value: value1,
                            child: Text(value1!),
                          );
                        }).toList(),
                      )),
                  SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                      width: 500,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text('get Data'),
                      )),
                  Container(
                    padding: EdgeInsets.all(15.0),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: FutureBuilder<SharedPreferences>(
                      future: SharedPreferences.getInstance(),
                      builder: (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
                        if (snapshot.hasData) {
                          List<DataRow> rows = [];

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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
