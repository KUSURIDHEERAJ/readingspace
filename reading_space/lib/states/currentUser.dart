//import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reading_space/models/user.dart';
import 'package:reading_space/services/database.dart';

class CurrentUser extends ChangeNotifier {
  OurUser currentUser = OurUser();

  OurUser get getCurrentUser => currentUser;
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<String> onStartUp() async {
    String returnVal = "error!";

    try {
      User firebaseUser = auth.currentUser;
      if (firebaseUser != null) {
        currentUser = await OurDatabase().getUserInfo(firebaseUser.uid);
        if (currentUser != null) {
          returnVal = "Success";
        }
      }
    } catch (e) {
      print(e);
    }
    return returnVal;
  }

  Future<String> signOut() async {
    String returnVal = "error!";
    try {
      await auth.signOut();
      currentUser = OurUser();
      returnVal = "Success";
    } catch (e) {
      print(e);
    }
    return returnVal;
  }

  Future<String> signUpUser(
      String email, String password, String fullName) async {
    String returnval = "error!";
    OurUser user = OurUser();
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      user.uid = userCredential.user.uid;
      user.email = userCredential.user.email;
      user.fullName = fullName;
      String returnString = await OurDatabase().createUser(user);
      if (returnString == "Success") {
        returnval = "Success";
      }
    } on PlatformException catch (e) {
      returnval = e.message;
    } catch (e) {
      print(e);
    }
    return returnval;
  }

  Future<String> loginUserwithEmail(String email, String password) async {
    String returnVal = "error!";
    try {
      //AuthResult
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      currentUser = await OurDatabase().getUserInfo(userCredential.user.uid);
      if (currentUser != null) {
        returnVal = "Success";
      }
    } on PlatformException catch (e) {
      returnVal = e.message;
    } catch (e) {
      print(e);
    }
    return returnVal;
  }

  Future<String> loginUserwithGoogle() async {
    String returnVal = "error!";
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    OurUser user = OurUser();

    try {
      //AuthResult
      GoogleSignInAccount googleUser = await googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential cred = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
      UserCredential userCredential = await auth.signInWithCredential(cred);
      if (userCredential.additionalUserInfo.isNewUser) {
        user.uid = userCredential.user.uid;
        user.email = userCredential.user.email;
        user.fullName = userCredential.user.displayName;
        OurDatabase().createUser(user);
      }
      currentUser = await OurDatabase().getUserInfo(userCredential.user.uid);
      if (currentUser != null) {
        returnVal = "Success";
      }
    } on PlatformException catch (e) {
      returnVal = e.message;
    } catch (e) {
      print(e);
    }
    return returnVal;
  }
}
