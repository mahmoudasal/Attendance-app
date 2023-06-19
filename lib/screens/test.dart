// DataRow buildEditingRow(String timestamp, String name, String gphone, String sphone, String dropdownValue1, String dropdownValue2) {
//   return DataRow(cells: [
//     DataCell(TextFormField(
//       validator: (nameCurrentValue) {
//         RegExp regex = RegExp(r'^[\u0621-\u064A]+\s[\u0621-\u064A]+\s[\u0621-\u064A]+$');
//         var nameNonNullValue = nameCurrentValue ?? "";
//         if (nameNonNullValue.isEmpty) {
//           return (" الرجاء ادخال اسم الطالب");
//         } else if (!regex.hasMatch(nameNonNullValue)) {
//           return ("الرجاء ادخال اسم الطالب  ثلاثي");
//         }
//         return null;
//       },
//       initialValue: name,
//       onChanged: (value) {},
//     )),
//     DataCell(TextFormField(
//       validator: (sphoneCurrentValue) {
//         RegExp regex = RegExp(r'^01[0125][0-9]{8}$');
//         var sphoneNonNullValue = sphoneCurrentValue ?? "";
//         if (sphoneNonNullValue.isEmpty) {
//           return ("الرجاء ادخال رقم ولي الامر    ");
//         } else if (!regex.hasMatch(sphoneNonNullValue)) {
//           return ("الرجاء ادخال رقم صحيح");
//         }
//         return null;
//       },
//       initialValue: gphone,
//       onChanged: (value) {},
//     )),
//     DataCell(TextFormField(
//       validator: (sphoneCurrentValue) {
//         RegExp regex = RegExp(r'^01[0125][0-9]{8}$');
//         var sphoneNonNullValue = sphoneCurrentValue ?? "";
//         if (sphoneNonNullValue.isEmpty) {
//           return ("الرجاء ادخال رقم الطالب");
//         } else if (!regex.hasMatch(sphoneNonNullValue)) {
//           return ("الرجاء ادخال رقم صحيح");
//         }
//         return null;
//       },
//       initialValue: sphone,
//       onChanged: (value) {},
//     )),
//     DataCell(TextFormField(
//       initialValue: dropdownValue1,
//       onChanged: (value) {},
//     )),
//     DataCell(TextFormField(
//       initialValue: dropdownValue2,
//       onChanged: (value) {},
//     )),
//     DataCell(
//       IconButton(
//         icon: Icon(Icons.save),
//         onPressed: () {
//           _saveData(timestamp);
//         },
//       ),
//     ),
//     DataCell(
//       IconButton(
//           icon: Icon(Icons.cancel),
//           onPressed: () {
//             setState(() {
//               editingRowIndex = null;
//             });
//           }),
//     )
//   ]);
// }
