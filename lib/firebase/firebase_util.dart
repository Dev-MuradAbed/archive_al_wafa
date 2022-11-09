import 'package:firebase_auth/firebase_auth.dart';

Future<UserCredential?> signUp({email, password}) async {
  try {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return user;
  } catch (e) {
    print(e);
    return null;
  }
}

Future<UserCredential?> sginIn(String email, String password) async {
  try {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    final currentUser = FirebaseAuth.instance.currentUser;
    assert(user.user?.uid == currentUser?.uid);
    return user;
  } catch (e) {
    print(e);
    return null;
  }
}
