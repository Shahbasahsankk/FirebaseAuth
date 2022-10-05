import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfileAndDetailsUpdateService {
  final auth = FirebaseAuth.instance;
  Future<void> uploadOrUpdateImage(img) async {
    try {
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('${auth.currentUser!.uid}/images/profile_picture')
          .child('profile_${auth.currentUser!.uid}');
      await ref.putFile(img!);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> updateEmailAndUserName(newEmail, newUserName) async {
    try {
      await FirebaseAuth.instance.currentUser
          ?.updateEmail(newEmail)
          .then((value) async {
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(auth.currentUser!.uid)
            .update(
          {
            'email': newEmail,
            'firstName': newUserName,
          },
        );
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<String?> getProfilePic() async {
    try {
      String? url;
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('${auth.currentUser!.uid}/images/profile_picture')
          .child('profile_${auth.currentUser!.uid}');
      url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString(), backgroundColor: Colors.red);
    }
    return null;
  }
}
