import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_endear/Screens/ProjectList/projectlist.dart';
import 'package:job_endear/Screens/wrapper.dart';

class UserState extends StatelessWidget {
  const UserState({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, userSnapShot) {
          if (userSnapShot.data == null) {
            debugPrint('user is not logged in yet');
            return Wrapper();
          } else if (userSnapShot.hasData) {
            debugPrint('user is already logged in');
            return Jobscreen();
          } else if (userSnapShot.hasError) {
            return const Scaffold(
              body: Center(
                child:
                    Text('an error has ocurreed has ocurred! try again later'),
              ),
            );
          } else if (userSnapShot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return const Scaffold(
            body: Center(child: Text('something went wrong')),
          );
        });
  }
}
