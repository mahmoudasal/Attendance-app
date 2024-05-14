import 'package:el_zareef_app/sqlDb.dart';
import 'package:flutter/material.dart';

class CustomDataTable extends StatefulWidget {
  final String tableName;
  final Function editData;

  CustomDataTable({required this.tableName, required this.editData});

  @override
  _CustomDataTableState createState() => _CustomDataTableState();
}

class _CustomDataTableState extends State<CustomDataTable> {
  List<DataRow> dataRowsTab2 = [];
  SqlDb sqlDb = SqlDb();

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  await sqlDb.readData("SELECT * FROM '${widget.tableName}'");
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
                          widget.editData(row, widget.tableName);
                        },
                        icon: Icon(Icons.edit),
                      ),
                    ),
                    DataCell(
                      IconButton(
                        onPressed: () {
                          widget.editData(row, widget.tableName);
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
    );
  }
}
