import 'package:job_endear/Models/project.dart';

class UserData {
  late String uid;
  late String email;
  late String firstName;
  late String lastName;
  late String? role;
  late Client? client;
  late Freelancer? freelancer;
  late String? freelancerTitle;

  UserData({
    required this.uid,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.role,
    this.client,
    this.freelancer,
    this.freelancerTitle,
  });

  UserData.fromJson(Map<String, dynamic> map) {
    uid = map['uid'].toString();
    email = map['email'].toString();
    firstName = map['firstName'].toString();
    lastName = map['lastName'].toString();
    role = map['role'].toString();
    freelancerTitle = map['freelancerTitle'].toString();
  }
}

class Role {
  late String uid;
  late String email;
  late String firstName;
  late String lastName;
  late String role;
  late String projectId;

  Role({
    required this.uid,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.projectId,
  });

  Role.fromJson(Map<String, dynamic> map) {
    uid = map['uid'].toString();
    email = map['email'].toString();
    firstName = map['firstName'].toString();
    lastName = map['lastName'].toString();
    role = map['role'].toString();
    projectId = map['projectId'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
  final List<Project> projectId;

  Client({
    required this.uid,
    required this.companyName,
    required this.companyAddress,
    required this.projectId,
  });
}

class Freelancer {
  late String freelancerId;
  late String category;
  late String skills;
  late String experience;
  late String? freelancerTitle;

  late DateTime createdAt;

  Freelancer({
    required this.freelancerId,
    required this.category,
    required this.skills,
    required this.experience,
    this.freelancerTitle,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'freelancerId': freelancerId,
      'category': category,
      'skills': skills,
      'experience': experience,
      'freelancerTitle': freelancerTitle,
      'createdAt': createdAt,
    };
  }

  static Freelancer fromMap(Map<String, dynamic> map) {
    return Freelancer(
      freelancerId: map['freelancerId'],
      category: map['category'],
      skills: map['skills'],
      experience: map['experience'],
      freelancerTitle: map['freelancerTitle'],
      createdAt: map['createdAt'].toDate(),
    );
  }

  Freelancer.fromJson(Map<String, dynamic> map) {
    freelancerId = map['freelancerId'].toString();
    category = map['category'].toString();
    freelancerTitle = map['freelancerTitle'].toString();
    skills = map['skills'].toString();
    experience = map['experience'].toString();
    createdAt = map['createdAt'].toDate();
  }
}
