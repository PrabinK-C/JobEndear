import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:job_endear/Models/UserData.dart';

class FreelancerController {
  final CollectionReference _freelancerCollection =
      FirebaseFirestore.instance.collection('freelancers');

  Future<void> saveFreelancer(Freelancer freelancer) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    await _freelancerCollection.doc(uid).set(freelancer.toMap());
  }
}
