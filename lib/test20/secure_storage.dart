import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:googleapis_auth/auth_io.dart';

class SecureStorage {
  final storage = FlutterSecureStorage();
  //save Credentials
  Future saveCredentials(AccessToken token,String refreshToken)async{
    await storage.write(key: "type", value: token.type);
    await storage.write(key: "data", value: token.data);
    await storage.write(key: "expiry", value: token.expiry.toIso8601String());
    await storage.write(key: "refreshToken", value: refreshToken);
  }
//get Saved Credentials
  Future<Map<String,dynamic>?>getCredentials()async{
    var result=await storage.readAll();
    if(result.length==0)return null;
  return result;
  }
//clear Saved Credentials
Future clear(){
  return storage.deleteAll();
}
}
