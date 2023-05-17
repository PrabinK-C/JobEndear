import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:job_endear/Screens/Authenticate/ForgetPasswordscreen.dart';
import 'package:job_endear/Screens/Authenticate/register.dart';
import 'package:job_endear/Screens/wrapper.dart';
import 'package:job_endear/Services/auth.dart';
import 'package:job_endear/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  const SignIn({super.key, required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

//text field state
  String email = '';
  String password = '';
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: const Color.fromARGB(255, 91, 133, 170),
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(255, 65, 71, 112),
              elevation: 0.0,
              centerTitle: true,
              title: const Text('Sign In  to JobEndear'),
              actions: <Widget>[
                TextButton.icon(
                    icon: const Icon(Icons.person, color: Colors.white),
                    label: const Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    onPressed: () {
                      widget.toggleView();
                    })
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 50.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 10.0),
                      TextFormField(
                          style: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 20.00,
                          ),
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.email,
                              color: Colors.white,
                            ),
                            hintText: "Enter Email",
                            hintStyle: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  width: 5.00),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.lightBlueAccent,
                                width: 3.0,
                              ),
                            ),
                          ),
                          validator: (val) =>
                              val!.isEmpty ? 'Enter an Email' : null,
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          }),
                      const SizedBox(height: 20.0),
                      TextFormField(
                          style: const TextStyle(
                              color: Color.fromARGB(255, 253, 253, 253),
                              fontSize: 20.00),
                          obscureText: _obscure,
                          decoration: InputDecoration(
                              icon: const Icon(
                                Icons.password,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                              hintText: "Enter Password",
                              hintStyle: const TextStyle(
                                  color: Color.fromARGB(255, 248, 248, 248)),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    width: 5.00),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.lightBlueAccent,
                                width: 2.0,
                              )),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _obscure = !_obscure;
                                    });
                                  },
                                  icon: Icon(
                                    _obscure
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color:
                                        const Color.fromARGB(255, 255, 111, 0),
                                  ))),
                          validator: (val) =>
                              val!.length < 6 ? 'Password too short' : null,
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          }),
                      const SizedBox(
                        height: 15.00,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgetPassword()));
                          },
                          child: const Text(
                            "forget password?",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17.00,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Container(
                        padding: const EdgeInsets.only(left: 10),
                        child: MaterialButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() => loading = true);
                              dynamic result = await _auth
                                  .signInWithEmailAndPassword(email, password);
                              if (result == null) {
                                setState(() {
                                  loading = false;
                                  error =
                                      'Could not sign in with those credentials';
                                });
                              } else {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: ((context) => Wrapper())));
                              }
                            }
                          },
                          color: Colors.cyan,
                          elevation: 15,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 14),
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 24),
                            ),
                          ),
                        ),
                      ),
                      // child: Text(
                      ///   'Sign in',
                      //   style: TextStyle(
                      //     color: Colors.white,
                      //     fontWeight: FontWeight.bold,
                      //     fontSize: 16.0),
                      // ),
                      //  style: ButtonStyle(
                      //  backgroundColor:
                      //      MaterialStateProperty.all(Colors.pink[400]),
//side: MaterialStateProperty.all(BorderSide(
                      //    width: 3.0,
                      //   color: Color.fromARGB(255, 181, 199, 214),
                      //  )),
                      //   textStyle: MaterialStateProperty.all(
                      //     TextStyle(color: Colors.white),
                      //   )),

                      // ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Center(
                        child: RichText(
                            text: TextSpan(children: [
                          const TextSpan(
                              text: 'Don"t have an Account? ',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              )),
                          const TextSpan(text: ''),
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Register(
                                              toggleView: () {
                                                setState(() {});
                                              },
                                            ))),
                              text: 'Register',
                              style: const TextStyle(
                                color: Color.fromARGB(255, 215, 237, 235),
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ))
                        ])),
                      ),
                      const SizedBox(height: 12.0),
                      Text(
                        error,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 144, 37, 214),
                            fontSize: 14.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
