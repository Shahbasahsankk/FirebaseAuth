import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/model/signup/user_model.dart';
import 'package:firebase_authentication/view/home/home_screen.dart';
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

  Future<void> updateEmailAndUserName(
      newEmail, newUserName, password, context) async {
    try {
      final cred = EmailAuthProvider.credential(
          email: auth.currentUser!.email!, password: password);
      await FirebaseAuth.instance.currentUser!
          .reauthenticateWithCredential(cred)
          .then((value) async {
            await FirebaseAuth.instance.currentUser
                ?.updateEmail(newEmail)
                .then((value) async {
              await FirebaseFirestore.instance
                  .collection('Users')
                  .doc(auth.currentUser!.uid)
                  .update(
                {
                  "email": newEmail,
                  "firstName": newUserName,
                },
              );
            });
          })
          .then(
            (value) => Fluttertoast.showToast(
              msg: 'Updation Successfull',
              backgroundColor: Colors.green,
            ),
          )
          .then((value) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          });
    } on FirebaseAuthException catch (e) {
      errorCheck(e);
    } catch (e) {
      throw Exception(e.toString());
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

  void errorCheck(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        Fluttertoast.showToast(
            msg: 'Invalid Email Address', backgroundColor: Colors.red);
        break;
      case 'wrong-password':
        Fluttertoast.showToast(
            msg: 'Password Incorrect', backgroundColor: Colors.red);
        break;
      default:
        Fluttertoast.showToast(msg: e.message!, backgroundColor: Colors.red);
    }
  }

  Future<UserModel?> getData() async {
    UserModel? usermMdel;
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(auth.currentUser!.uid)
          .get()
          .then((value) {
        usermMdel = UserModel.fromMap(
          value.data(),
        );
      });
      return usermMdel;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    return null;
  }
}
