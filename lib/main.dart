import 'package:firebase_authentication/controller/home/home_controller.dart';
import 'package:firebase_authentication/controller/login/login_controller.dart';
import 'package:firebase_authentication/controller/settings/settings_controller.dart';
import 'package:firebase_authentication/controller/signup/signup_controller.dart';
import 'package:firebase_authentication/controller/splash/splash_controller.dart';
import 'package:firebase_authentication/view/splash/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => LoginProvider())),
        ChangeNotifierProvider(create: (context) => SignUpProvider()),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => SplashProvider()),
        ChangeNotifierProvider(create: (context) => SettingsProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
