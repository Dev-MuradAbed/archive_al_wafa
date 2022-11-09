import 'package:flutter/material.dart';

class CheckBox extends StatefulWidget {
  CheckBox({
    Key? key,
    required this.titleCheckBok,
    required this.checkBox,
  }) : super(key: key);
  String titleCheckBok = '';
  bool? checkBox = false;

  @override
  State<CheckBox> createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        title: Text(widget.titleCheckBok),
        activeColor: Colors.white,
        checkColor: Colors.deepPurple,
        tristate: true,
        value: widget.checkBox,
        onChanged: (val) {
          setState(() {
            widget.checkBox = val;
          });
        });
  }
}
