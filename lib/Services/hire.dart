import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_endear/Models/application.dart';

class ProjectApplicationsController {
  final String projectId;

  ProjectApplicationsController(this.projectId);

  Future<void> hireApplicant(ProjectApplication application) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Update the "hired" field of the application document to true
    await firestore
        .collection('jobs')
        .doc(projectId)
        .collection('applications')
        .doc(application.uid)
        .update({'hired': true});

    // Update the "hiredApplicant" field of the job document to the applicant's user ID
    await firestore.collection('jobs').doc(projectId).update({
      'hiredApplicant': application.uid,
    });
  }
}
