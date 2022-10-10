import 'dart:io';

import 'package:firebase_authentication/constants/sizedboxes.dart';
import 'package:firebase_authentication/controller/home/home_controller.dart';
import 'package:firebase_authentication/controller/login/login_controller.dart';
import 'package:firebase_authentication/controller/settings/settings_controller.dart';
import 'package:firebase_authentication/view/settings/widgets/formfields.dart';
import 'package:firebase_authentication/view/signup/widgets/form_fields.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    final settingsProvider =
        Provider.of<SettingsProvider>(context, listen: false);
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    settingsProvider.passwordController.clear();
    settingsProvider.emailController.clear();
    settingsProvider.nameController.clear();
    settingsProvider.img = null;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () async {
            Navigator.pop(context);
            await homeProvider.getStudents();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              settingsProvider.signOut(context);
              loginProvider.emailController.clear();
              loginProvider.passwordController.clear();
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Consumer<SettingsProvider>(
          builder: (context, values, _) {
            return values.userDataLoading == true
                ? SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(36.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                values.img == null
                                    ? values.downloadUrl != null
                                        ? CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                values.downloadUrl!),
                                            radius: 60,
                                          )
                                        : const CircleAvatar(
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
                                  padding:
                                      const EdgeInsets.only(left: 35, top: 105),
                                  child: IconButton(
                                    onPressed: () =>
                                        values.imagepicker(context),
                                    icon: const Icon(Icons.add_a_photo),
                                  ),
                                ),
                              ],
                            ),
                            SizedBoxes.sizedboxH25,
                            UserFormFields(
                              controller: values.nameController,
                              hint: 'Enter your name',
                              keyboardType: TextInputType.name,
                              action: TextInputAction.next,
                              icon: Icons.account_box,
                            ),
                            SizedBoxes.sizedboxH25,
                            UserFormFields(
                              controller: values.emailController,
                              hint: 'Enter your email',
                              keyboardType: TextInputType.emailAddress,
                              action: TextInputAction.done,
                              icon: Icons.mail,
                            ),
                            SizedBoxes.sizedboxH25,
                            SignUpFormFields(
                              controller: values.passwordController,
                              hint: 'Enter password to save',
                              obscure: true,
                              keyboardType: TextInputType.text,
                              action: TextInputAction.next,
                              icon: Icons.vpn_key,
                              validator: (value) =>
                                  values.passwordValidation(value),
                            ),
                            SizedBoxes.sizedboxH15,
                            values.saving == true
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : ElevatedButton(
                                    onPressed: () async {
                                      await values.updateData(
                                          context, formKey.currentState!);
                                    },
                                    child: const Text('Save'),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
