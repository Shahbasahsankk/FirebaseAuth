import 'dart:developer';
import 'dart:io';

import 'package:firebase_authentication/view/settings/widgets/image_picker_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SettingsProvider with ChangeNotifier {
  File? img;
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

  Future<void> uploadImage(email) async {
    final profileId = DateTime.now().microsecondsSinceEpoch.toString();
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('$email/profile_picture')
        .child('profile_$profileId');
    log(img!.toString());
    await ref.putFile(img!);
  }
}
