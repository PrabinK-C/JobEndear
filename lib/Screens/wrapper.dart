import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_endear/Screens/Authenticate/authenticate.dart';

import 'package:job_endear/Screens/Project_detail/applicant_list.dart';
import 'package:job_endear/Services/auth.dart';
import 'package:job_endear/Services/role_controller.dart';
import 'package:job_endear/shared/loading.dart';
import 'package:provider/provider.dart';

import 'freelancer_profile.dart/f_profile_form.dart';

class Wrapper extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final controller = Get.put(RoleController());

  @override
  Widget build(BuildContext context) {
    controller.getRole();
    final AuthService authservice =
        Provider.of<AuthService>(context, listen: false);
    // Return either home or authenticate widget
    if (authservice.loading) {
      return const CircularProgressIndicator();
    }
    if (auth.currentUser == null) {
      return const Authenticate();
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: false, // Hide the debug banner
        home: Scaffold(
          body: GetBuilder<RoleController>(builder: (value) {
            if (!value.isLoading && value.roledata.isNotEmpty) {
              var role = value.roledata[0].role;
              if (role == "Freelancer") {
                return FreelancerProfilePostView();
              } else {
                return ProjectApplicationsPage();
              }
            } else {
              return const Loading();
            }
          }),
        ),
      );
    }
  }
}
