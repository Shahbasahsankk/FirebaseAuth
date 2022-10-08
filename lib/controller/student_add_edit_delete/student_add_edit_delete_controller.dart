import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/model/addStudent/student_model.dart';
import 'package:firebase_authentication/model/screen_check/screen_check_enum.dart';
import 'package:firebase_authentication/services/add_edit_delete_student/add_edit_delete_student_service.dart';
import 'package:firebase_authentication/view/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class StudentProvider with ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController domainController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final auth = FirebaseAuth.instance;
  String? donwloadUrl;
  File? img;
  bool isLoading = false;

  String? nameAndDomainValidation(String? value, String text) {
    if (value == null || value.isEmpty) {
      return '$text cannot be empty';
    }
    return null;
  }

  String? ageValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Age cannot be empty';
    } else if (value.length >= 3) {
      return 'Enter valid age';
    }
    return null;
  }

  String? numberValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Number cannot be empty';
    } else if (value.length != 10) {
      return 'Number must be 10 digits';
    }
    return null;
  }

  void screenCheck(ActionType type, StudentModel? model) {
    if (type == ActionType.studentView) {
      nameController.text = model!.name!;
      domainController.text = model.domain!;
      ageController.text = model.age!;
      numberController.text = model.number!;
      donwloadUrl = model.studentImageUrl;
    }
    notifyListeners();
  }

  void addStudent(FormState currentState, context, img) async {
    if (img == null) {
      Fluttertoast.showToast(
          msg: 'Pick and Image', backgroundColor: Colors.red);
    }
    if (currentState.validate() && img != null) {
      isLoading = true;
      notifyListeners();
      await StudentServices()
          .postStudentDetailsToFirestore(
        nameController.text,
        domainController.text,
        ageController.text,
        numberController.text,
        img,
        donwloadUrl,
      )
          .then((value) {
        isLoading = false;
        notifyListeners();
        Navigator.of(context).pushAndRemoveUntil(
            (MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            )),
            (route) => false);
      });
    }
  }

  void updateStudent(FormState currentState, studentId, context, img) async {
    if (img == null) {
      Fluttertoast.showToast(
          msg: 'Pick and Image', backgroundColor: Colors.red);
    }
    if (currentState.validate() && img != null) {
      isLoading = true;
      notifyListeners();
      await StudentServices()
          .updateStudent(
        studentId,
        nameController.text,
        domainController.text,
        ageController.text,
        numberController.text,
        img,
        donwloadUrl,
      )
          .then(
        (value) {
          isLoading = false;
          notifyListeners();
          Navigator.of(context).pushAndRemoveUntil(
              (MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              )),
              (route) => false);
        },
      );
    }
  }
}
