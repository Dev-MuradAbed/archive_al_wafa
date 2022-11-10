import 'dart:io';
import 'package:archive_al_wafa/test20/secure_storage.dart';
import 'package:get/get.dart';
import 'package:googleapis/drive/v3.dart'as ga;
import 'package:googleapis_auth/auth_io.dart';
import 'package:path/path.dart'as p;
import 'package:http/http.dart'as http;
import 'package:url_launcher/url_launcher.dart';
const clientId="1911779390-2s84iuelvsbo9vphgojafgsfr42kr3t0.apps.googleusercontent.com";
const _clientSecret="pxnMrrLxqofKf0GMjjpl2uCmt4S2";
const _scopes=[ga.DriveApi.driveAppdataScope,ga.DriveApi.driveFileScope];
class GoogleDrive{
  final storage=SecureStorage();

  //Get Authentication Http Client
  Future<http.Client>getHttpClient()async{
    //Get Credentials
    var credentials=await storage.getCredentials();
    if(credentials==null){
      //Need user authentication
      var authClient=await clientViaUserConsent(ClientId(clientId,_clientSecret),
          _scopes, (uri) {
        print(uri);
            //Open Url in Browser
            launchUrl(Uri.parse(uri));
          });
      return authClient;
    }else{
      //Already authentication
      return authenticatedClient(http.Client(),
          AccessCredentials(credentials["type"],
              credentials["refreshToken"],_scopes));
    }

  }
  //Upload File
Future upload(File file)async{
  var client=await getHttpClient();
  var drive=ga.DriveApi(client);
  var response=await drive.files.create(
      ga.File()..name=p.basename(file.absolute.path),
    uploadMedia: ga.Media(file.openRead(), file.lengthSync())
  );
  print(response.toJson());

}
}