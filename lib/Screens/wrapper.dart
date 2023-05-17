// import 'package:firebase_auth/firebase_auth.dart';
// import'package:flutter/material.dart';
// import 'package:job_endear/Screens/Authenticate/authenticate.dart';
// import 'package:job_endear/Screens/Home/Widget/bottom_nav_bar.dart';
// import 'package:job_endear/Screens/Home/home.dart';
// import 'package:job_endear/Screens/freelancer_profile.dart/f_profile_form.dart';
// import 'package:job_endear/Services/auth.dart';
// import 'package:provider/provider.dart';

//   class Wrapper extends StatelessWidget {
//   final FirebaseAuth auth = FirebaseAuth.instance;
//     @override
//     Widget build(BuildContext context){

//       final AuthService authservice = Provider.of<AuthService>(context,listen: false);
//       //return either home or authenticate widget
//     if(authservice.loading){
//       return CircularProgressIndicator();
//     }
//     if (auth.currentUser == null){

//         return Authenticate();

//       } else {

//         String clientId =auth.currentUser!.uid;
//         FirebaseFirestore.instance.collection("jobs").doc(clientId).get().then((DocumentSnapshot snapshot){
//           if (snapshot.exists){
//             print(snapshot.data());
//           }
//           else{
//             print("does not exist");
//           }

//        });
//         return Home();
//       }
//     }
//   }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_endear/Screens/Authenticate/authenticate.dart';
import 'package:job_endear/Screens/ProjectList/projectlist.dart';
import 'package:job_endear/Screens/ProjectPost/project_form.dart';

import 'package:job_endear/Services/auth.dart';
import 'package:job_endear/Services/role_controller.dart';
import 'package:job_endear/shared/loading.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final controller = Get.put(RoleController());
  @override
  Widget build(BuildContext context) {
    controller.getRole();
    final AuthService authservice =
        Provider.of<AuthService>(context, listen: false);
    //return either home or authenticate widget
    if (authservice.loading) {
      return const CircularProgressIndicator();
    }
    if (auth.currentUser == null) {
      return const Authenticate();
    } else {
      return Scaffold(
        body: GetBuilder<RoleController>(builder: (value) {
          if (!value.isLoading && value.roledata.isNotEmpty) {
            var role = value.roledata[0].role;

            if (role == "Freelancer") {
              return Jobscreen();
            } else {
              return const ProjectFormView();
            }
          } else {
            return const Loading();
          }
        }),
      );
    }
  }
}
