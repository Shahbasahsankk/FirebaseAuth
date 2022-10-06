import 'package:firebase_authentication/constants/sizedboxes.dart';
import 'package:firebase_authentication/controller/home/home_controller.dart';
import 'package:firebase_authentication/controller/student_add_edit_delete/student_add_edit_delete_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    final studentProvider =
        Provider.of<StudentProvider>(context, listen: false);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => homeProvider.goToAddStudentScreen(context),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Students'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => homeProvider.goToSettingsPage(context),
            icon: const Icon(
              Icons.settings,
              color: Colors.black,
              size: 30,
            ),
          ),
          SizedBoxes.sizedboxW10,
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<HomeProvider>(
              builder: (context, values, _) {
                return values.studentList.isEmpty
                    ? const Center(
                        child: Text('No Data'),
                      )
                    : ListView.separated(
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () => values.goToEditStudentScreen(
                              context,
                              values.studentList[index],
                            ),
                            title: Text(values.studentList[index].name!),
                            trailing: IconButton(
                              onPressed: () async {
                                studentProvider.deleteStudent(
                                    values.studentList[index].uid);
                                await homeProvider.getStudents();
                              },
                              icon: const Icon(
                                Icons.delete_forever,
                                size: 30,
                                color: Colors.red,
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        itemCount: values.studentList.length,
                      );
              },
            ),
          )
        ],
      ),
    );
  }
}
