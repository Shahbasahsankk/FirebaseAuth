import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/model/addStudent/student_model.dart';
import 'package:firebase_authentication/model/screen_check/screen_check_enum.dart';
import 'package:firebase_authentication/services/home/home_service.dart';
import 'package:firebase_authentication/view/add_student/add_student_screen.dart';
import 'package:firebase_authentication/view/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../services/add_edit_delete_student/add_edit_delete_student_service.dart';

class HomeProvider with ChangeNotifier {
  User? user = FirebaseAuth.instance.currentUser;
  bool isLoading = false;
  List<StudentModel> studentList = [];
  void goToSettingsPage(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SettingsScreen(),
      ),
    );
  }

  void goToAddStudentScreen(context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddStudentScreen(
          type: ActionType.addStudetnt,
        ),
      ),
    );
  }

  void goToEditStudentScreen(context, model) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddStudentScreen(
          type: ActionType.studentView,
          model: model,
        ),
      ),
    );
  }

  void deleteStudent(studentId, HomeProvider values) async {
    isLoading = true;
    notifyListeners();
    await StudentServices().deleteStudent(studentId).then(
      (value) {
        isLoading = false;
        notifyListeners();
        Fluttertoast.showToast(
          msg: 'Deleted student successfully',
          backgroundColor: Colors.red,
        );
      },
    );
    await values.getStudents();
    notifyListeners();
  }

  Future<void> getStudents() async {
    isLoading = true;
    notifyListeners();
    studentList = await HomeService().getData();
    isLoading = false;
    notifyListeners();
  }
}
