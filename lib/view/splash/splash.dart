import 'package:firebase_authentication/controller/splash/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final splashProvider = Provider.of<SplashProvider>(context, listen: false);
    splashProvider.signInCheck(context);
    return const Scaffold(
      body: Center(
        child: Image(
          image: AssetImage('assets/logo/logo.png'),
        ),
      ),
    );
  }
}
