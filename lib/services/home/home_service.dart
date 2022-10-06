import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/model/addStudent/student_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeService {
  final auth = FirebaseAuth.instance;
  Future<List<StudentModel>> getData() async {
    final List<StudentModel> foundList = [];
    try {
      final value = await FirebaseFirestore.instance
          .collection('Users')
          .doc(auth.currentUser!.uid)
          .collection('Students')
          .get();
      final List<QueryDocumentSnapshot<Map<String, dynamic>>> list = value.docs;
      for (var element in list) {
        foundList.add(
          StudentModel.fromMap(
            element.data(),
          ),
        );
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    return foundList;
  }
}
