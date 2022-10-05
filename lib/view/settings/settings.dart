import 'dart:io';

import 'package:firebase_authentication/constants/sizedboxes.dart';
import 'package:firebase_authentication/controller/home/home_controller.dart';
import 'package:firebase_authentication/controller/settings/settings_controller.dart';
import 'package:firebase_authentication/view/settings/widgets/formfields.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
    required this.userEmail,
  });
  final String userEmail;
  @override
  Widget build(BuildContext context) {
    final settingsProvider =
        Provider.of<SettingsProvider>(context, listen: false);
    final homeProvier = Provider.of<HomeProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      settingsProvider.nameController.text =
          homeProvier.loggedInUserModel!.firstName!;
      settingsProvider.emailController.text =
          homeProvier.loggedInUserModel!.email!;
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Consumer<SettingsProvider>(
                  builder: (context, values, _) {
                    return Stack(
                      children: [
                        values.img == null
                            ? const CircleAvatar(
                                backgroundColor: Colors.grey,
                                radius: 60,
                              )
                            : CircleAvatar(
                                backgroundImage: FileImage(
                                  File(values.img!.path),
                                ),
                                radius: 60,
                              ),
                        Padding(
                          padding: const EdgeInsets.only(left: 35, top: 105),
                          child: IconButton(
                            onPressed: () => values.imagepicker(context),
                            icon: const Icon(Icons.add_a_photo),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                SizedBoxes.sizedboxH25,
                UserFormFields(
                  controller: settingsProvider.nameController,
                  hint: 'Enter your name',
                  keyboardType: TextInputType.name,
                  action: TextInputAction.next,
                  icon: Icons.account_box,
                ),
                SizedBoxes.sizedboxH25,
                UserFormFields(
                  controller: settingsProvider.emailController,
                  hint: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  action: TextInputAction.done,
                  icon: Icons.mail,
                ),
                SizedBoxes.sizedboxH15,
                ElevatedButton(
                  onPressed: () async =>
                      await settingsProvider.uploadImage(userEmail),
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
