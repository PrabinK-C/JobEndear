import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:job_endear/Models/project.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Projectpost {
  final CollectionReference _projectCollection =
      FirebaseFirestore.instance.collection('jobs');

  Future<void> postProject(Project project) async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User not signed in');
    }

    try {
      await _projectCollection.add(
        {
          'title': project.title,
          'description': project.description,
          // 'jobField': project.projectField,
          'category': project.category,
          'location': project.location,
          'budget': project.budget,
          // 'deadline': project.deadline,
          'clientId': user.uid,
          // 'status': project.status,
          'requirements': project.requirements,
          'skills': project.skills,
          'experience': project.experience,
          'createdAt': DateTime.now(),
        },
      ).then((DocumentReference ref) => ref.update({'projectId': ref.id}));
      debugPrint("sucessfull");
    } catch (e) {
      throw Exception('Failed to post project: $e');
    }
  }

  Stream<List<Project>> getProjects() {
    return _projectCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Project(
          projectId: doc['projectId'],
          title: doc['title'],
          description: doc['description'],
          // projectField: doc['projectField'],
          category: doc['category'],
          location: doc['location'],
          budget: doc['budget'].toDouble(),
          // deadline: doc['deadline'].toDate(),
          clientId: doc['clientId'],
          // status: doc['status'],
          requirements: doc['requirements'],
          skills: doc['skills'],
          experience: doc['experience'],
          createdAt: doc['createdAt'].toDate(),
        );
      }).toList();
    });
  }
}
