import 'package:flutter/material.dart';

class DropDownButton extends StatelessWidget {
  DropDownButton(
      {Key? key,
        required this.listItem,
        this.selectedVal = '',
        required this.onChanged})
      : super(key: key) {
    selectedVal = listItem.first;
  }
  List listItem;
  String selectedVal;
  final ValueChanged onChanged;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        value: selectedVal,
        items: listItem
            .map((e) => DropdownMenuItem(
          child: Text(e),
          value: e,
        ))
            .toList(),
        icon: const Icon(
          Icons.arrow_drop_down_circle,
          color: Colors.deepPurple,
        ),
        dropdownColor: Colors.deepPurple.shade50,
        decoration: InputDecoration(
            labelText: selectedVal,
            prefixIcon: Icon(
              Icons.accessibility_new_rounded,
              color: Colors.deepPurple,
            ),
            border: OutlineInputBorder()),
        onChanged: onChanged
      //   (val){
      // setSteat((){
      //   selectedVal=val as String;
      // });

    );
  }
}