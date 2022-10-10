import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/model/signup/user_model.dart';
import 'package:firebase_authentication/view/login/login_screen.dart';
import 'package:firebase_authentication/view/settings/widgets/image_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../../services/profile_picture_and_details_update/profile_and_details_update.dart';
import '../../view/home/home_screen.dart';

class SettingsProvider with ChangeNotifier {
  SettingsProvider() {
    getUserData();
  }
  File? img;
  String? downloadUrl;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  UserModel? loggedInUserModel;
  bool saving = false;
  bool userDataLoading = false;

  void getImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) {
      return;
    } else {
      final imagepath = File(image.path);
      img = imagepath;
    }
    notifyListeners();
  }

  void imagepicker(context) async {
    showDialog(
      context: context,
      builder: (ctx) {
        return const ImagePickerWidget();
      },
    );
  }

  String? passwordValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter your password';
    }
    return null;
  }

  Future<void> updateData(context, FormState currentState) async {
    if (currentState.validate()) {
      saving = true;
      notifyListeners();
      if (img != null) {
        await ProfileAndDetailsUpdateService().uploadOrUpdateImage(img);
      }
      await ProfileAndDetailsUpdateService()
          .updateEmailAndUserName(
        emailController.text,
        nameController.text,
        passwordController.text,
        context,
      )
          .then(
        (value) {
          saving = false;
          notifyListeners();
          getUserData();
          Fluttertoast.showToast(
            msg: 'Updation Successfull',
            backgroundColor: Colors.green,
          );
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        },
      );
    }
  }

  void getUserData() async {
    userDataLoading = true;
    notifyListeners();
    downloadUrl = await ProfileAndDetailsUpdateService().getProfilePic();
    loggedInUserModel = await ProfileAndDetailsUpdateService().getData();
    nameController.text = loggedInUserModel?.firstName ?? "";
    emailController.text = loggedInUserModel?.email ?? "";
    userDataLoading = false;
    notifyListeners();
  }

  void goToLoginPage(context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }

  Future<void> signOut(BuildContext context) async {
    userDataLoading = true;
    notifyListeners();
    await FirebaseAuth.instance.signOut().then(
      (value) {
        userDataLoading = false;
        notifyListeners();
        goToLoginPage(context);
      },
    );
  }
}
