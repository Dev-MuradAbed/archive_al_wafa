import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Widgets/my_button_widget.dart';
import '../Widgets/my_radio_button_wigdet.dart';
import '../Widgets/my_text_field_widget.dart';
import '../providers/speak_get.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final name = TextEditingController();
  final barthDay = TextEditingController();
  final address = TextEditingController();
  final phoneNumber = TextEditingController();
  final idNumber = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  Gendar? _gendar;

  @override
  Widget build(BuildContext context) {
    var c = Get.put(SpeakGet());
    return ListView(
      shrinkWrap: true,
      children: [
        Form(
            key: _formKey,
            child: Column(
              children: [
                MyTextField(
                    myController: name,
                    fieldName: "اسم الحالة",
                    myIcon: Icons.propane_outlined,
                    prefixIconColor: Colors.deepPurple.shade300),
                MyTextField(
                    myController: barthDay,
                    fieldName: "تاريخ الميلاد",
                    myIcon: Icons.description_outlined,
                    prefixIconColor: Colors.deepPurple.shade300),
                MyTextField(
                    myController: address,
                    fieldName: "العنوان",
                    myIcon: Icons.description_outlined,
                    prefixIconColor: Colors.deepPurple.shade300),
                Row(
                  children: [
                    MyRadioButton(
                        title: 'ذكر', value: Gendar.Male, gendar: _gendar, onChanged: (val){
                      setState(() {
                        // print(val);
                        print(val!.name);
                        _gendar=val;
                      });
                    }),
                    SizedBox(width: 5,),
                    MyRadioButton(
                        title: 'انثى', value: Gendar.Female, gendar: _gendar, onChanged: (val){
                      setState(() {
                        // print(val);
                        print(val!.name);
                        _gendar=val;
                      });
                    }),
                  ],
                ),
                MyTextField(
                    myController: phoneNumber,
                    fieldName: "رقم الجوال",
                    myIcon: Icons.description_outlined,
                    prefixIconColor: Colors.deepPurple.shade300),
                MyTextField(
                    myController: idNumber,
                    fieldName: "رقم الهوية",
                    myIcon: Icons.description_outlined,
                    prefixIconColor: Colors.deepPurple.shade300),
                MyButton(onPress: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')));
                    c.insertData(nameState: name.text,
                        phoneNumber: phoneNumber.text,
                        address: address.text,barthDay: barthDay.text,
                        idCard: idNumber.text,
                        gendar: _gendar!.name=='Male'?'ذكر':'انثى');
                    Navigator.pushNamed(context, '/speakOne');
                  }
                })
              ],
            ))
      ],
    );
  }
}
