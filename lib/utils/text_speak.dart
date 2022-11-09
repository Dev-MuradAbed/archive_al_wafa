import 'package:get/get.dart';
import 'package:pdf/widgets.dart'as pw;

import '../providers/speak_get.dart';
  pw.Widget textSpeakPage1() {
    final  c = Get.find<SpeakGet>();
    return pw.Container(
        padding: const pw.EdgeInsets.only(left: 30, bottom: 20),
        child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Padding(padding: const pw.EdgeInsets.only(top: 20)),
              pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.SizedBox(
                        width: 500,
                        child: pw.Column(children: [
                          pw.Container(
                              child: pw.Column(
                                  mainAxisAlignment:
                                  pw.MainAxisAlignment.center,
                                  children: [
                                    pw.Text(
                                        'قسم علاج اضطرابات النطق و مشاكل  الكلام',
                                        style: const pw.TextStyle(
                                            fontSize: 18)),
                                    pw.Text('استمارة دراسة حالة',
                                        style: const pw.TextStyle(
                                            fontSize: 18)),
                                  ])),
                          pw.SizedBox(height: 40),
                          //البيانات الشخصية لحالة اضطراب النطق و مشاكل الكلام
                          pw.Column(
                              mainAxisAlignment:
                              pw.MainAxisAlignment.center,
                              children: [
                                pw.Row(
                                    mainAxisAlignment: pw
                                        .MainAxisAlignment.spaceBetween,
                                    children: [
                                      pw.RichText(
                                        text:  pw.TextSpan(
                                            text: 'تاريخ الميلاد/ ',
                                            style: pw.TextStyle(
                                              fontSize: 13,
                                            ),
                                            children: [
                                              pw.TextSpan(
                                                  text:
                                                  c.barthDay.toString(),
                                                  style: pw.TextStyle(
                                                    fontSize: 13,
                                                  ))
                                            ]),
                                      ),
                                      pw.RichText(
                                        text: pw.TextSpan(
                                            text: 'اسم الحالة/ ',
                                            style: pw.TextStyle(
                                              fontSize: 13,
                                            ),
                                            children: [
                                              pw.TextSpan(
                                                  text:
                                                  c.nameStates.toString(),
                                                  style: pw.TextStyle(
                                                    fontSize: 13,
                                                  ))
                                            ]),
                                      ),
                                    ]),
                                pw.SizedBox(height: 10),
                                pw.Row(
                                    mainAxisAlignment: pw
                                        .MainAxisAlignment.spaceBetween,
                                    children: [
                                      pw.RichText(
                                        text:  pw.TextSpan(
                                            text: 'رقم الجوال/ ',
                                            style: pw.TextStyle(
                                              fontSize: 13,
                                            ),
                                            children: [
                                              pw.TextSpan(
                                                  text:c.phoneNumber.toString(),
                                                  style: pw.TextStyle(
                                                    fontSize: 13,
                                                  ))
                                            ]),
                                      ),
                                      pw.RichText(
                                        text:  pw.TextSpan(
                                            text: 'العنوان/ ',
                                            style: pw.TextStyle(
                                              fontSize: 13,
                                            ),
                                            children: [
                                              pw.TextSpan(
                                                  text:c.address.toString(),
                                                  style: pw.TextStyle(
                                                    fontSize: 13,
                                                  ))
                                            ]),
                                      )
                                    ]),
                                pw.SizedBox(height: 10),
                                pw.Row(
                                    mainAxisAlignment: pw
                                        .MainAxisAlignment.spaceBetween,
                                    children: [
                                      pw.RichText(
                                        text:  pw.TextSpan(
                                            text: 'الجنس/ ',
                                            style: pw.TextStyle(
                                              fontSize: 13,
                                            ),
                                            children: [
                                              pw.TextSpan(
                                                  text:
                                                  '${c.gendar.toString()}                  ',
                                                  style: pw.TextStyle(
                                                    decoration: pw.TextDecoration.underline,
                                                    decorationStyle: pw.TextDecorationStyle.solid,
                                                    fontSize: 13,
                                                  ))
                                            ]),
                                      ),
                                      pw.RichText(
                                        text:  pw.TextSpan(
                                            text: 'رقم الهوية/ ',
                                            style: pw.TextStyle(
                                              fontSize: 13,
                                            ),
                                            children: [
                                              pw.TextSpan(
                                                  text:c.barthDay.toString(),
                                                  style: pw.TextStyle(
                                                    fontSize: 13,
                                                  ))
                                            ]),
                                      ),
                                    ]),
                                pw.SizedBox(height: 20),
                                pw.SizedBox(
                                    width: 500,
                                    child: pw.Column(
                                        crossAxisAlignment:
                                        pw.CrossAxisAlignment.end,
                                        children: [
                                          pw.Text(
                                              'التاريخ الطبي و المرضي للحالة*',
                                              style: const pw.TextStyle(
                                                  fontSize: 18)),
                                          pw.SizedBox(height: 14),
                                          pw.RichText(
                                            text:  pw.TextSpan(
                                                text:
                                                'اوصف المشكلة لدى الحالة ؟',
                                                style: pw.TextStyle(
                                                  fontSize: 13,
                                                ),
                                                children: [
                                                  pw.TextSpan(
                                                      text:
                                                      c.describe.toString(),
                                                      style:
                                                      pw.TextStyle(
                                                        fontSize: 13,
                                                      ))
                                                ]),
                                          ),
                                          pw.SizedBox(height: 10),
                                          pw.RichText(
                                            text:  pw.TextSpan(
                                                text:
                                                'هل تعرض الطفل لحوادث أو تمت اصابته باي امراض ؟',
                                                style: pw.TextStyle(
                                                  fontSize: 13,
                                                ),
                                                children: [
                                                  pw.TextSpan(
                                                      text:
                                                      c.incidents.toString(),
                                                      style:
                                                      pw.TextStyle(
                                                        fontSize: 13,
                                                      ))
                                                ]),
                                          ),
                                          pw.SizedBox(height: 10),
                                          pw.RichText(
                                            text:  pw.TextSpan(
                                                text:
                                                'هل اكتسب مهارة المشي على عمر سنة ونصف ام بعد ؟',
                                                style: pw.TextStyle(
                                                  fontSize: 13,
                                                ),
                                                children: [
                                                  pw.TextSpan(
                                                      text:
                                                      c.walk.toString(),
                                                      style:
                                                      pw.TextStyle(
                                                        fontSize: 13,
                                                      ))
                                                ]),
                                          ),
                                          pw.SizedBox(height: 10),
                                          pw.RichText(
                                            text:  pw.TextSpan(
                                                text:
                                                'هل تعرض للإصابة بالحمى الشوكية او التهاب السحايا ؟',
                                                style: pw.TextStyle(
                                                  fontSize: 13,
                                                ),
                                                children: [
                                                  pw.TextSpan(
                                                      text:
                                                      c.meningitis.toString(),
                                                      style:
                                                      pw.TextStyle(
                                                        fontSize: 13,
                                                      ))
                                                ]),
                                          ),
                                          pw.SizedBox(height: 10),
                                          pw.RichText(
                                            text:  pw.TextSpan(
                                                text:
                                                'هل حدث امر غير طبيعي في حمله وولادته ؟',
                                                style: pw.TextStyle(
                                                  fontSize: 13,
                                                ),
                                                children: [
                                                  pw.TextSpan(
                                                      text:
                                                      c.pregnancy.toString(),
                                                      style:
                                                      pw.TextStyle(
                                                        fontSize: 13,
                                                      ))
                                                ]),
                                          ),
                                          pw.SizedBox(height: 10),
                                          pw.RichText(
                                            text:  pw.TextSpan(
                                                text:
                                                'كم كان وزن الطفل عند الميلاد ؟',
                                                style: pw.TextStyle(
                                                  fontSize: 13,
                                                ),
                                                children: [
                                                  pw.TextSpan(
                                                      text:
                                                      c.babyWeight.toString(),
                                                      style:
                                                      pw.TextStyle(
                                                        fontSize: 13,
                                                      ))
                                                ]),
                                          ),
                                          pw.SizedBox(height: 10),
                                          pw.RichText(
                                            text:  pw.TextSpan(
                                                text:
                                                'صلة القرابة بين الاب والام ؟',
                                                style: pw.TextStyle(
                                                  fontSize: 13,
                                                ),
                                                children: [
                                                  pw.TextSpan(
                                                      text:
                                                      c.kinship.toString(),
                                                      style:
                                                      pw.TextStyle(
                                                        fontSize: 13,
                                                      ))
                                                ]),
                                          ),
                                          pw.SizedBox(height: 10),
                                          pw.RichText(
                                            text:  pw.TextSpan(
                                                text:
                                                'هل يوجد مشاكل  او اعاقات بالأقارب ؟',
                                                style: pw.TextStyle(
                                                  fontSize: 13,
                                                ),
                                                children: [
                                                  pw.TextSpan(
                                                      text:
                                                      c.disabilities.toString(),
                                                      style:
                                                      pw.TextStyle(
                                                        fontSize: 13,
                                                      ))
                                                ]),
                                          ),
                                          pw.SizedBox(height: 10),
                                          pw.RichText(
                                            text:  pw.TextSpan(
                                                text:
                                                'كم كان عمر الام بفترة حمله ؟',
                                                style: pw.TextStyle(
                                                  fontSize: 13,
                                                ),
                                                children: [
                                                  pw.TextSpan(
                                                      text:
                                                      c.maternalAge.toString(),
                                                      style:
                                                      pw.TextStyle(
                                                        fontSize: 13,
                                                      ))
                                                ]),
                                          ),
                                          pw.SizedBox(height: 10),
                                          pw.RichText(
                                            text:  pw.TextSpan(
                                                text:
                                                'هل سلوك الطفل مناسب لعمره ؟',
                                                style: pw.TextStyle(
                                                  fontSize: 13,
                                                ),
                                                children: [
                                                  pw.TextSpan(
                                                      text:
                                                      c.childBehavior.toString(),
                                                      style:
                                                      pw.TextStyle(
                                                        fontSize: 13,
                                                      ))
                                                ]),
                                          ),
                                          pw.SizedBox(height: 10),
                                          pw.RichText(
                                            text:  pw.TextSpan(
                                                text:
                                                'هل يستجيب الطفل لتنفيذ الأوامر ؟',
                                                style: pw.TextStyle(
                                                  fontSize: 13,
                                                ),
                                                children: [
                                                  pw.TextSpan(
                                                      text:
                                                      c.childResponse.toString(),
                                                      style:
                                                      pw.TextStyle(
                                                        fontSize: 13,
                                                      ))
                                                ]),
                                          ),
                                          pw.SizedBox(height: 10),
                                          pw.RichText(
                                            text:  pw.TextSpan(
                                                text:
                                                'حسب رايك ما هو سبب المشكلة ؟',
                                                style: pw.TextStyle(
                                                  fontSize: 13,
                                                ),
                                                children: [
                                                  pw.TextSpan(
                                                      text:
                                                      c.causeOfTheProblem.toString(),
                                                      style:
                                                      pw.TextStyle(
                                                        fontSize: 13,
                                                      ))
                                                ]),
                                          ),
                                          pw.SizedBox(height: 10),
                                          pw.RichText(
                                            text:  pw.TextSpan(
                                                text:
                                                'هل الطفل يفهم ما يوجه اليه من قبل العائلة والاخرون ؟',
                                                style: pw.TextStyle(
                                                  fontSize: 13,
                                                ),
                                                children: [
                                                  pw.TextSpan(
                                                      text:
                                                      c.respondingWithTheFamily.toString(),
                                                      style:
                                                      pw.TextStyle(
                                                        fontSize: 13,
                                                      ))
                                                ]),
                                          ),
                                          pw.SizedBox(height: 10),
                                          pw.RichText(
                                            text:  pw.TextSpan(
                                                text:
                                                'هل تم عرض الطفل على اخصائي في السابق ؟',
                                                style: pw.TextStyle(
                                                  fontSize: 13,
                                                ),
                                                children: [
                                                  pw.TextSpan(
                                                      text:
                                                      c.formerSpecialist.toString(),
                                                      style:
                                                      pw.TextStyle(
                                                        fontSize: 13,
                                                      ))
                                                ]),
                                          ),
                                        ]))
                              ]),
                        ]))
                  ]),
            ]));
  }

