import 'package:flutter/material.dart';

import 'package:job_endear/Screens/ProjectPost/project_form.dart';
import 'package:job_endear/Services/auth.dart';
import 'package:job_endear/Services/project_list.dart';

class ClientHome extends StatelessWidget {
  final Projectpost _projectController = Projectpost();
  final AuthService _auth = AuthService();

  ClientHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Endear - Client'),
        actions: <Widget>[
          ElevatedButton.icon(
            onPressed: () async {
              await _auth.signOut();
              Navigator.of(context).pushReplacementNamed('/authenticate');
            },
            icon: const Icon(Icons.person),
            label: const Text('Logout'),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Post Project', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Create Project'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProjectFormView()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
