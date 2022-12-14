import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Widgets/my_radio_button_wigdet.dart';
import '../Widgets/my_text_field_widget.dart';
import '../providers/speak_get.dart';

class FormSpeak extends StatefulWidget {
  const FormSpeak({Key? key}) : super(key: key);

  @override
  State<FormSpeak> createState() => _FormSpeakState();
}

class _FormSpeakState extends State<FormSpeak> {
  int currentStep = 0;
  final name = TextEditingController();
  final barthDay = TextEditingController();
  final address = TextEditingController();
  final phoneNumber = TextEditingController();
  final idNumber = TextEditingController();
  final describe = TextEditingController();
  final incidents = TextEditingController();
  final walk = TextEditingController();
  final meningitis = TextEditingController();
  final pregnancy = TextEditingController();
  final babyWeight = TextEditingController();
  final birthIsNatural = TextEditingController();
  final kinship = TextEditingController();
  final absenceOfChildren = TextEditingController();
  final disabilities = TextEditingController();
  final maternalAge = TextEditingController();
  final childBehavior = TextEditingController();
  final childResponse = TextEditingController();
  final causeOfTheProblem = TextEditingController();
  final respondingWithTheFamily = TextEditingController();
  final formerSpecialist = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  Gendar? _gendar;
  continueStep() {
    if (currentStep < 2) {
      setState(() {
        currentStep += 1;
      });
    }
  }

  cancelStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep -= 1;
      });
    }
  }

  onStepTapped(int value) {
    setState(() {
      currentStep = value;
    });
  }

  Widget controlsBuilder(context, details) {
    var c = Get.put(SpeakGet());
    return Row(
      children: [
        ElevatedButton(onPressed:currentStep!=2?details.onStepContinue:() {
          c.insertData(nameState: name.text,
              phoneNumber: phoneNumber.text,
              address: address.text,
              barthDay: barthDay.text,
              idCard: idNumber.text,
              gendar: _gendar!.name=='Male'?'??????':'????????',
              describe:describe.text,
              incidents:incidents.text,
              walk:walk.text,
              meningitis:meningitis.text,
              pregnancy:pregnancy.text,
              babyWeight:babyWeight.text,//
              birthIsNatural:birthIsNatural.text,
              kinship:kinship.text,
              absenceOfChildren:absenceOfChildren.text,
              disabilities:disabilities.text,
              maternalAge:maternalAge.text,
              childBehavior:childBehavior.text,
              childResponse:childResponse.text,
              causeOfTheProblem:causeOfTheProblem.text,
              respondingWithTheFamily:respondingWithTheFamily.text,
              formerSpecialist:formerSpecialist.text,


          );
          Navigator.pushNamed(context, '/speakOne');
        }, child: Text('Next')),
        SizedBox(
          width: 10,
        ),
        OutlinedButton(onPressed: details.onStepCancel, child: Text('Back')),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Stepper(
            elevation: 0,
            type: StepperType.vertical,
            currentStep: currentStep,
            onStepContinue: continueStep,
            onStepCancel: cancelStep,
            onStepTapped: onStepTapped,
            controlsBuilder: controlsBuilder,
            steps: [
              Step(
                  title: const Text("???????????? ????????????"),
                  content: Column(children: [
                    MyTextField(
                        myController: name,
                        fieldName: "?????? ????????????",
                        myIcon: Icons.propane_outlined,
                        prefixIconColor: Colors.deepPurple.shade300),
                    MyTextField(
                        myController: barthDay,
                        fieldName: "?????????? ??????????????",
                        myIcon: Icons.description_outlined,
                        prefixIconColor: Colors.deepPurple.shade300),
                    MyTextField(
                        myController: address,
                        fieldName: "??????????????",
                        myIcon: Icons.description_outlined,
                        prefixIconColor: Colors.deepPurple.shade300),
                    Row(
                      children: [
                        MyRadioButton(
                            title: '??????',
                            value: Gendar.Male,
                            gendar: _gendar,
                            onChanged: (val) {
                              setState(() {
                                // print(val);
                                print(val!.name);
                                _gendar = val;
                              });
                            }),
                        SizedBox(
                          width: 5,
                        ),
                        MyRadioButton(
                            title: '????????',
                            value: Gendar.Female,
                            gendar: _gendar,
                            onChanged: (val) {
                              setState(() {
                                // print(val);
                                print(val!.name);
                                _gendar = val;
                              });
                            }),
                      ],
                    ),
                    MyTextField(
                        myController: phoneNumber,
                        fieldName: "?????? ????????????",
                        myIcon: Icons.description_outlined,
                        prefixIconColor: Colors.deepPurple.shade300),
                    MyTextField(
                        myController: idNumber,
                        fieldName: "?????? ????????????",
                        myIcon: Icons.description_outlined,
                        prefixIconColor: Colors.deepPurple.shade300),
                  ]),
                  isActive: currentStep >= 0,
                  state: currentStep >= 0
                      ? StepState.complete
                      : StepState.disabled),
              Step(
                  title: Text("?????????????? ?????????? ????????????"),
                  content: Column(
                    children: [
                      MyTextField(
                        keyboardType: TextInputType.text,
                          maxLines: null,
                          myController: describe,
                          fieldName: "???????? ?????????????? ?????? ??????????????",
                          myIcon: Icons.propane_outlined,
                          prefixIconColor: Colors.deepPurple.shade300),
                      MyTextField(
                          keyboardType: TextInputType.text,
                          myController: incidents,
                          fieldName: "???? ???????? ?????????? ???????????? ???? ?????? ???????????? ?????? ????????????",
                          myIcon: Icons.description_outlined,
                          prefixIconColor: Colors.deepPurple.shade300),
                      MyTextField(
                          keyboardType: TextInputType.text,
                          myController: walk,
                          fieldName: "???? ?????????? ?????????? ?????????? ?????? ?????? ?????? ???????? ???? ????????",
                          myIcon: Icons.description_outlined,
                          prefixIconColor: Colors.deepPurple.shade300),
                      MyTextField(
                          keyboardType: TextInputType.text,
                          myController: meningitis,
                          fieldName: "???? ???????? ?????????????? ???????????? ?????????????? ???? ???????????? ????????????????",
                          myIcon: Icons.description_outlined,
                          prefixIconColor: Colors.deepPurple.shade300),
                      MyTextField(
                          keyboardType: TextInputType.text,
                          myController: pregnancy,
                          fieldName: "???? ?????? ?????? ?????? ?????????? ???? ???????? ????????????????",
                          myIcon: Icons.description_outlined,
                          prefixIconColor: Colors.deepPurple.shade300),
                      MyTextField(
                          keyboardType: TextInputType.text,
                          myController: babyWeight,
                          fieldName: "???? ?????? ?????? ?????????? ?????? ????????????????",
                          myIcon: Icons.propane_outlined,
                          prefixIconColor: Colors.deepPurple.shade300),
                      MyTextField(
                          keyboardType: TextInputType.text,
                          myController: birthIsNatural,
                          fieldName: "???? ???????????? ????????????",
                          myIcon: Icons.description_outlined,
                          prefixIconColor: Colors.deepPurple.shade300),
                      MyTextField(
                          keyboardType: TextInputType.text,
                          myController: kinship,
                          fieldName: "?????? ?????????????? ?????? ???????? ????????????",
                          myIcon: Icons.description_outlined,
                          prefixIconColor: Colors.deepPurple.shade300),
                      MyTextField(
                          keyboardType: TextInputType.text,
                          myController: absenceOfChildren,
                          fieldName: "???? ???????? ???????? ???????? ???? ??????????",
                          myIcon: Icons.description_outlined,
                          prefixIconColor: Colors.deepPurple.shade300),
                      MyTextField(
                          keyboardType: TextInputType.text,
                          myController: disabilities,
                          fieldName: "???? ???????? ??????????  ???? ???????????? ??????????????????",
                          myIcon: Icons.description_outlined,
                          prefixIconColor: Colors.deepPurple.shade300),
                      MyTextField(
                          keyboardType: TextInputType.text,
                          myController: maternalAge,
                          fieldName: "???? ?????? ?????? ???????? ?????????? ??????????",
                          myIcon: Icons.propane_outlined,
                          prefixIconColor: Colors.deepPurple.shade300),
                      MyTextField(
                          keyboardType: TextInputType.text,
                          myController: childBehavior,
                          fieldName: "???? ???????? ?????????? ?????????? ????????????",
                          myIcon: Icons.description_outlined,
                          prefixIconColor: Colors.deepPurple.shade300),
                      MyTextField(
                          keyboardType: TextInputType.text,
                          myController: childResponse,
                          fieldName: "???? ???????????? ?????????? ???????????? ????????????????",
                          myIcon: Icons.description_outlined,
                          prefixIconColor: Colors.deepPurple.shade300),
                      MyTextField(
                          keyboardType: TextInputType.text,
                          myController: causeOfTheProblem,
                          fieldName: "?????? ???????? ???? ???? ?????? ????????????????",
                          myIcon: Icons.description_outlined,
                          prefixIconColor: Colors.deepPurple.shade300),
                      MyTextField(
                          keyboardType: TextInputType.text,
                          myController: respondingWithTheFamily,
                          fieldName: "???? ?????????? ???????? ???? ???????? ???????? ???? ?????? ?????????????? ??????????????????",
                          myIcon: Icons.description_outlined,
                          prefixIconColor: Colors.deepPurple.shade300),
                      MyTextField(
                          keyboardType: TextInputType.text,
                          myController: formerSpecialist,
                          fieldName: "???? ???? ?????? ?????????? ?????? ???????????? ???? ??????????????",
                          myIcon: Icons.propane_outlined,
                          prefixIconColor: Colors.deepPurple.shade300),
                    ],
                  ),
                  isActive: currentStep >= 1,
                  state: currentStep >= 1
                      ? StepState.complete
                      : StepState.disabled),
              Step(
                  title: Text("?????????? ????????????"),
                  content: Text("This is the first Step"),
                  isActive: currentStep >= 2,
                  state: currentStep >= 2
                      ? StepState.complete
                      : StepState.disabled),
            ],
          ),
        ),
      ),
    );
  }
}
