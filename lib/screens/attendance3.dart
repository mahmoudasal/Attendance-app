// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';

// class AttendanceScreen extends StatefulWidget {
//   @override
//   _AttendanceScreenState createState() => _AttendanceScreenState();
// }

// class _AttendanceScreenState extends State<AttendanceScreen> {
//   final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

//   List<Map<String, dynamic>> _data = [];

//   final Map<String, dynamic> _formData = {
    
//     'isPresent': false,
//   };

  

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
     
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
            
//               itemBuilder: (BuildContext context, int index) {
//                 final employee = _data[index];
//                 return CheckboxListTile(
//                   value: employee['isPresent'],
//                   onChanged: (newValue) {
//                     setState(() {
//                       employee['isPresent'] = newValue;
//                     });
//                   },
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.all(10),
//             child: FormBuilder(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   FormBuilderCheckbox(
//                     name: 'isPresent',
//                     title: Text('Present'),
//                     initialValue: false,
//                   ),
//                   SizedBox(height: 10),
//                   ElevatedButton(
//                     onPressed: _saveForm,
//                     child: Text('Save'),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
