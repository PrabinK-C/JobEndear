import 'package:flutter/cupertino.dart';
import 'package:job_endear/Models/project.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Projectpost {
  final CollectionReference _projectCollection =
      FirebaseFirestore.instance.collection('jobs');

  Future<void> postProject(Project project) async {
    try {
      await _projectCollection.add(project.toFirestore());
      debugPrint("Successfully posted project.");
    } catch (e) {
      throw Exception('Failed to post project: $e');
    }
  }
}
