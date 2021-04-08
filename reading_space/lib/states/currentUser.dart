import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CurrentUser extends ChangeNotifier {
  String uid;
  String email;

  String get getUid => uid;
  String get getEmail => email;
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool> signUpUser(String email, String password) async {
    bool returnval = false;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user != null) {
        returnval = true;
      }
    } catch (e) {
      print(e);
    }
    return returnval;
  }

  Future<bool> loginUser(String email, String password) async {
    bool returnval = false;
    try {
      //AuthResult
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user != null) {
        uid = userCredential.user.uid;
        email = userCredential.user.email;
        returnval = true;
      }
    } catch (e) {
      print(e);
    }
    return returnval;
  }
}
