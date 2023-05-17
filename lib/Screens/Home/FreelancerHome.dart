// import 'package:flutter/material.dart';
// import 'package:job_endear/Models/job.dart';
// import 'package:provider/provider.dart';
// import 'package:job_endear/Services/project_list.dart';

// class FreelancerHome extends StatefulWidget {
//   @override
//   _FreelancerHomeState createState() => _FreelancerHomeState();
// }

// class _FreelancerHomeState extends State<FreelancerHome> {
//   @override
//   void initState() {
//     super.initState();
//     Provider.of<ProjectList>(context, listen: false).fetchProject();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Freelancer Home'),
//       ),
//       body: Consumer<ProjectList>(
//         builder: (context, projectList, child) {
//           if (projectList.projects.isEmpty) {
//             return Center(
//               child: Text('No projects found'),
//             );
//           } else {
//             return ListView.builder(
//               itemCount: projectList.projects.length,
//               itemBuilder: (BuildContext context, int index) {
//                 final project = projectList.projects[index];
//                 return ListTile(
//                   title: Text(project.title),
//                   subtitle: Text(project.description),
//                   trailing: Text('${project.budget} \$'),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
