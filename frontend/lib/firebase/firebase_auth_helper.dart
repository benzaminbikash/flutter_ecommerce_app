import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:frontend/constants/ToastMessage.dart';
import 'package:frontend/constants/routes.dart';
import 'package:frontend/model/userModel.dart';
import 'package:frontend/screen/welcomeScreen.dart';

class firebaseAuthHelper {
  static firebaseAuthHelper instance = firebaseAuthHelper();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _store = FirebaseFirestore.instance;

  Future<bool> login(
      String email, String password, BuildContext context) async {
    try {
      ShowDialog(context, "Loading...");
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.of(context).pop();
      return true;
    } on FirebaseAuthException catch (error) {
      utils().showToast(error.code.toString());
      Navigator.of(context).pop();
      return false;
    }
  }

  Future<bool> signup(
      String name, String email, String password, BuildContext context) async {
    try {
      ShowDialog(context, "Loading...");
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      userModel usermodel = userModel(
          id: userCredential.user!.uid,
          email: email,
          name: name,
          image: null,
          roll: "user");
      _store.collection('users').doc(usermodel.id).set(usermodel.toJson());
      utils().showToast('Registration Successfully!');
      Navigator.of(context).pop();
      return true;
    } on FirebaseAuthException catch (error) {
      utils().showToast(error.code.toString());
      Navigator.of(context).pop();
      return false;
    }
  }

  void logoutuser(BuildContext context) async {
    await _auth.signOut();
    // Routes.instance.pushAndRemoveUtil(WelcomeScreen(), context);
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
    //   return WelcomeScreen();
    // }));
    Navigator.of(context, rootNavigator: true).pushReplacement(
        MaterialPageRoute(builder: (context) => WelcomeScreen()));
  }
}
