import 'package:firebase_authentication/constants/sizedboxes.dart';
import 'package:firebase_authentication/controller/login/login_controller.dart';
import 'package:firebase_authentication/view/login/widgets/email_and_password_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 150,
                      child: Image(
                        image: AssetImage('assets/logo/logo.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBoxes.sizedboxH25,
                    EmailAndPasswordFormfield(
                      controller: loginProvider.emailController,
                      keyboardType: TextInputType.emailAddress,
                      icon: Icons.mail,
                      hint: 'Email Address',
                      action: TextInputAction.next,
                      obscure: false,
                      validator: (value) => loginProvider.mailValidation(value),
                    ),
                    SizedBoxes.sizedboxH25,
                    EmailAndPasswordFormfield(
                      controller: loginProvider.passwordController,
                      keyboardType: TextInputType.text,
                      icon: Icons.vpn_key,
                      hint: 'Enter Password',
                      action: TextInputAction.done,
                      obscure: true,
                      validator: (value) =>
                          loginProvider.passwordValidation(value),
                    ),
                    SizedBoxes.sizedboxH15,
                    Consumer<LoginProvider>(builder: (context, values, _) {
                      return values.isLoading == true
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : ElevatedButton(
                              onPressed: () async => await loginProvider.signIn(
                                loginProvider.emailController.text,
                                loginProvider.passwordController.text,
                                context,
                                formKey.currentState!,
                              ),
                              child: const Text('Log In'),
                            );
                    }),
                    SizedBoxes.sizedboxH5,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        TextButton(
                          onPressed: () =>
                              loginProvider.toSignUpScreen(context),
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    )
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
