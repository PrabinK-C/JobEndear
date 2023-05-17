import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_endear/Models/project.dart';
import 'package:job_endear/Screens/Home/Widget/bottom_nav_bar.dart';

import 'package:job_endear/Screens/Project_detail/project_detail.dart';

class Jobscreen extends StatefulWidget {
  late String title;
  late String description;

  Jobscreen({super.key});
  @override
  State<Jobscreen> createState() => _JobscreenState();
}

class _JobscreenState extends State<Jobscreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Image.asset(
        //  'assets/images/background.jpg',
        //  height: MediaQuery.of(context).size.height,
        //  width: MediaQuery.of(context).size.width,
        //  fit: BoxFit.cover,
        //  ),
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6600FF), Color(0xFF8C309C)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Scaffold(
            bottomNavigationBar: BottomNavigatorforApp(indexNum: 0),
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: const Text(
                'Project List',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF6600FF),
                      Color(0xFF8C309C),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
            ),
            body: StreamBuilder<List<Project>>(
              stream: FirebaseFirestore.instance
                  .collection('jobs')
                  .snapshots()
                  .map((snapshot) {
                return snapshot.docs
                    .map((doc) => Project.fromFirestore(doc))
                    .toList();
              }),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Project>> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const Center(child: CircularProgressIndicator());
                  default:
                    final List<Project> projects = snapshot.data ?? <Project>[];

                    return ListView.builder(
                      itemCount: projects.length,
                      itemBuilder: (BuildContext context, int index) {
                        final Project project = projects[index];
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Card(
                            elevation: 5.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(15.0),
                              splashColor: Colors.blueAccent,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProjectDetailsPage(
                                      project: project,
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      project.title,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 32.0,
                                        color: const Color.fromARGB(
                                            255, 59, 27, 49),
                                        letterSpacing: 1.5,
                                        fontStyle: FontStyle.italic,
                                        decorationThickness: 2.0,
                                        shadows: [
                                          Shadow(
                                            color: Colors.grey.withOpacity(0.9),
                                            offset: const Offset(4, 4),
                                            blurRadius: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 16.0),
                                    Text(
                                      project.description,
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    const SizedBox(height: 16.0),
                                    Text(
                                      '\$${project.budget.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24.0,
                                        color: Colors.blue[900],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
