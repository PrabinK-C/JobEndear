import 'package:flutter/material.dart';
import 'package:job_endear/Screens/Authenticate/register.dart';
import 'package:job_endear/Screens/Authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});


  @override
  State<Authenticate> createState() => _authenticateState();
}

// ignore: camel_case_types
class _authenticateState extends State<Authenticate> {
  
    bool showSignIn = true;
     void toggleView(){
      setState(() {
        showSignIn=!showSignIn;
      });
    }
  @override 
  Widget build(BuildContext context) {
    if(showSignIn){
      return SignIn(toggleView: toggleView);
    }  
    else{
      return Register(toggleView: toggleView);

    }

    }

  }
