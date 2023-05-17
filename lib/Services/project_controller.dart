import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:job_endear/Models/UserData.dart';
import 'package:job_endear/Models/application.dart';
import 'package:job_endear/Models/project.dart';

class ProjectController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Role> roledata = [];
  List<Project> projectData = [];
  List<Freelancer> freelancerData = [];

  List<ProjectApplication> applicationData = [];
  bool isLoading = true;

  Future<void> getProject(String clientId) async {
    try {
      await _firestore
          .collection('jobs')
          .where('clientId', isEqualTo: clientId)
          .get()
          .then(((value) {
        projectData = value.docs
            .map<Project>(
                (e) => Project.fromJson(e.data() as Map<String, dynamic>))
            .toList();
        //  debugPrint(projectData[0].description);

        for (int i = 0; i < projectData.length; i++) {
          getApplication(projectData[i].projectId);
        }
        isLoading = false;
        update();
      }));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getApplication(String projectId) async {
    try {
      await _firestore
          .collection('jobs')
          .doc(projectId)
          .collection('applications')
          .where('projectId', isEqualTo: projectId)
          .get()
          .then(((value) {
        applicationData = value.docs
            .map<ProjectApplication>((e) =>
                ProjectApplication.fromJson(e.data() as Map<String, dynamic>))
            .toList();

        debugPrint(
            "GET APPLICATION: " + applicationData[0].projectId.toString());
        debugPrint("iamheereee");
        for (int i = 0; i < projectData.length; i++) {
          getFreelancer(applicationData[i].projectId.toString());
        }
        isLoading = false;
        update();
      }));
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getFreelancer(String freelancerId) async {
    try {
      await _firestore
          .collection('freelancers')
          .where('freelancerId', isEqualTo: freelancerId)
          .get()
          .then(((value) {
        freelancerData = value.docs
            .map<Freelancer>(
                (e) => Freelancer.fromJson(e.data() as Map<String, dynamic>))
            .toList();
        // debugPrint(freelancerData.toString());

        isLoading = false;
        update();
      }));
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getRole() async {
    try {
      String? clientId = auth.currentUser?.uid;
      String uid = clientId.toString();
      await _firestore
          .collection('users')
          .where('userId', isEqualTo: uid)
          .get()
          .then(((value) {
        roledata = value.docs.map((e) => Role.fromJson(e.data())).toList();
        // debugPrint(roledata[0].email);
        getProject(uid);

        isLoading = false;

        update();
      }));
    } catch (e) {
      print(e.toString());
    }
  }
}
