import 'package:flutter/material.dart';
import '../Models/project.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _db = FirebaseFirestore.instance;

class ApplyProjectController {
  CollectionReference _applications = _db.collection('applications');
  static Future<void> applyForJob(BuildContext context, Project project) async {
    // Show a dialog to confirm that the user wants to apply for the job
    bool shouldApply = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Apply for Job'),
          content: Text('Are you sure you want to apply for this job?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text('Apply'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );

    // If the user confirmed that they want to apply for the job, add their application to the database
    if (shouldApply) {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Get the current user's ID
      String userId = FirebaseAuth.instance.currentUser!.uid;

      // Add the application to the "applications" subcollection of the job document
      firestore.collection('applications').doc(userId).set({
        'userId': userId,
        'projectId': project.projectId, // add the project ID to the application
        'appliedAt': DateTime.now(),
      });

      // Show a snackbar to confirm that the user's application has been submitted
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Your application has been submitted.'),
        ),
      );
    }
  }
}
