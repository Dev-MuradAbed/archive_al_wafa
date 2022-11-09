import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  RegistrationPageState createState() => RegistrationPageState();
}

class RegistrationPageState extends State<RegistrationPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  String errorMessage = '';
  String successMessage = '';
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  String _emailId='';
  String _password='';
  final _emailIdController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');
  final _confirmPasswordController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Email Registration'),
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
                                // hintText: "Company Name",
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
                                // hintText: "Company Name",
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
                          Padding(
                            padding:
                            const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                            child: TextFormField(
                              validator: validateConfirmPassword,
                              controller: _confirmPasswordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                focusedBorder:  UnderlineInputBorder(
                                    borderSide:  BorderSide(
                                        color: Colors.green,
                                        width: 2,
                                        style: BorderStyle.solid)),
                                // hintText: "Company Name",
                                labelText: "Confirm Password",
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
                      // make buttons use the appropriate styles for cards
                      child: ButtonBar(
                        children: <Widget>[
                          TextButton(
                            child: const Text(
                              'Registration',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.green,
                              ),
                            ),
                            onPressed: () {
                              if (_formStateKey.currentState!.validate()) {
                                _formStateKey.currentState?.save();
                                signUp(_emailId, _password).then((user) {
                                  if (user != null) {
                                    print('Registered Successfully.');
                                    setState(() {
                                      successMessage =
                                      'Registered Successfully.\nYou can now navigate to Login Page.';
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
                              'Login',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.green,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                 MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
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
              style: const TextStyle(fontSize: 24, color: Colors.green),
            )
                : Container()),
          ],
        ),
      ),
    );
  }

  Future<UserCredential?> signUp(email, password) async {
    try {
      UserCredential user = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      assert(user.user != null);
      return user;
    } catch (e) {
      handleError(e);
      return null;
    }
  }

  handleError( error) {
    print(error);
    switch (error.code) {
      case 'ERROR_EMAIL_ALREADY_IN_USE':
        setState(() {
          errorMessage = 'Email Id already Exist!!!';
        });
        break;
      default:
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
    if (value!.trim().isEmpty || value.length < 6 || value.length > 14) {
      return 'Minimum 6 & Maximum 14 Characters!!!';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value!.trim() != _passwordController.text.trim()) {
      return 'Password Mismatch!!!';
    }
    return null;
  }
}
