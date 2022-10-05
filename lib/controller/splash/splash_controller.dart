import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/view/home/home_screen.dart';
import 'package:firebase_authentication/view/login/login_screen.dart';
import 'package:flutter/material.dart';

class SplashProvider with ChangeNotifier {
  Future<void> signInCheck(context) async {
    await Future.delayed(const Duration(seconds: 3));
    if (FirebaseAuth.instance.currentUser == null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    }
  }
}
