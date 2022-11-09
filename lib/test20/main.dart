import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'googledrive.dart';
void main()=>runApp(MyApp());
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:MyHomepage() ,
    );
  }
}
class MyHomepage extends StatefulWidget {
  const MyHomepage({Key? key}) : super(key: key);

  @override
  State<MyHomepage> createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
  final drive=GoogleDrive();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(onPressed: ()async{
            var file=await FilePicker.platform.pickFiles();
            print('file is        ${file?.files.single.path}');
            drive.upload(File(file?.files.single.path??''));
          }, child: Text('uplode'))
        ],
      ),
    );
  }
}

