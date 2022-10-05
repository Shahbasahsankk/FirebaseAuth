import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/model/signup/user_model.dart';
import 'package:firebase_authentication/view/settings/settings_screen.dart';
import 'package:firebase_authentication/view/login/login_screen.dart';
import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  HomeProvider() {
    getData();
  }
  User? user = FirebaseAuth.instance.currentUser;
  UserModel? loggedInUserModel;

  void goToLoginPage(context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }

  void goToSettingsPage(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SettingsScreen(),
      ),
    );
  }

//  User data from firestore
  void getData() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUserModel = UserModel.fromMap(
        value.data(),
      );
    });
    notifyListeners();
  }

// user signout
  Future<void> signOut(BuildContext context) async {
    goToLoginPage(context);
    await FirebaseAuth.instance.signOut();
  }
}
