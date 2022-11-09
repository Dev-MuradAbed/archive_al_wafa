import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:googleapis/drive/v3.dart' as ga;
import 'package:googleapis_auth/auth.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:http/io_client.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Drive/api.dart';
import 'firebase_options.dart';
import 'test20/secure_storage.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(
      My()

  );
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Drive',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MyHomePage(title: 'Google Drive'),
    );
  }
}

// class GoogleHttpClient extends IOClient {
//   Map<String, String> _headers;
//
//   GoogleHttpClient(this._headers) : super();
//
//   @override
//   Future<http.StreamedResponse> send(http.BaseRequest request) =>
//       super.send(request..headers.addAll(_headers));
//
//   @override
//   Future<http.Response> head(Object url, {Map<String, String> headers}) =>
//       super.head(url, headers: headers..addAll(_headers));
// }

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key,required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final storage0 =  FlutterSecureStorage();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn =
  GoogleSignIn(scopes: ['https://www.googleapis.com/auth/drive.appdata']);
 late GoogleSignInAccount googleSignInAccount;
  final storage=SecureStorage();
  // ga.FileList list;
  var signedIn = false;

  Future<void> _loginWithGoogle() async {
    signedIn = await storage0.read(key: "signedIn") == "true" ? true : false;
    googleSignIn.onCurrentUserChanged
        .listen((googleSignInAccount) async {
      if (googleSignInAccount != null) {
        _afterGoogleLogin(googleSignInAccount);
      }
    });
    if (signedIn) {
      try {
        googleSignIn.signInSilently().whenComplete(() => () {});
      } catch (e) {
        storage0.write(key: "signedIn", value: "false").then((value) {
          setState(() {
            signedIn = false;
          });
        });
      }
    } else {
      final  googleSignInAccount =
      await googleSignIn.signIn();
      _afterGoogleLogin(googleSignInAccount!);
    }
  }

  Future<void> _afterGoogleLogin(GoogleSignInAccount gSA) async {
    googleSignInAccount = gSA;
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final  authResult = await _auth.signInWithCredential(credential);
    final  user = authResult.user;

    // assert(!user.isAnonymous);
    // assert(await user.getIdToken() != null);

    final  currentUser = await _auth.currentUser;
    assert(user!.uid == currentUser!.uid);

    print('signInWithGoogle succeeded: $user');

    storage0.write(key: "signedIn", value: "true").then((value) {
      setState(() {
        signedIn = true;
      });
    });
  }

  void _logoutFromGoogle() async {
    googleSignIn.signOut().then((value) {
      print("User Sign Out");
      storage0.write(key: "signedIn", value: "false").then((value) {
        setState(() {
          signedIn = false;
        });
      });
    });
  }
  final clientId="1911779390-2s84iuelvsbo9vphgojafgsfr42kr3t0.apps.googleusercontent.com";
  final _clientSecret="pxnMrrLxqofKf0GMjjpl2uCmt4S2";
  final _scopes=[ga.DriveApi.driveAppdataScope,ga.DriveApi.driveFileScope];
//Get Authentication Http Client
  Future<http.Client>getHttpClient()async{
    //Get Credentials
    var credentials=await storage.getCredentials();
    if(credentials==null){
      //Need user authentication
      var authClient=await clientViaUserConsent(ClientId(clientId,_clientSecret),
          _scopes, (uri) {
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

  _uploadFileToGoogleDrive() async {
    var client = GoogleAuthClient(await googleSignInAccount.authHeaders);
    var drive = ga.DriveApi(client);
    ga.File fileToUpload = ga.File();
    var file0 = await FilePicker.platform.pickFiles();
    var file=File(file0?.files.single.path??'');
    fileToUpload.parents = ["appDataFolder"];
    fileToUpload.name = path.basename(file.absolute.path);
    var response = await drive.files.create(
      fileToUpload,
      uploadMedia: ga.Media(file.openRead(), file.lengthSync()),
    );
    print(response.toJson());
    // _listGoogleDriveFiles();
  }

  // Future<void> _listGoogleDriveFiles() async {
  //   var client = GoogleHttpClient(await googleSignInAccount.authHeaders);
  //   var drive = ga.DriveApi(client);
  //   drive.files.list(spaces: 'appDataFolder').then((value) {
  //     setState(() {
  //       list = value;
  //     });
  //     for (var i = 0; i < list.files.length; i++) {
  //       print("Id: ${list.files[i].id} File Name:${list.files[i].name}");
  //     }
  //   });
  // }
  //
  // Future<void> _downloadGoogleDriveFile(String fName, String gdID) async {
  //   var client = GoogleHttpClient(await googleSignInAccount.authHeaders);
  //   var drive = ga.DriveApi(client);
  //   ga.Media file = await drive.files
  //       .get(gdID, downloadOptions: ga.DownloadOptions.FullMedia);
  //   print(file.stream);
  //
  //   final directory = await getExternalStorageDirectory();
  //   print(directory.path);
  //   final saveFile = File('${directory.path}/${new DateTime.now().millisecondsSinceEpoch}$fName');
  //   List<int> dataStore = [];
  //   file.stream.listen((data) {
  //     print("DataReceived: ${data.length}");
  //     dataStore.insertAll(dataStore.length, data);
  //   }, onDone: () {
  //     print("Task Done");
  //     saveFile.writeAsBytes(dataStore);
  //     print("File saved at ${saveFile.path}");
  //   }, onError: (error) {
  //     print("Some Error");
  //   });
  // }

  // List<Widget> generateFilesWidget() {
  //   List<Widget> listItem = List<Widget>();
  //   if (list != null) {
  //     for (var i = 0; i < list.files.length; i++) {
  //       listItem.add(Row(
  //         children: <Widget>[
  //           Container(
  //             width: MediaQuery.of(context).size.width * 0.05,
  //             child: Text('${i + 1}'),
  //           ),
  //           Expanded(
  //             child: Text(list.files[i].name),
  //           ),
  //           Container(
  //             width: MediaQuery.of(context).size.width * 0.3,
  //             child: TextButton(
  //               child: Text(
  //                 'Download',
  //                 style: TextStyle(
  //                   color: Colors.white,
  //                 ),
  //               ),
  //               style: TextButton.styleFrom(
  //                 backgroundColor: Colors.indigo,
  //               ),
  //               onPressed: () {
  //                 _downloadGoogleDriveFile(list.files[i].name, list.files[i].id);
  //               },
  //             ),
  //           ),
  //         ],
  //       ));
  //     }
  //   }
  //   return listItem;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            (signedIn
                ? TextButton(
              child: Text('Upload File to Google Drive'),
              onPressed: _uploadFileToGoogleDrive,
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
              ),
            )
                : Container()),
            (signedIn
                ? TextButton(
              child: Text('List Google Drive Files'),
              onPressed: (){},
              // _listGoogleDriveFiles,
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
              ),
            )
                : Container()),
            (signedIn
                ? Expanded(
              flex: 10,
              child: Column(
                children:[]
                // generateFilesWidget(),
              ),
            )
                : Container()),
            (signedIn
                ? TextButton(
              child: Text('Google Logout'),
              onPressed: _logoutFromGoogle,
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
              ),
            )
                : TextButton(
              child: Text('Google Login'),
              onPressed: _loginWithGoogle,
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
              ),
            )),
          ],
        ),
      ),
    );
  }
}
class GoogleAuthClient extends http.BaseClient {
  final Map<String, String> _headers;
  final _client =  http.Client();

  GoogleAuthClient(this._headers);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll(_headers);
    return _client.send(request);
  }
}