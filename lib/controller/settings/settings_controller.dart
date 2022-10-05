import 'dart:io';

import 'package:firebase_authentication/services/profile_picture_and_details_update/profile_and_details_update.dart';
import 'package:firebase_authentication/view/settings/widgets/image_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SettingsProvider with ChangeNotifier {
  File? img;
  String? downloadUrl;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
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

  Future<void> updateData() async {
    // if (img != null) {
    //   await ProfileAndDetailsUpdateService().uploadOrUpdateImage(img);
    // }
    await ProfileAndDetailsUpdateService()
        .updateEmailAndUserName(emailController.text, nameController.text);
    notifyListeners();
  }

  Future<void> getProfleImage() async {
    downloadUrl = await ProfileAndDetailsUpdateService().getProfilePic();
    notifyListeners();
  }
}
