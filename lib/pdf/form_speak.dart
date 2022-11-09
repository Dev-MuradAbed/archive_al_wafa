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
              gendar: _gendar!.name=='Male'?'ذكر':'انثى',
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
                  title: const Text("بيانات الحالة"),
                  content: Column(children: [
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
                            title: 'ذكر',
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
                            title: 'انثى',
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
                        fieldName: "رقم الجوال",
                        myIcon: Icons.description_outlined,
                        prefixIconColor: Colors.deepPurple.shade300),
                    MyTextField(
                        myController: idNumber,
                        fieldName: "رقم الهوية",
                        myIcon: Icons.description_outlined,
                        prefixIconColor: Colors.deepPurple.shade300),
                  ]),
                  isActive: currentStep >= 0,
                  state: currentStep >= 0
                      ? StepState.complete
                      : StepState.disabled),
              Step(
                  title: Text("التاريخ الطبي للحالة"),
                  content: Column(
                    children: [
                      MyTextField(
                        keyboardType: TextInputType.text,
                          maxLines: null,
                          myController: describe,
                          fieldName: "أوصف المشكلة لدى الحالة؟",
                          myIcon: Icons.propane_outlined,
                          prefixIconColor: Colors.deepPurple.shade300),
                      MyTextField(
                          keyboardType: TextInputType.text,
                          myController: incidents,
                          fieldName: "هل تعرض الطفل لحوادث أو تمت اصابته بأي امراض؟",
                          myIcon: Icons.description_outlined,
                          prefixIconColor: Colors.deepPurple.shade300),
                      MyTextField(
                          keyboardType: TextInputType.text,
                          myController: walk,
                          fieldName: "هل اكتسب مهارة المشي على عمر سنة ونصف ام بعد؟",
                          myIcon: Icons.description_outlined,
                          prefixIconColor: Colors.deepPurple.shade300),
                      MyTextField(
                          keyboardType: TextInputType.text,
                          myController: meningitis,
                          fieldName: "هل تعرض للإصابة بالحمى الشوكية او التهاب السحايا؟",
                          myIcon: Icons.description_outlined,
                          prefixIconColor: Colors.deepPurple.shade300),
                      MyTextField(
                          keyboardType: TextInputType.text,
                          myController: pregnancy,
                          fieldName: "هل حدث امر غير طبيعي في حمله وولادته؟",
                          myIcon: Icons.description_outlined,
                          prefixIconColor: Colors.deepPurple.shade300),
                      MyTextField(
                          keyboardType: TextInputType.text,
                          myController: babyWeight,
                          fieldName: "كم كان وزن الطفل عند الميلاد؟",
                          myIcon: Icons.propane_outlined,
                          prefixIconColor: Colors.deepPurple.shade300),
                      MyTextField(
                          keyboardType: TextInputType.text,
                          myController: birthIsNatural,
                          fieldName: "هل ميلاده طبيعي؟",
                          myIcon: Icons.description_outlined,
                          prefixIconColor: Colors.deepPurple.shade300),
                      MyTextField(
                          keyboardType: TextInputType.text,
                          myController: kinship,
                          fieldName: "صلة القرابة بين الاب والام؟",
                          myIcon: Icons.description_outlined,
                          prefixIconColor: Colors.deepPurple.shade300),
                      MyTextField(
                          keyboardType: TextInputType.text,
                          myController: absenceOfChildren,
                          fieldName: "هل هناك غياب للاب او الام؟",
                          myIcon: Icons.description_outlined,
                          prefixIconColor: Colors.deepPurple.shade300),
                      MyTextField(
                          keyboardType: TextInputType.text,
                          myController: disabilities,
                          fieldName: "هل يوجد مشاكل  او اعاقات بالأقارب؟",
                          myIcon: Icons.description_outlined,
                          prefixIconColor: Colors.deepPurple.shade300),
                      MyTextField(
                          keyboardType: TextInputType.text,
                          myController: maternalAge,
                          fieldName: "كم كان عمر الام بفترة حمله؟",
                          myIcon: Icons.propane_outlined,
                          prefixIconColor: Colors.deepPurple.shade300),
                      MyTextField(
                          keyboardType: TextInputType.text,
                          myController: childBehavior,
                          fieldName: "هل سلوك الطفل مناسب لعمره؟",
                          myIcon: Icons.description_outlined,
                          prefixIconColor: Colors.deepPurple.shade300),
                      MyTextField(
                          keyboardType: TextInputType.text,
                          myController: childResponse,
                          fieldName: "هل يستجيب الطفل لتنفيذ الأوامر؟",
                          myIcon: Icons.description_outlined,
                          prefixIconColor: Colors.deepPurple.shade300),
                      MyTextField(
                          keyboardType: TextInputType.text,
                          myController: causeOfTheProblem,
                          fieldName: "حسب رايك ما هو سبب المشكلة؟",
                          myIcon: Icons.description_outlined,
                          prefixIconColor: Colors.deepPurple.shade300),
                      MyTextField(
                          keyboardType: TextInputType.text,
                          myController: respondingWithTheFamily,
                          fieldName: "هل الطفل يفهم ما يوجه اليه من قبل العائلة والاخرون؟",
                          myIcon: Icons.description_outlined,
                          prefixIconColor: Colors.deepPurple.shade300),
                      MyTextField(
                          keyboardType: TextInputType.text,
                          myController: formerSpecialist,
                          fieldName: "هل تم عرض الطفل على اخصائي في السابق؟",
                          myIcon: Icons.propane_outlined,
                          prefixIconColor: Colors.deepPurple.shade300),
                    ],
                  ),
                  isActive: currentStep >= 1,
                  state: currentStep >= 1
                      ? StepState.complete
                      : StepState.disabled),
              Step(
                  title: Text("الوضع الاسري"),
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
