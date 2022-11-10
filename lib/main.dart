import 'package:archive_al_wafa/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'Drive/api.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'pdf/form_speak.dart';
import 'pdf/pdf_page.dart';
import 'providers/speak_get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),
          '/speakOne': (context) => pdf_page(),
          '/FormSpeak': (context) => FormSpeak(),
          '/login': (context) => GoogleDriveTest(),
        },
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  bool _loginStatus = false;
  final googleSignIn = GoogleSignIn.standard(scopes: [
    drive.DriveApi.driveAppdataScope,
    drive.DriveApi.driveFileScope,
  ]);

  @override
  void initState() {
    _loginStatus = googleSignIn.currentUser != null;
    super.initState();
  }
  Future<void> signInWithGoogle() async {
    // GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    //
    // final googleSignInAuthentication =
    //
    // await googleSignInAccount?.authentication;
    // AuthCredential credential = GoogleAuthProvider.credential(
    //   accessToken: "ya29.a0AeTM1id6WPrGFzJY83_5moEWLcBBWAgTbsrHrN90bYIyuQY9XluekQmIyJeXwiSnsYNEVkKqsMWCxoyGa5sz3occNEqaZeOxpT1YJ1ixzQr-jQk_LlFO1_9I9wkPVqbW1USmd5NVa2XTxYgAv_oKar4FU2usAgaCgYKAdQSARMSFQHWtWOm3Kr5Km6tt16VlIGq2X_wwA0165",
    //
    //   idToken: null,
    //
    // );

    // UserCredential authResult = await FirebaseAuth.instance.signInWithCredential(credential);

    // User? _user = authResult.user;

    // assert(!_user!.isAnonymous);

    // assert(await _user!.getIdToken() != null);

    // User? currentUser =  FirebaseAuth.instance.currentUser;
    // assert(_user!.uid == currentUser?.uid);


  }
// }
//   Future<void> _signIn() async {
//  // final fi=  GoogleSignIn().
//  // instance.signInWithCustomToken("ya29.a0AeTM1iesMhlMFj88bO6R8IAvbWhedcP3YTMf9mVlSw7imFn1cKBbpO2noW-io1w9J2ADOT4XkYx01qGmBTUIqPd5vY8SuXmdokDQoe41dYKfgBxnfhF-yuMYsymKQR62JaEa7i4Twn6owe8MB4SiL9guOmahKQaCgYKARcSARMSFQHWtWOmzI5IzNKQJa6emQUurbS94w0165");
//  //
//  // await googleSignIn.signIn();
//  // fi?.authHeaders;
//  // signInWithEmailAndPassword(email:"noemail1234t@gmail.com" ,
//  //      password: "123123",);
//  //    print("signIn :$fi");
// //     final googleUser = await googleSignIn.signIn();
// //
// //     try {
// //       if (googleUser != null) {
// //         final googleAuth = await googleUser.authentication;
// // //         final credential = EmailAuthProvider.credential(
// // // email:"noemail1234t@gmail.com" ,
// // //           password: "MuradAbed0599084404@",
// // //         );
// //         print('googleAuth.accessToken ::${googleAuth.accessToken}');
// //         print('googleAuth.idToken ::${googleAuth.idToken}');
// //         final UserCredential loginUser =
// //             await FirebaseAuth.instance.signInWithEmailAndPassword(email:"noemail1234t@gmail.com" ,
// //               password: "MuradAbed0599084404@",);
// //         assert(loginUser.user?.uid == FirebaseAuth.instance.currentUser?.uid);
// //         print("Sign in");
// //         setState(() {
// //           _loginStatus = true;
// //         });
// //       }
// //     } catch (e) {
// //       print(e);
// //     }
//   }

  @override
  Widget build(BuildContext context) {
    var c = Get.put(SpeakGet());
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Document",
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      )),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () async{
                // await signInWithGoogle();
                Navigator.pushNamed(context, '/FormSpeak');
              },
              child: const Text('استمارة نطق')),
          ElevatedButton(
              onPressed: () {
                print(c.nameStates);
              },
              child: const Text('استمارات التأهيل')),
          ElevatedButton(
              onPressed: () => {}, child: const Text('استمارة الدعم النفسي')),
        ],
      ),
    );
  }
}

//onPressed()=>context.read<SpeakProvider>().insertData();
//to show value =>> context.watch<SpeakProvider>().nameStates;
