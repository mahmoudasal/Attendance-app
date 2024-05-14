import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String emptyValueError;
  final String validationError;
  final RegExp regex;

  CustomTextField({
    required this.controller,
    required this.hintText,
    required this.emptyValueError,
    required this.validationError,
    required this.regex,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: 750,
      child: TextFormField(
        textAlign: TextAlign.center,
        controller: controller,
        decoration: InputDecoration(hintText: hintText),
        validator: (currentValue) {
          var nonNullValue = currentValue ?? "";
          if (nonNullValue.isEmpty) {
            return emptyValueError;
          } else if (!regex.hasMatch(nonNullValue)) {
            return validationError;
          }
          return null;
        },
      ),
    );
  }
}

class CustomDropdown extends StatefulWidget {
  final List<String> items;
  final String selectedChoice;

  CustomDropdown({
    required this.items,
    required this.selectedChoice,
  });

  @override
  _CustomDropdownState createState() => _CustomDropdownState(selectedChoice);
}

class _CustomDropdownState extends State<CustomDropdown> {
  String selectedChoice;

  _CustomDropdownState(this.selectedChoice);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: 550,
      child: DropdownButtonFormField<String>(
        focusColor: Colors.white,
        autofocus: true,
        value: selectedChoice,
        onChanged: (String? newValue) {
          setState(() {
            selectedChoice = newValue!;
          });
        },
        items: widget.items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
