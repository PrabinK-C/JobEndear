
// ignore: file_names
import 'package:job_endear/Models/project.dart';

class UserData {
  final String uid;
  final String email;
  final String firstName;
  final String lastName;
  final String? role;
  final Client? client;
  final Freelancer? freelancer;
  

  UserData({
    required this.uid,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.role,
    this.client,
    this.freelancer,
    

  });
  
  
}
class Role {
  late String uid;
  late String email;
  late String firstName;
  late String lastName;
  late String role;

  Role({
    required this.uid,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.role,
  });

  Role.fromJson(Map<String, dynamic> map) {
    uid = map['uid'].toString();
    email = map['email'].toString();
    firstName = map['firstName'].toString();
    lastName = map['lastName'].toString();
    role = map['role'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = this.uid;
    data['email'] = this.email;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['role'] = this.role;
    return data;
  }
}


class Client {
  final String uid;
  final String companyName;
  final String companyAddress;
  final List  <Project> projectId;

  Client({
    required this.uid,
    required this.companyName,
    required this.companyAddress,
    required this.projectId,
  });
}

class Freelancer {
  final String freelancerId;
  final String category;
  final String skills;
  final String experience;
  final DateTime createdAt;

  Freelancer({
    required this.freelancerId,
    required this.category,
    required this.skills,
    required this.experience,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'freelancerId': freelancerId,
      'category': category,
      'skills': skills,
      'experience': experience,
      'createdAt': createdAt,
    };
  }
 static Freelancer fromMap(Map<String, dynamic> map) {
    return Freelancer(
      freelancerId: map['freelancerId'],
      category: map['category'],
      skills: map['skills'],
      experience: map['experience'],
      createdAt: map['createdAt'].toDate(),
    );
  }

  static fromJson(Map<String, dynamic> data) {}
}