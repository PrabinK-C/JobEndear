import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_endear/Models/UserData.dart';

class FreelancerProfileController {
  final _freelancerCollection =
      FirebaseFirestore.instance.collection('freelancers');

  Future<Freelancer?> getFreelancerProfile(String uid) async {
    final doc = await _freelancerCollection.doc(uid).get();
    if (!doc.exists) return null;
    final data = doc.data()!;
    return Freelancer.fromMap(data);
  }
}
