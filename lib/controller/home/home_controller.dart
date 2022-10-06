import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/model/addStudent/student_model.dart';
import 'package:firebase_authentication/model/screen_check/screen_check_enum.dart';
import 'package:firebase_authentication/services/home/home_service.dart';
import 'package:firebase_authentication/view/add_student/add_student_screen.dart';
import 'package:firebase_authentication/view/settings/settings_screen.dart';
import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  HomeProvider() {
    getStudents();
  }
  User? user = FirebaseAuth.instance.currentUser;

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

  Future<void> getStudents() async {
    studentList = await HomeService().getData();
    notifyListeners();
  }
}
