import 'package:flutter/material.dart';


import '../ProjectPost/project_form.dart';
// appBar: AppBar(
//   centerTitle: true,
//   flexibleSpace: Container(
//     decoration: BoxDecoration(
//       gradient: LinearGradient(
//         colors: [Colors.deepOrange.shade300, Colors.blueAccent],
//         begin: Alignment.centerLeft,
//         end: Alignment.centerRight,
//         stops: const [0.3, 0.8],
//       ),
//     ),
//   ),
// ),

class UploadJobNow extends StatelessWidget {
  const UploadJobNow({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6600FF), Color(0xFF8C309C)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: [0.3, 0.8],
          ),
        ),
        child: const SafeArea(
          child: ProjectFormView(),
        ),
      ),
    );
  }
}
