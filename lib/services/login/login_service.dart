import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/controller/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class LoginService {
  Future<void> loginUser(context, email, password) async {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    try {
      await loginProvider.auth
          .signInWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then((uid) => {
                Fluttertoast.showToast(
                    msg: 'Logged in Successfully',
                    backgroundColor: Colors.green),
                loginProvider.toHomeScreen(context)
              });
    } on FirebaseAuthException catch (e) {
      errorCheck(e);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void errorCheck(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        Fluttertoast.showToast(
            msg: 'Invalid Email Address', backgroundColor: Colors.red);
        break;
      case 'user-not-found':
        Fluttertoast.showToast(
            msg: 'User Doesnot Exists', backgroundColor: Colors.red);
        break;
      case 'wrong-password':
        Fluttertoast.showToast(
            msg: 'Password Incorrect', backgroundColor: Colors.red);
        break;
      default:
        Fluttertoast.showToast(msg: e.message!, backgroundColor: Colors.red);
    }
  }
}
