import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/services/signup/signup_service.dart';
import 'package:firebase_authentication/view/login/login_screen.dart';
import 'package:flutter/material.dart';

class SignUpProvider with ChangeNotifier {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController secondNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final auth = FirebaseAuth.instance;

  void toLoginScreen(context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter your name';
    }
    return null;
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter Email';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter password';
    } else if (value.length < 6) {
      return 'Weak Password';
    }
    return null;
  }

  String? confirmPassword(String? value, password) {
    if (value != password) {
      return 'Passwords donot match';
    } else if (value == null || value.isEmpty) {
      return 'Confirm password';
    }
    return null;
  }

  void signUp(
      FormState currentState, context, email, password, firstName) async {
    if (currentState.validate()) {
      SignUpService().signup(context, email, password, firstName);
    }
  }
}
