import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_endear/Models/UserData.dart';
import 'package:job_endear/Screens/CV/cv_freelancer.dart';
import 'package:job_endear/Services/fprofile_form.dart';

import '../Home/Widget/bottom_nav_bar.dart';
import '../ProjectList/projectlist.dart';

// class FreelancerProfilePostView extends StatefulWidget {
//   const FreelancerProfilePostView({super.key});

//   @override
//   _FreelancerProfilePostViewState createState() =>
//       _FreelancerProfilePostViewState();
// }

// class _FreelancerProfilePostViewState extends State<FreelancerProfilePostView> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _skillsController = TextEditingController();
//   final _experienceController = TextEditingController();
//   final _categoryController = TextEditingController();
//   final TextEditingController _cvController = TextEditingController(text: "cv");
//   final _uid = FirebaseAuth.instance.currentUser?.uid;

//   final FreelancerController _controller = FreelancerController();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Color(0xFF6600FF), Color(0xFF8C309C)],
//           begin: Alignment.centerLeft,
//           end: Alignment.centerRight,
//         ),
//       ),
//       child: Scaffold(
//         bottomNavigationBar: BottomNavigatorforApp(indexNum: 2),
//         appBar: AppBar(
//           title: const Text('Create Freelancer Profile'),
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back),
//             onPressed: () {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => BottomNavigatorforApp(indexNum: 0),
//                 ),
//               );
//             },
//           ),
//         ),
//         backgroundColor: Colors.transparent,
//         body: Padding(
//           padding: const EdgeInsets.fromLTRB(16, 16, 14, 0),
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(10),
//               boxShadow: [
//                 BoxShadow(
//                   color:
//                       const Color.fromARGB(255, 202, 153, 153).withOpacity(0.5),
//                   spreadRadius: 2,
//                   blurRadius: 5,
//                   offset: const Offset(0, 3),
//                 ),
//               ],
//             ),
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       controller: _nameController,
//                       decoration: const InputDecoration(
//                         labelText: 'Name',
//                         icon: Icon(Icons.person), // Icon for label
//                       ),
//                       style: const TextStyle(
//                           fontSize: 18,
//                           fontWeight:
//                               FontWeight.bold), // Custom font size and weight
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your name';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 16),
//                     TextFormField(
//                       controller: _skillsController,
//                       decoration: const InputDecoration(
//                         labelText: 'Skills (comma separated)',
//                         icon: Icon(Icons.star), // Icon for label
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your skills';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 16),
//                     TextFormField(
//                       controller: _experienceController,
//                       decoration: const InputDecoration(
//                         labelText: 'Years of Experience(in Years)',
//                         icon: Icon(Icons.calendar_today), // Icon for label
//                       ),
//                       keyboardType: TextInputType.number,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your years of experience';
//                         }
//                         if (int.tryParse(value) == null) {
//                           return 'Please enter a valid number';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 16),
//                     DropdownButtonFormField<String>(
//                       value: _categoryController.text.isNotEmpty
//                           ? _categoryController.text
//                           : null,
//                       items: [
//                         'Web Development',
//                         'Mobile Development',
//                         'Graphic Design',
//                         'Content Writing',
//                         'Aniamtion and VFX',
//                         'Software Development',
//                         'Testing and Evalution',
//                         'Networking',
//                         'Software Devlopment',
//                       ]
//                           .map((category) => DropdownMenuItem(
//                                 value: category,
//                                 child: Text(category),
//                               ))
//                           .toList(),
//                       onChanged: (newValue) {
//                         setState(() {
//                           _categoryController.text = newValue!;
//                         });
//                       },
//                       decoration: const InputDecoration(
//                         labelText: 'Field of expertise',
//                         icon: Icon(Icons.category),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please select a field of expertise';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(
//                       height: 16,
//                     ),
//                     TextFormField(
//                       controller: _cvController,
//                       decoration: const InputDecoration(
//                         labelText: 'CV',
//                         icon: Icon(Icons.category),
//                         hintText: 'Upload your CV',
//                       ),
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (_) => const UploadCvPage()),
//                         );
//                       },
//                       // validator: (value) {
//                       //   if (value == null || value.isEmpty) {
//                       //     return 'select a file';
//                       //   }
//                       // },
//                     ),
//                     const SizedBox(height: 16),
//                     MaterialButton(
//                       onPressed: () {
//                         debugPrint(_uid.toString());
//                         debugPrint(_categoryController.text);
//                         debugPrint(_skillsController.text);
//                         debugPrint(_experienceController.text);

//                         debugPrint("Hello Button Pressed");

//                         if (_formKey.currentState!.validate()) {
//                           _formKey.currentState!.save();
//                           debugPrint(DateTime.now().toString());

//                           final freelancerProfile = Freelancer(
//                             freelancerId: _uid!,
//                             category: _categoryController.text,
//                             skills: _skillsController.text,
//                             experience: _experienceController.text.toString(),
//                             createdAt: DateTime.now(),
//                           );

//                           debugPrint("Create buttton pressed");
//                           _controller.saveFreelancer(freelancerProfile);
//                         }
//                         Navigator.pop(context);
//                       },
//                       color: Colors.cyan,
//                       elevation: 15,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(14)),
//                       child: const Padding(
//                         padding: EdgeInsets.symmetric(vertical: 14),
//                         child: Text(
//                           'Create',
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontStyle: FontStyle.italic,
//                               fontSize: 24),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:job_endear/Models/UserData.dart';
// import 'package:job_endear/Screens/CV/cv_freelancer.dart';
// import 'package:job_endear/Screens/Home/Widget/bottom_nav_bar.dart';
// import 'package:job_endear/Screens/ProjectList/projectlist.dart';
// import 'package:job_endear/Services/fprofile_form.dart';

class FreelancerProfilePostView extends StatefulWidget {
  @override
  _FreelancerProfilePostViewState createState() =>
      _FreelancerProfilePostViewState();
}

class _FreelancerProfilePostViewState extends State<FreelancerProfilePostView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _skillsController = TextEditingController();
  final _experienceController = TextEditingController();
  final _categoryController = TextEditingController();
  final _uid = FirebaseAuth.instance.currentUser?.uid;

  final FreelancerController _controller = FreelancerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigatorforApp(indexNum: 2),
      appBar: AppBar(
        title: const Text('Create Freelancer Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => Jobscreen()));
          },
        ),
      ),
      backgroundColor:
          const Color.fromARGB(255, 71, 20, 240), // Custom color scheme
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6600FF), Color(0xFF8C309C)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            // Card widget
            elevation: 8,
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      icon: Icon(Icons.person), // Icon for label
                    ),
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight:
                            FontWeight.bold), // Custom font size and weight
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _skillsController,
                    decoration: const InputDecoration(
                      labelText: 'Skills (comma separated)',
                      icon: Icon(Icons.star), // Icon for label
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your skills';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _experienceController,
                    decoration: const InputDecoration(
                      labelText: 'Years of Experience(in months)',
                      icon: Icon(Icons.calendar_today), // Icon for label
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your years of experience';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _categoryController.text.isNotEmpty
                        ? _categoryController.text
                        : null,
                    items: [
                      'Web Development',
                      'Mobile Development',
                      'Graphic Design',
                      'Content Writing'
                    ]
                        .map((category) => DropdownMenuItem(
                              value: category,
                              child: Text(category),
                            ))
                        .toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _categoryController.text = newValue!;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Field of expertise',
                      icon: Icon(Icons.category),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a field of expertise';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'CV',
                      icon: Icon(Icons.category),
                      hintText: 'Upload your CV',
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const UploadCvPage()),
                      );
                    },
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'select a file';
                    //   }
                    //   return null;
                    // },
                  ),
                  const SizedBox(height: 16),
                  MaterialButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        final freelancerProfile = Freelancer(
                          freelancerId: _uid!,
                          category: _categoryController.text,
                          skills: _skillsController.text,
                          experience: _experienceController.text.toString(),
                          createdAt: DateTime.now(),
                        );

                        _controller.saveFreelancer(freelancerProfile);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FreelancerProfilePostView(),
                          ),
                        );
                      }
                    },
                    color: Colors.cyan,
                    elevation: 15,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
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
    );
  }
}
