import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_endear/Models/project.dart';
import 'package:job_endear/Screens/Home/Widget/bottom_nav_bar.dart';

import 'package:job_endear/Services/project_post.dart';

class ProjectFormView extends StatefulWidget {
  const ProjectFormView({Key? key}) : super(key: key);

  @override
  _ProjectFormViewState createState() => _ProjectFormViewState();
}

class _ProjectFormViewState extends State<ProjectFormView> {
  final _formKey = GlobalKey<FormState>();
  final _projectpost = Projectpost();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final String _clientId = FirebaseAuth.instance.currentUser!.uid;
  bool loading = false;

  late final String _pid = '';
  late String _title = '';
  late String _description = '';
  String? _selectedCategory;

  late final String _category = '';
  late String _location = '';
  late double _budget;
  late String _requirements = '';
  late String _skills = '';
  late String _experience = '';

  // final List<String> _categories = [
  //   'Software Development',
  //   'Information Security',
  //   'Database Administration',
  //   'Cloud Computing',
  //   'Grpahics Designer',
  //   'motion Designer',
  //   '#3D and VFX ',
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigatorforApp(indexNum: 0),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF6600FF),
                Color(0xFF8C309C)
              ], // Replace with your desired gradient colors
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text('Post Project'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => BottomNavigatorforApp(
                  indexNum: 0,
                ),
              ),
            );
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6600FF), Color(0xFF8C309C)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      //Title
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Title'),
                        initialValue: _title,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some experience';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            _title = value!;
                          });
                        },
                      ),
                      //Description
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Description'),
                        initialValue: _description,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some experience';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            _description = value!;
                          });
                        },
                      ),

                      // DropdownButtonFormField<String>(
                      //   decoration: const InputDecoration(
                      //     labelText: 'Category',
                      //   ),
                      //   value: _selectedCategory,
                      //   items: _categories.map((String category) {
                      //     return DropdownMenuItem<String>(
                      //       value: category,
                      //       child: Text(category),
                      //     );
                      //   }).toList(),
                      //   onChanged: (String? value) {
                      //     setState(() {
                      //       _selectedCategory = value;
                      //     });
                      //   },
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return 'Please select a category';
                      //     }
                      //     return null;
                      //   },
                      //   onSaved: (value) {
                      //     setState(() {
                      //       _selectedCategory = value!;
                      //     });
                      //   },
                      // ),
                      // //Location
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Location'),
                        initialValue: _location,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some experience';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            _location = value!;
                          });
                        },
                      ),

                      //Budget
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Budget',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a budget';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Please enter a valid number';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            _budget = double.parse(value!);
                          });
                        },
                      ),

                      //Requirement
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Requirements'),
                        initialValue: _requirements,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some requirements';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            _requirements = value!;
                          });
                        },
                      ),
                      //Skills
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Skills'),
                        initialValue: _skills,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some skills';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            _skills = value!;
                          });
                        },
                      ),
                      //Experience
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Experience'),
                        initialValue: _experience,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some experience';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            _experience = value!;
                          });
                        },
                      ),

                      const SizedBox(height: 16),
                      MaterialButton(
                        color: Colors.cyan,
                        elevation: 15,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            //Add logic to save the form data to Firebase
                            setState(() => loading = true);
                            final Project project = Project(
                                projectId: _pid,
                                title: _title,
                                description: _description,
                                // projectField: _projectField,
                                category: _category,
                                location: _location,
                                budget: _budget,
                                clientId: _clientId,
                                requirements: _requirements,
                                skills: _skills,
                                experience: _experience,
                                createdAt: DateTime.now());
                            await _projectpost.postProject(project);
                          }
                          // Navigator.pushReplacement(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => BottomNavigatorforApp(
                          //       indexNum: 0,
                          //     ),
                          //   ),
                          // );
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 14),
                          child: Text(
                            'Create',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                fontSize: 24),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
