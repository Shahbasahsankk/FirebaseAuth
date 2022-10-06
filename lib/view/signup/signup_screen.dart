import 'package:firebase_authentication/controller/login/login_controller.dart';
import 'package:firebase_authentication/view/signup/widgets/form_fields.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/sizedboxes.dart';
import '../../controller/signup/signup_controller.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final signUpProvider = Provider.of<SignUpProvider>(context, listen: false);
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    signUpProvider.emailController.clear();
    signUpProvider.firstNameController.clear();
    signUpProvider.secondNameController.clear();
    signUpProvider.confirmPasswordController.clear();
    signUpProvider.passwordController.clear();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SignUpFormFields(
                      controller: signUpProvider.firstNameController,
                      hint: 'First Name',
                      obscure: false,
                      keyboardType: TextInputType.name,
                      action: TextInputAction.next,
                      icon: Icons.account_circle,
                      validator: (value) => signUpProvider.nameValidator(value),
                    ),
                    SizedBoxes.sizedboxH25,
                    SignUpFormFields(
                      controller: signUpProvider.emailController,
                      hint: 'Mail',
                      obscure: false,
                      keyboardType: TextInputType.emailAddress,
                      action: TextInputAction.next,
                      icon: Icons.mail,
                      validator: (value) =>
                          signUpProvider.emailValidator(value),
                    ),
                    SizedBoxes.sizedboxH25,
                    SignUpFormFields(
                      controller: signUpProvider.passwordController,
                      hint: 'Password',
                      obscure: true,
                      keyboardType: TextInputType.text,
                      action: TextInputAction.next,
                      icon: Icons.vpn_key,
                      validator: (value) =>
                          signUpProvider.passwordValidator(value),
                    ),
                    SizedBoxes.sizedboxH25,
                    SignUpFormFields(
                      controller: signUpProvider.confirmPasswordController,
                      hint: 'Confirm Password',
                      obscure: true,
                      keyboardType: TextInputType.text,
                      action: TextInputAction.done,
                      icon: Icons.vpn_key,
                      validator: (value) => signUpProvider.confirmPassword(
                        value,
                        signUpProvider.passwordController.text,
                      ),
                    ),
                    SizedBoxes.sizedboxH15,
                    ElevatedButton(
                      onPressed: () {
                        signUpProvider.signUp(
                          formKey.currentState!,
                          context,
                          signUpProvider.emailController.text,
                          signUpProvider.passwordController.text,
                          signUpProvider.firstNameController.text,
                        );
                        loginProvider.emailController.clear();
                        loginProvider.passwordController.clear();
                      },
                      child: const Text('Sign Up'),
                    ),
                    SizedBoxes.sizedboxH5,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
