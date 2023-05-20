import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_endear/Models/application.dart';
import '../Services/hire.dart';

class ProjectApplicationsView extends StatelessWidget {
  final String projectId;

  const ProjectApplicationsView({required this.projectId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hiring Page'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue,
              Colors.lightBlueAccent,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: StreamBuilder<List<ProjectApplication>>(
          stream:
              ProjectApplicationsController(projectId).getApplicationsStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final applications = snapshot.data!;
              return ListView.builder(
                itemCount: applications.length,
                itemBuilder: (context, index) {
                  final application = applications[index];
                  return ListTile(
                    title: Text(
                      'Applicant: ${application.userId}',
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                    trailing: ElevatedButton(
                      onPressed: () async {
                        await ProjectApplicationsController(projectId)
                            .hireApplicant(application);
                        Fluttertoast.showToast(
                          msg: 'Applicant Hired!',
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                        );
                      },
                      child: const Text('Hire'),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Color.fromARGB(255, 199, 166, 166)),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
