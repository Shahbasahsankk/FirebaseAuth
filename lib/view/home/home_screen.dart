import 'package:firebase_authentication/constants/sizedboxes.dart';
import 'package:firebase_authentication/controller/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await homeProvider.getStudents();
    });
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
          SizedBoxes.sizedboxH15,
          Expanded(
            child: Consumer<HomeProvider>(
              builder: (context, values, _) {
                return values.isLoading == true
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : values.studentList.isEmpty
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
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(values
                                      .studentList[index].studentImageUrl!),
                                ),
                                title: Text(values.studentList[index].name!),
                                trailing: IconButton(
                                  onPressed: () async {
                                    values.deleteStudent(
                                        values.studentList[index].uid, values);
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
