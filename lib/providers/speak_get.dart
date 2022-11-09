
import 'dart:io';

import 'package:get/get.dart';
// import 'package:googleapis/drive/v3.dart';
class SpeakGet extends GetxController{
  String _nameStates='';
  String get nameStates=>_nameStates;
  String _barthDay='';
  String get barthDay=>_barthDay;
  String _address='';
  String get address=>_address;
  String _phoneNumber='';
  String get phoneNumber=>_phoneNumber;
  String _idCard='';
  String get idCard=>_idCard;
  String _gendar='';
  String get gendar=>_gendar;
  String _describe='';
  String get describe=>_describe;
  String _incidents='';
  String get incidents=>_incidents;
  String _walk='';
  String get walk=>_walk;
  String _meningitis='';
  String get meningitis=>_meningitis;
  String _pregnancy='';
  String get pregnancy=>_pregnancy;
  String _babyWeight='';
  String get babyWeight=>_babyWeight;
  String _birthIsNatural='';
  String get birthIsNatural=>_birthIsNatural;
  String _kinship='';
  String get kinship=>_kinship;
  String _absenceOfChildren='';
  String get absenceOfChildren=>_absenceOfChildren;
  String _disabilities='';
  String get disabilities=>_disabilities;
  String _maternalAge='';
  String get maternalAge=>_maternalAge;
  String _childBehavior='';
  String get childBehavior=>_childBehavior;
  String _childResponse='';
  String get childResponse=>_childResponse;
  String _causeOfTheProblem='';
  String get causeOfTheProblem=>_causeOfTheProblem;
  String _respondingWithTheFamily='';
  String get respondingWithTheFamily=>_respondingWithTheFamily;
  String _formerSpecialist='';
  String get formerSpecialist=>_formerSpecialist;
File _file=File('');
File get file=>_file;
insertFile({required File file}){
  _file=file;
}
   insertData({required String nameState,barthDay,address,phoneNumber,idCard,gendar,
     describe,
   incidents,
   walk,
   meningitis,
   pregnancy,
   babyWeight,
   birthIsNatural,
   kinship,
   absenceOfChildren,
   disabilities,
   maternalAge,
   childBehavior,
   childResponse,
   causeOfTheProblem,
   respondingWithTheFamily,
   formerSpecialist}){
      _nameStates=nameState;
      _barthDay=barthDay;
      _address=address;
      _phoneNumber=phoneNumber;
      _idCard=idCard;
      _gendar=gendar;
      _describe=describe;
      _incidents=incidents;
      _walk=walk;
      _meningitis=meningitis;
      _pregnancy=pregnancy;
      _babyWeight=babyWeight;
      _birthIsNatural=birthIsNatural;
      _kinship=kinship;
      _absenceOfChildren=absenceOfChildren;
      _disabilities=disabilities;
      _maternalAge=maternalAge;
      _childBehavior=childBehavior;
      _childResponse=childResponse;
      _causeOfTheProblem=causeOfTheProblem;
      _respondingWithTheFamily=respondingWithTheFamily;
      _formerSpecialist=formerSpecialist;

  }
}