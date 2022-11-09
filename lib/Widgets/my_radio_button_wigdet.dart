import 'package:flutter/material.dart';

enum Gendar {Male, Female}

class MyRadioButton extends StatelessWidget {
  // (val){
  // setState(() {
  // _gendar=val;
  // });
  // })
  MyRadioButton(
      {Key? key,
        required this.title,
        required this.value,
        required this.gendar,
        required this.onChanged})
      : super(key: key);
  String title;
  Gendar value;
  Gendar? gendar;
  Function(Gendar?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: RadioListTile<Gendar>(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0)),
          dense: true,
          // tileColor: Colors.deepPurple.shade50,
          contentPadding: EdgeInsets.all(0),
          title: Text(title),
          value: value,
          groupValue: gendar,
          onChanged: onChanged,
        ));
  }
}