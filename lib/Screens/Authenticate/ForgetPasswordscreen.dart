import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_endear/Screens/Authenticate/sign_in.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _forgetpassTextcontroller =
      TextEditingController(text: '');

  void _fogetpassSubmitForm() async {
    try {
      await _auth.sendPasswordResetEmail(
        email: _forgetpassTextcontroller.text,
      );
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => SignIn(
                    toggleView: () {},
                  )));
    } catch (error) {
      Fluttertoast.showToast(msg: error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(184, 77, 16, 232),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 50),
              const Text(
                'Forgot Password',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
              const SizedBox(height: 50),
              TextFormField(
                controller: _forgetpassTextcontroller,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                    fontFamily: 'Montserrat',
                  ),
                  hintText: "Enter Email",
                  hintStyle:
                      TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 255, 255, 255), width: 5.00),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.lightBlueAccent,
                      width: 3.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: size.width * 0.8,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: MaterialButton(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    onPressed: () {
                      _fogetpassSubmitForm();
                    },
                    color: Colors.blue,
                    child: const Text(
                      'Reset Password',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
