import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField(
      {Key? key,
        required this.myController,
        required this.fieldName,
        required this.myIcon,
        required this.prefixIconColor,
        this.keyboardType,
        this.maxLines=1})
      : super(key: key);
  final TextEditingController myController;
  final String fieldName;
  final IconData myIcon;
  final Color prefixIconColor;
  final TextInputType?  keyboardType;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: TextFormField(
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          } else {
            null;
          }
        },
        controller: myController,
        decoration: InputDecoration(
            labelText: fieldName,
            prefixIcon: Icon(
              myIcon,
              color: prefixIconColor,
            ),
            border: const OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.deepPurple.shade300),
            ),
            labelStyle: const TextStyle(color: Colors.deepPurple)),
      ),
    );
  }
}