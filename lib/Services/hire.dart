import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:job_endear/Models/application.dart';

final FirebaseFirestore _db = FirebaseFirestore.instance;

class ProjectApplicationsController {
  final String projectId;
  final FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference _applications = _db.collection('applications');

  ProjectApplicationsController(this.projectId);

  Stream<List<ProjectApplication>> getApplicationsStream() {
    return _applications
        .where('projectId', isEqualTo: projectId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map<ProjectApplication>(
                (doc) => ProjectApplication.fromSnapshot(doc))
            .toList());
  }

  Future<void> hireApplicant(ProjectApplication application) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    String? clientId = auth.currentUser?.uid;
    String uid = clientId.toString();
    // Update the "hired" field of the application document to true
    await firestore
        .collection('applications')
        .doc(application.userId)
        .update({'hired': true, 'clientId': uid});

    // Update the "hiredApplicant" field of the job document to the applicant's user ID
    await firestore.collection('applications').doc(projectId).update({
      'hiredApplicant': application.userId,
    });
  }
}
