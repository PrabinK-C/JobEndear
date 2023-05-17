import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_endear/Screens/Home/Widget/bottom_nav_bar.dart';
import 'package:job_endear/Services/f_profile.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../Models/UserData.dart';

class FreelancerProfileView extends StatefulWidget {
  const FreelancerProfileView({super.key});

  @override
  _FreelancerProfileViewState createState() => _FreelancerProfileViewState();
}

class _FreelancerProfileViewState extends State<FreelancerProfileView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Freelancer? _freelancerProfile;
  final _controller = FreelancerProfileController();

  @override
  void initState() {
    super.initState();
    _loadFreelancerProfile();
  }

  Future<void> _loadFreelancerProfile() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    final freelancerProfile = await _controller.getFreelancerProfile(uid);
    setState(() {
      _freelancerProfile = freelancerProfile;
    });
  }

  //contct for different profile of a person
  Widget _contactBy(
      {required Color color, required Function fct, required IconData icon}) {
    return CircleAvatar(
      backgroundColor: color,
      radius: 25,
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 23,
        child: IconButton(
          icon: Icon(
            icon,
            color: color,
          ),
          onPressed: () {
            fct();
          },
        ),
      ),
    );
  }

  void _mailTo() async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: "",
      query:
          'subject=Write subject here, Please&body= Hello, please write details here',
    );
    final url = params.toString();
    launchUrlString(url);
  }

  void _callPhoneNumber() async {
    var url = 'tel://';
    launchUrlString(url);
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final email = user?.email ?? '';
    //    void _editProfile() {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (_) => ProfileEditScreen(),
    //     ),
    //   );
    // }

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(189, 191, 176, 221),
            Color.fromARGB(207, 68, 137, 255)
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [0.3, 0.8],
        ),
      ),
      child: Scaffold(
        bottomNavigationBar: BottomNavigatorforApp(indexNum: 3),
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Stack(
                children: [
                  const ColoredBox(color: Colors.black12),
                  Card(
                      color: const Color.fromARGB(148, 108, 55, 244),
                      margin: const EdgeInsets.all(30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'Account Information:',
                                style: TextStyle(
                                  fontSize: 24.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              ' $email',
                              style: const TextStyle(
                                fontSize: 24.0,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            const Divider(
                              thickness: 1,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            _freelancerProfile != null
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Category: ${_freelancerProfile!.category}',
                                        style: const TextStyle(
                                          fontSize: 24.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Skills: ${_freelancerProfile!.skills}',
                                        style: const TextStyle(
                                          fontSize: 24.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Experience: ${_freelancerProfile!.experience} Years',
                                        style: const TextStyle(
                                          fontSize: 24.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      const Divider(
                                        thickness: 1,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(
                                        height: 15.0,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          _contactBy(
                                              color: Colors.redAccent,
                                              fct: () {
                                                _mailTo();
                                              },
                                              icon: Icons.mail_outline),
                                          _contactBy(
                                              color: Colors.purpleAccent,
                                              fct: () {
                                                _callPhoneNumber();
                                              },
                                              icon: Icons.call),
                                        ],
                                      ),
                                    ],
                                  )
                                : const Center(
                                    child:
                                        CircularProgressIndicator(), // Show a loading indicator
                                  ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
