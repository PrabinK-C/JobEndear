import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_endear/Models/UserData.dart';
import 'package:job_endear/Models/application.dart';
import 'package:job_endear/Models/project.dart';
import 'package:job_endear/Screens/Home/Widget/bottom_nav_bar.dart';
import 'package:job_endear/Services/hire.dart';
import 'package:job_endear/Services/project_controller.dart';

import '../HIre.dart';

class ProjectApplicationsPage extends StatefulWidget {
  @override
  _ProjectApplicationsPageState createState() =>
      _ProjectApplicationsPageState();
}

class _ProjectApplicationsPageState extends State<ProjectApplicationsPage> {
  final User? user = FirebaseAuth.instance.currentUser;
  final projectController = Get.put(ProjectController());
  final applicationsController =
      Get.put(ProjectApplicationsController('your_project_id_here'));

  @override
  Widget build(BuildContext context) {
    projectController.getRole();
    return Scaffold(
      bottomNavigationBar: BottomNavigatorforApp(indexNum: 0),
      appBar: AppBar(
        title: const Text('List of Applicant'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6600FF), Color(0xFF8C309C)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6600FF), Color(0xFF8C309C)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: GetBuilder<ProjectController>(builder: (controller) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            // Access the application data and freelancer data from the controller
            List<ProjectApplication> applicationData =
                controller.applicationData;
            List<Freelancer> freelancerData = controller.freelancerData;
            List<UserData> userData = controller.userData;
            List<Project> projectData = controller.projectData;
            return ListView.builder(
              itemCount: userData.length,
              itemBuilder: (context, index) {
                // Display the freelancer details and project details
                return Card(
                  elevation: 2.0,
                  margin: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: ExpansionTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Freelancer: ${userData[index].firstName}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Color.fromARGB(255, 3, 3, 3),
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Experience: ${userData[index].email}',
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Color.fromARGB(255, 10, 10, 10),
                          ),
                        ),
                      ],
                    ),
                    children: [
                      ListTile(
                        title: Text(
                          'Experience: ${userData[index].email}',
                          style: const TextStyle(
                              fontSize: 16.0,
                              color: Color.fromARGB(255, 14, 13, 13)),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Project: ${projectData[index].title}',
                          style: const TextStyle(
                              fontSize: 16.0,
                              color: Color.fromARGB(255, 18, 18, 18)),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Project: ${projectData[index].title}',
                          style: const TextStyle(
                              fontSize: 16.0,
                              color: Color.fromARGB(255, 18, 18, 18)),
                        ),
                      ),
                      ListTile(
                        title: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ProjectApplicationsView(
                                  projectId: '',
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 32, 23, 153),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: const Text(
                              'Hire',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        }),
      ),
    );
  }
}
