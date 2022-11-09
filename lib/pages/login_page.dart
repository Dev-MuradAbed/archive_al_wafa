import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'registration_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn =  GoogleSignIn();
  bool isGoogleSignIn = false;
  String errorMessage = '';
  String successMessage = '';
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  String _emailId='';
  String _password='';
  final _emailIdController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Email Login'),
      ),
      body: Center(
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Form(
                        key: _formStateKey,
                        // autovalidate: true,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                              child: TextFormField(
                                validator: validateEmail,
                                onSaved: (value) {
                                  _emailId = value!;
                                },
                                keyboardType: TextInputType.emailAddress,
                                controller: _emailIdController,
                                decoration: const InputDecoration(
                                  focusedBorder:  UnderlineInputBorder(
                                    borderSide:  BorderSide(
                                        color: Colors.green,
                                        width: 2,
                                        style: BorderStyle.solid),
                                  ),
                                  labelText: "Email Id",
                                  icon: Icon(
                                    Icons.email,
                                    color: Colors.green,
                                  ),
                                  fillColor: Colors.white,
                                  labelStyle: TextStyle(
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                              child: TextFormField(
                                validator: validatePassword,
                                onSaved: (value) {
                                  _password = value!;
                                },
                                controller: _passwordController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  focusedBorder:  UnderlineInputBorder(
                                      borderSide:  BorderSide(
                                          color: Colors.green,
                                          width: 2,
                                          style: BorderStyle.solid)),
                                  labelText: "Password",
                                  icon: Icon(
                                    Icons.lock,
                                    color: Colors.green,
                                  ),
                                  fillColor: Colors.white,
                                  labelStyle: TextStyle(
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      (errorMessage != ''
                          ? Text(
                        errorMessage,
                        style: const TextStyle(color: Colors.red),
                      )
                          : Container()),
                      ButtonTheme(
                        child: ButtonBar(
                          children: <Widget>[
                            TextButton(
                              child: const Text(
                                'LOGIN',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.green,
                                ),
                              ),
                              onPressed: () {
                                if (_formStateKey.currentState!.validate()) {
                                  _formStateKey.currentState?.save();
                                  signIn(_emailId, _password).then((user) {
                                    if (user != null) {
                                      print('Logged in successfully.');
                                      setState(() {
                                        successMessage =
                                        'Logged in successfully.\nYou can now navigate to Home Page.';
                                      });
                                    } else {
                                      print('Error while Login.');
                                    }
                                  });
                                }
                              },
                            ),
                            TextButton(
                              child: const Text(
                                'Get Register',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.green,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                   MaterialPageRoute(
                                    builder: (context) => RegistrationPage(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              (successMessage != ''
                  ? Text(
                successMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, color: Colors.green),
              )
                  : Container()),
              (!isGoogleSignIn
                  ? ElevatedButton(
                child: const Text('Google Login'),
                onPressed: () {
                  googleSignin(context).then((user) {
                    if (user.user != null) {
                      print('Logged in successfully.');
                      setState(() {
                        isGoogleSignIn = true;
                        successMessage = 'Logged in successfully.\nEmail : ${user.user!.email}\nYou can now navigate to Home Page.';
                      });
                      print('xxxxxxxxxxxxxxxxxxxxxxxxxx');
                    } else {
                      print('Error while Login.');
                    }
                  });
                },
              )
                  : ElevatedButton(
                child: const Text('Google Logout'),
                onPressed: () {
                  googleSignout().then((response) {
                    if (response) {
                      setState(() {
                        isGoogleSignIn = false;
                        successMessage = '';
                      });
                    }
                  });
                },
              )),
            ],
          )),
    );
  }

  Future<UserCredential?> signIn(String email, String password) async {
    try {
      final user = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      final  currentUser =  auth.currentUser;
      assert(currentUser!=null);
      assert(user.user!=null);
      assert(user.user!.uid == currentUser!.uid);
      return user;
    } catch (e) {
      handleError(e);
      return null;
    }
  }

  Future<UserCredential> googleSignin(BuildContext context) async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    print(credential.idToken);
    print(credential.accessToken);
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<bool> googleSignout() async {
    await auth.signOut();
    await googleSignIn.signOut();
    return true;
  }

  handleError(error) {
    print(error);
    switch (error.code) {
      case 'ERROR_USER_NOT_FOUND':
        setState(() {
          errorMessage = 'User Not Found!!!';
        });
        break;
      case 'ERROR_WRONG_PASSWORD':
        setState(() {
          errorMessage = 'Wrong Password!!!';
        });
        break;
    }
  }

  String? validateEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex =  RegExp(pattern);
    if (value!.isEmpty || !regex.hasMatch(value)) {
      return 'Enter Valid Email Id!!!';
    } else {
      return null;
    }
  }

  String? validatePassword(String? value) {
    if (value!.trim().isEmpty) {
      return 'Password is empty!!!';
    }
    return null;
  }
}
