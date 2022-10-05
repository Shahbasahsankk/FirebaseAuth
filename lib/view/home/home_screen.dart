import 'package:firebase_authentication/constants/sizedboxes.dart';
import 'package:firebase_authentication/controller/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
        actions: [
          IconButton(
            onPressed: () => homeProvider.goToSettingsPage(context),
            icon: const Icon(
              Icons.settings,
              color: Colors.black,
              size: 30,
            ),
          ),
          SizedBoxes.sizedboxW10,
        ],
      ),
      body: Center(
        child: Consumer<HomeProvider>(
          builder: (context, values, _) {
            return values.loggedInUserModel == null
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(values.loggedInUserModel!.email!),
                      SizedBoxes.sizedboxH25,
                      Text(values.loggedInUserModel!.firstName!),
                      SizedBoxes.sizedboxH25,
                    ],
                  );
          },
        ),
      ),
    );
  }
}
