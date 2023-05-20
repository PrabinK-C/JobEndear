import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:job_endear/Screens/Authenticate/sign_in.dart';
import 'package:job_endear/Services/auth.dart';
import 'package:job_endear/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  const Register({super.key, required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String firstName = '';
  String lastName = '';
  String? role;
  String? companyName;
  String? companyAddress;
  String? freelancerTitle;
  String? freelancerDescription;
  bool _obscure = true;
  bool _isValidEmail(String email) {
    return EmailValidator.validate(email);
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            backgroundColor: Color.fromARGB(255, 109, 185, 211),
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(255, 136, 131, 202),
              centerTitle: true,
              title: const Text('Register to JobEndear'),
              actions: <Widget>[
                TextButton.icon(
                    icon: const Icon(
                      Icons.person,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    label: const Text(
                      'Sign In',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      widget.toggleView();
                    })
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 30.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 10.0),
                      TextFormField(
                        style: const TextStyle(
                            color: Colors.white, fontSize: 20.00),
                        decoration: const InputDecoration(
                          icon: Icon(
                            Icons.email,
                            color: Colors.white,
                          ),
                          hintText: "Enter Email",
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 255, 255, 255),
                                width: 5.00),
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.lightBlueAccent,
                            width: 2.0,
                          )),
                        ),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Enter an email';
                          } else if (!_isValidEmail(val)) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                      ),

                      const SizedBox(height: 10.0),
                      TextFormField(
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20.00),
                          obscureText: _obscure,
                          decoration: InputDecoration(
                              icon: const Icon(
                                Icons.password,
                                color: Colors.white,
                              ),
                              hintText: "Enter Password",
                              hintStyle: const TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255)),
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
                                    color: Colors.brown,
                                  ))),
                          validator: (val) =>
                              val!.length < 6 ? 'Password too short' : null,
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          }),

                      const SizedBox(height: 10.0),
                      TextFormField(
                        style: const TextStyle(
                            color: Colors.white, fontSize: 20.00),
                        decoration: const InputDecoration(
                          icon: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          hintText: "Enter First Name",
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 255, 255, 255),
                                width: 5.00),
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.lightBlueAccent,
                            width: 2.0,
                          )),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your first name';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            firstName = value.trim();
                          });
                        },
                      ),

                      const SizedBox(height: 10.0),
                      TextFormField(
                        style: const TextStyle(
                            color: Colors.white, fontSize: 20.00),
                        decoration: const InputDecoration(
                          icon: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          hintText: "Enter Last Name",
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 255, 255, 255),
                                width: 5.00),
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.lightBlueAccent,
                            width: 2.0,
                          )),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your last name';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            lastName = value.trim();
                          });
                        },
                      ),

                      const SizedBox(height: 10.0),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          icon: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          hintText: 'Select Role',
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 255, 255, 255),
                                width: 5.00),
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.lightBlueAccent,
                            width: 2.0,
                          )),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a role';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            role = value;
                          });
                        },
                        items: ['Client', 'Freelancer']
                            .map((role) => DropdownMenuItem(
                                  value: role,
                                  child: Text(role),
                                ))
                            .toList(),
                      ),
                      if (role == 'Client')
                        Column(
                          children: [
                            const SizedBox(height: 10.0),
                            TextFormField(
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              decoration: const InputDecoration(
                                labelText: 'Company Name',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your company name';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  companyName = value.trim();
                                });
                              },
                            ),
                            const SizedBox(height: 10.0),
                            TextFormField(
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                  labelText: 'Company Address',
                                  iconColor: Color.fromARGB(255, 212, 91, 91)),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your company address';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  companyAddress = value.trim();
                                });
                              },
                            ),
                            const SizedBox(height: 10.0),
                            Container(
                              padding: const EdgeInsets.only(left: 10),
                              child: MaterialButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() => loading = true);
                                    dynamic result = await _auth.registerClient(
                                      email,
                                      password,
                                      firstName,
                                      lastName,
                                      role,
                                      companyName,
                                      companyAddress,
                                    );
                                    if (result == null) {
                                      setState(() {
                                        loading = false;
                                        error = 'Please supply a valid email';
                                      });
                                    } else {
                                      Navigator.pop(context);
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
                                    'Register',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 24),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),

                      //    //Freelancer
                      if (role == 'Freelancer')
                        Column(
                          children: [
                            const SizedBox(height: 10.0),
                            TextFormField(
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                  labelText: 'Title',
                                  iconColor: Colors.black12),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your title';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  freelancerTitle = value.trim();
                                });
                              },
                            ),
                            const SizedBox(height: 10.0),
                            TextFormField(
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                labelText: 'Description',
                                iconColor: Color.fromARGB(31, 64, 5, 5),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your description';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  freelancerDescription = value.trim();
                                });
                              },
                            ),
                            const SizedBox(height: 10.0),
                            MaterialButton(
                              color: Colors.cyan,
                              elevation: 15,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14)),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 14),
                                child: Text(
                                  'Register ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 24),
                                ),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() => loading = true);
                                  final currentContext = context;
                                  dynamic result =
                                      await _auth.registerFreelancer(
                                    email,
                                    password,
                                    firstName,
                                    lastName,
                                    role,
                                    freelancerTitle,
                                    freelancerDescription,
                                  );
                                  if (result == null) {
                                    setState(() {
                                      loading = false;
                                      error = 'Please supply a valid email';
                                    });
                                  } else {
                                    Navigator.pop(currentContext);
                                    // ignore: use_build_context_synchronously
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            SignIn(toggleView: () {}),
                                      ),
                                    );
                                  }
                                }
                              },
                            )
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
