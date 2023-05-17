import 'package:flutter/material.dart';
import 'package:job_endear/Models/project.dart';
import 'package:job_endear/Screens/Home/Widget/bottom_nav_bar.dart';
import 'package:job_endear/Services/apply_project.dart';

class ProjectDetailsPage extends StatelessWidget {
  final Project project;

  const ProjectDetailsPage({Key? key, required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigatorforApp(indexNum: 0),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 113, 46, 248), Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 113, 46, 248),
                    Colors.blueAccent
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: AppBar(
                backgroundColor: Colors.transparent,
                title: const Text('Project Details'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[100],
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 148, 125, 125)
                          .withOpacity(0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project.title,
                        style: const TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      _buildProjectDetailRow(
                          'Description', project.description),
                      const SizedBox(height: 8.0),
                      _buildProjectDetailRow(
                          'Budget', '\$${project.budget.toStringAsFixed(2)}'),
                      const SizedBox(height: 8.0),
                      _buildProjectDetailRow('Category', project.category),
                      const SizedBox(height: 8.0),
                      _buildProjectDetailRow('Location', project.location),
                      const SizedBox(height: 8.0),
                      _buildProjectDetailRow(
                          'Requirements', project.requirements),
                      const SizedBox(height: 8.0),
                      _buildProjectDetailRow('Skills', project.skills),
                      const SizedBox(height: 8.0),
                      _buildProjectDetailRow('Experience', project.experience),
                      const SizedBox(height: 16.0),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Center(
                          child: MaterialButton(
                            onPressed: () {
                              ApplyProjectController.applyForJob(
                                  context, project);
                            },
                            color: Colors.cyan,
                            elevation: 15,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 18),
                              child: Text(
                                'Apply',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        Flexible(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 16.0,
            ),
          ),
        ),
      ],
    );
  }
}
