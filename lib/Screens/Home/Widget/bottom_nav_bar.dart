import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_endear/Screens/Authenticate/sign_in.dart';

import 'package:job_endear/Screens/ProjectList/projectlist.dart';

import 'package:job_endear/Screens/ProjectPost/project_form.dart';
import 'package:job_endear/Screens/Project_detail/applicant_list.dart';
import 'package:job_endear/Screens/Search/profile_company.dart';
import 'package:job_endear/Screens/Search/search_comapnies.dart';
import 'package:job_endear/Screens/freelancer_profile.dart/f_profile_form.dart';
import 'package:job_endear/Screens/freelancer_profile.dart/profile_post.dart';

import '../../../Services/role_controller.dart';

class BottomNavigatorforApp extends StatelessWidget {
  int indexNum = 0;
  BottomNavigatorforApp({super.key, required this.indexNum});

  void _logout(context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              backgroundColor: Colors.black54,
              title: Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.logout,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'signout',
                      style: TextStyle(fontSize: 28, color: Colors.white),
                    ),
                  )
                ],
              ),
              content: const Text(
                "do you want to logout",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.canPop(context) ? Navigator.pop(context) : null;
                    },
                    child: const Text('no',
                        style: TextStyle(
                            color: Color.fromARGB(255, 3, 255, 91),
                            fontSize: 18))),
                TextButton(
                    onPressed: () {
                      Navigator.canPop(context) ? Navigator.pop(context) : null;
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => SignIn(toggleView: () {})));
                    },
                    child: const Text('yes',
                        style: TextStyle(
                            color: Color.fromARGB(255, 247, 6, 6),
                            fontSize: 18))),
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final controller = Get.put(RoleController());

    String role =
        controller.roledata.isNotEmpty ? controller.roledata[0].role : '';

    return CurvedNavigationBar(
      backgroundColor: const Color.fromARGB(255, 103, 175, 226),
      color: const Color.fromARGB(255, 12, 98, 246),
      buttonBackgroundColor: const Color.fromARGB(255, 21, 201, 159),
      height: 60,
      index: indexNum,
      items: [
        if (role == 'Freelancer')
          const Icon(
            Icons.list,
            size: 24,
            color: Colors.black,
          ),
        if (role == 'Freelancer')
          const Icon(
            Icons.search,
            size: 24,
            color: Colors.black,
          ),
        if (role == 'Freelancer')
          const Icon(
            Icons.add,
            size: 24,
            color: Colors.black,
          ),
        if (role == 'Freelancer')
          const Icon(
            Icons.person_pin,
            size: 24,
            color: Colors.black,
          ),
        if (role == 'Client')
          const Icon(
            Icons.post_add,
            size: 24,
            color: Colors.black,
          ),
        if (role == 'Client')
          const Icon(
            Icons.add_box_outlined,
            size: 24,
            color: Colors.black,
          ),
        if (role == 'Client')
          const Icon(
            Icons.person_2_sharp,
            size: 24,
            color: Colors.black,
          ),
        const Icon(
          Icons.exit_to_app,
          size: 24,
          color: Colors.black,
        ),
      ],
      animationDuration: const Duration(milliseconds: 100),
      onTap: (index) {
        if (role == 'Freelancer') {
          if (index == 0) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => Jobscreen()));
          } else if (index == 1) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const SearchScreen()));
          } else if (index == 2) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (_) => const FreelancerProfilePostView()));
          } else if (index == 3) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (_) => const FreelancerProfileView()));
          } else if (index == 4) {
            _logout(context);
          }
        } else if (role == 'Client') {
          // Client navigation
          if (index == 0) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => ProjectApplicationsPage()));
          } else if (index == 1) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const ProjectFormView()));
          } else if (index == 1) {
          } else if (index == 2) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const ProfileScreen()));
          } else if (index == 3) {
            _logout(context);
          }
        }
      },
    );
  }
}

// class BottomNavigatorforApp extends StatelessWidget {
//   final int indexNum;

//   BottomNavigatorforApp({required this.indexNum});

//   void _logout(BuildContext context) {
//     final FirebaseAuth _auth = FirebaseAuth.instance;
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           backgroundColor: Colors.black54,
//           title: Row(
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(10.0),
//                 child: Icon(
//                   Icons.logout,
//                   color: Colors.white,
//                   size: 36,
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(10.0),
//                 child: Text(
//                   'signout',
//                   style: TextStyle(fontSize: 28, color: Colors.white),
//                 ),
//               )
//             ],
//           ),
//           content: Text(
//             "do you want to logout",
//             style: TextStyle(color: Colors.white, fontSize: 20),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.canPop(context) ? Navigator.pop(context) : null;
//               },
//               child: Text('no',
//                   style: TextStyle(color: Colors.green, fontSize: 18)),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.canPop(context) ? Navigator.pop(context) : null;
//                 Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                         builder: (_) => SignIn(toggleView: () {})));
//               },
//               child: Text('yes',
//                   style: TextStyle(color: Colors.green, fontSize: 18)),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final FirebaseAuth auth = FirebaseAuth.instance;
//     final controller = Get.put(RoleController());

//     return CurvedNavigationBar(
//       backgroundColor: Color.fromARGB(255, 103, 175, 226),
//       color: Color.fromARGB(255, 12, 98, 246),
//       buttonBackgroundColor: Color.fromARGB(255, 21, 201, 159),
//       height: 60,
//       index: indexNum,
//       items: [
//         Icon(
//           Icons.list,
//           size: 24,
//           color: Colors.black,
//         ),
//         Icon(
//           Icons.search,
//           size: 24,
//           color: Colors.black,
//         ),
//         Icon(
//           Icons.person,
//           size: 24,
//           color: Colors.black,
//         ),
//       ],
//       onTap: (index) {
//         if (index == 2 && Role == 'freelancer') {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (_) => Jobscreen(),
//             ),
//           );
//         } else if (index == 2 && Role == 'Client') {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (_) => UploadJobNow(),
//             ),
//           );
//         } else if (index == 1 && Role == 'freelancer') {
//           Navigator.pushNamed(context, '/ FreelancerProfilePostView');
//         } else {
//           Navigator.pushNamed(context, '/Jobscreen');
//         }
//       },
//     );
//   }
// }

// class FreelancerNavigation extends StatefulWidget {
//   @override
//   _FreelancerNavigationState createState() => _FreelancerNavigationState();
// }

// class _FreelancerNavigationState extends State<FreelancerNavigation> {
//   int _currentIndex = 0;

//   final List<Widget> _children = [
//     Jobscreen(),
//     SearchScreen(),
//     FreelancerProfilePostView(),
//   ];

//   void onTabTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _children[_currentIndex],
//       bottomNavigationBar: BottomNavigatorforApp(indexNum: _currentIndex),
//     );
//   }
// }

// class ClientNavigation extends StatefulWidget {
//   @override
//   _ClientNavigationState createState() => _ClientNavigationState();
// }

// class _ClientNavigationState extends State<ClientNavigation> {
//   int _currentIndex = 0;

//   final List<Widget> _children = [
//     UploadJobNow(),
//     SearchScreen(),
//     ProfileScreen(),
//   ];

//   void onTabTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _children[_currentIndex],
//       bottomNavigationBar: BottomNavigatorforApp(indexNum: _currentIndex),
//     );
//   }
// }
