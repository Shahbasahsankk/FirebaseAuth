import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/services/login/login_service.dart';
import 'package:firebase_authentication/view/home/home_screen.dart';
import 'package:firebase_authentication/view/signup/signup_screen.dart';
import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final auth = FirebaseAuth.instance;
  void toSignUpScreen(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignUpScreen(),
      ),
    );
  }

  void toHomeScreen(context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }

  String? mailValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your Email';
    }
    return null;
  }

  String? passwordValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  // Firebase Login Function
  Future<void> signIn(String email, String password, BuildContext context,
      FormState currentState) async {
    if (currentState.validate()) {
      LoginService().loginUser(context, email, password);
    }
  }
}
