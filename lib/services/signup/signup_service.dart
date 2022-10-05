import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/controller/signup/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../model/signup/user_model.dart';

class SignUpService {
  Future<void> signup(context, email, password, firstName) async {
    final signUpProvider = Provider.of<SignUpProvider>(context, listen: false);
    try {
      await signUpProvider.auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then(
        (_) async {
          await postDetailsToFirestore(firstName, email, signUpProvider.auth);
        },
      ).then((_) async {
        await FirebaseAuth.instance.signOut();
      });
      Fluttertoast.showToast(
          msg: 'SignUp Successful', backgroundColor: Colors.green);
      signUpProvider.toLoginScreen(context);
    } on FirebaseAuthException catch (e) {
      errorCheck(e);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> postDetailsToFirestore(firstName, email, auth) async {
    try {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      User? user = auth.currentUser;

      UserModel userModel = UserModel(
        uid: user!.uid,
        email: user.email,
        firstName: firstName,
      );
      await firebaseFirestore
          .collection('Users')
          .doc(user.uid)
          .set(userModel.toMap());
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void errorCheck(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        Fluttertoast.showToast(
            msg: 'Invalid Email Address', backgroundColor: Colors.red);
        break;
      case 'email-already-in-use':
        Fluttertoast.showToast(
            msg: 'Email Address Already Taken', backgroundColor: Colors.red);
        break;
      default:
        Fluttertoast.showToast(msg: e.message!, backgroundColor: Colors.red);
    }
  }
}
