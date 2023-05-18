import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:job_endear/Models/UserData.dart';
import 'package:job_endear/Models/project.dart';

class AlgorithmInputController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Project> projectData = [];
  List<Freelancer> freelancerData = [];
  bool isloading = true;
  @override
  void onInit() {
    super.onInit();
    getFreelancerData();
    getProjectData();
  }

  Future<void> getFreelancerData() async {
    try {
      String? uid = auth.currentUser?.uid;
      await _firestore
          .collection('freelancers')
          .where('freelancerId', isEqualTo: uid)
          .get()
          .then((value) {
        freelancerData =
            value.docs.map((e) => Freelancer.fromJson(e.data())).toList();
        debugPrint(freelancerData.toString());
        isloading = false;
        update();
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getProjectData() async {
    try {
      await _firestore.collection('jobs').get().then((value) {
        projectData =
            value.docs.map((e) => Project.fromJson(e.data())).toList();
        debugPrint(projectData.toString());
        isloading = false;
        update();
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
