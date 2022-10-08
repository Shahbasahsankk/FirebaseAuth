import 'dart:io';

import 'package:firebase_authentication/constants/sizedboxes.dart';
import 'package:firebase_authentication/controller/student_add_edit_delete/student_add_edit_delete_controller.dart';
import 'package:firebase_authentication/controller/home/home_controller.dart';
import 'package:firebase_authentication/model/addStudent/student_model.dart';
import 'package:firebase_authentication/model/screen_check/screen_check_enum.dart';
import 'package:firebase_authentication/view/signup/widgets/form_fields.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/settings/settings_controller.dart';

// ignore: must_be_immutable
class AddStudentScreen extends StatelessWidget {
  AddStudentScreen({
    super.key,
    required this.type,
    this.model,
  });
  final ActionType type;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  StudentModel? model;
  @override
  Widget build(BuildContext context) {
    final addStundentProvider =
        Provider.of<StudentProvider>(context, listen: false);
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    final settingsProvider =
        Provider.of<SettingsProvider>(context, listen: false);
    settingsProvider.img = null;
    addStundentProvider.nameController.clear();
    addStundentProvider.domainController.clear();
    addStundentProvider.ageController.clear();
    addStundentProvider.numberController.clear();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      addStundentProvider.screenCheck(type, model);
    });
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
                    Consumer2<SettingsProvider, StudentProvider>(
                      builder: (context, settingsProvidervalues,
                          studentProviderValues, _) {
                        return Stack(
                          children: [
                            settingsProvidervalues.img == null
                                ? studentProviderValues.donwloadUrl != null
                                    ? CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            studentProviderValues.donwloadUrl!),
                                        radius: 60,
                                      )
                                    : const CircleAvatar(
                                        backgroundColor: Colors.grey,
                                        radius: 60,
                                      )
                                : CircleAvatar(
                                    backgroundImage: FileImage(
                                      File(settingsProvidervalues.img!.path),
                                    ),
                                    radius: 60,
                                  ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 35, top: 105),
                              child: IconButton(
                                onPressed: () =>
                                    settingsProvidervalues.imagepicker(context),
                                icon: const Icon(Icons.add_a_photo),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBoxes.sizedboxH25,
                    SignUpFormFields(
                      controller: addStundentProvider.nameController,
                      hint: 'Student Name',
                      obscure: false,
                      keyboardType: TextInputType.name,
                      action: TextInputAction.next,
                      icon: Icons.account_circle,
                      validator: (value) => addStundentProvider
                          .nameAndDomainValidation(value, 'Name'),
                    ),
                    SizedBoxes.sizedboxH25,
                    SignUpFormFields(
                      controller: addStundentProvider.domainController,
                      hint: 'Student Domain',
                      obscure: false,
                      keyboardType: TextInputType.emailAddress,
                      action: TextInputAction.next,
                      icon: Icons.domain,
                      validator: (value) => addStundentProvider
                          .nameAndDomainValidation(value, 'Domain'),
                    ),
                    SizedBoxes.sizedboxH25,
                    SignUpFormFields(
                      controller: addStundentProvider.ageController,
                      hint: 'Student Age',
                      obscure: false,
                      keyboardType: TextInputType.number,
                      action: TextInputAction.next,
                      icon: Icons.numbers,
                      validator: (value) =>
                          addStundentProvider.ageValidation(value),
                    ),
                    SizedBoxes.sizedboxH25,
                    SignUpFormFields(
                      controller: addStundentProvider.numberController,
                      hint: 'Student Number',
                      obscure: false,
                      keyboardType: TextInputType.phone,
                      action: TextInputAction.done,
                      icon: Icons.phone,
                      validator: (value) =>
                          addStundentProvider.numberValidation(value),
                    ),
                    SizedBoxes.sizedboxH15,
                    Consumer<StudentProvider>(builder: (context, values, _) {
                      return values.isLoading == true
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : ElevatedButton(
                              onPressed: () async {
                                type == ActionType.addStudetnt
                                    ? values.addStudent(
                                        formKey.currentState!,
                                        context,
                                        settingsProvider.img,
                                      )
                                    : values.updateStudent(
                                        formKey.currentState!,
                                        model!.uid,
                                        context,
                                        settingsProvider.img,
                                      );
                                await homeProvider.getStudents();
                              },
                              child: const Text('Add'),
                            );
                    }),
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
