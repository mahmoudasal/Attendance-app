import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class sec1Page extends StatelessWidget {
  sec1Page({super.key});
  final List<Map<String, dynamic>> _sec1data = [];
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF6F35A5),
            centerTitle: true,
            title: Text('الصف الاول الثانوي',
              style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
            ),
          ),
          body: Center(
            child: Column(
              children: [
                DataTable(
                  columns: [
                    DataColumn(label: Text('الاسم')),
                    DataColumn(label: Text('رقم الطالب')),
                    DataColumn(label: Text('رقم ولي الامر')),
                    DataColumn(label: Text('المجموعه')),
                    DataColumn(label: Text('السنه الدراسيه')),
                    DataColumn(label: Text('')),
                  ],
                  rows: _sec1data
                      .asMap()
                      .map(
                        (index, data) => MapEntry(
                          index,
                          DataRow(
                            cells: [
                              DataCell(Text(data['name'].toString())),
                              DataCell(Text(data['sphone'].toString())),
                              DataCell(Text(data['phone'].toString())),
                              DataCell(Text(data['classs'].toString())),
                              DataCell(Text(data['yearOfStudy'].toString())),
                              DataCell(
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .values
                      .toList(),
                ),
              ],
            ),
          )),
    );
  }
}
