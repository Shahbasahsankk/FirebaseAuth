import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/model/addStudent/student_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class StudentServices {
  Future<void> postStudentDetailsToFirestore(
      name, domain, age, number, img, downloadUrl) async {
    try {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      User? user = FirebaseAuth.instance.currentUser;
      final studentId = DateTime.now().microsecondsSinceEpoch.toString();
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('${user!.uid}/images/students')
          .child('profile_$studentId');
      await ref.putFile(img!).then((_) async {
        downloadUrl = await ref.getDownloadURL();
      }).then((value) async {
        StudentModel studentModel = StudentModel(
          uid: studentId,
          name: name,
          domain: domain,
          age: age,
          number: number,
          studentImageUrl: downloadUrl,
        );
        await firebaseFirestore
            .collection('Users')
            .doc(user.uid)
            .collection('Students')
            .doc(studentId)
            .set(
              studentModel.toMap(),
            );
      }).then(
        (value) => Fluttertoast.showToast(
            msg: 'Student added successfully', backgroundColor: Colors.green),
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> deleteStudent(studentId) async {
    try {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      User? user = FirebaseAuth.instance.currentUser;
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('${user!.uid}/images/students')
          .child('profile_$studentId');
      await ref.delete().then((value) async {
        await firebaseFirestore
            .collection('Users')
            .doc(user.uid)
            .collection('Students')
            .doc(studentId)
            .delete();
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString(), backgroundColor: Colors.red);
    }
  }

  Future<void> updateStudent(
      studentId, name, domain, age, number, img, downloadUrl) async {
    try {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      User? user = FirebaseAuth.instance.currentUser;
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('${user!.uid}/images/students')
          .child('profile_$studentId');
      await ref.putFile(img!);
      downloadUrl = await ref.getDownloadURL();
      await firebaseFirestore
          .collection('Users')
          .doc(user.uid)
          .collection('Students')
          .doc(studentId)
          .update(
        {
          'name': name,
          'domain': domain,
          'age': age,
          'number': number,
          'studentImageUrl': downloadUrl,
        },
      ).then(
        (value) => Fluttertoast.showToast(
          msg: 'Updation successfull',
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        backgroundColor: Colors.red,
      );
    }
  }
}
