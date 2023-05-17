import 'package:cloud_firestore/cloud_firestore.dart';

class Project {
  late String projectId;
  late String title;
  late String description;
  // late String projectField;
  late String category;
  late String location;
  late double budget;
  // late DateTime deadline;
  late String clientId;
  // late String status;
  late String requirements;
  late String skills;
  late String experience;
  late DateTime createdAt;

  Project({
    required this.projectId,
    required this.title,
    required this.description,
    // required this.projectField,
    required this.category,
    required this.location,
    required this.budget,
    // required this.deadline,
    required this.clientId,
    // required this.status,
    required this.requirements,
    required this.skills,
    required this.experience,
    required this.createdAt,
  });

  factory Project.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Project(
      projectId: data['projectId'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      // projectField: data['projectField'] ?? '',
      category: data['category'] ?? '',
      location: data['location'] ?? '',
      budget: (data['budget'] ?? 0).toDouble(),
      clientId: data['clientId'] ?? '',
      requirements: data['requirements'] ?? '',
      skills: data['skills'] ?? '',
      experience: data['experience'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'pid': 'pid',
      'title': title,
      'description': description,
      // 'projectField': projectField,
      'category': category,
      'location': location,
      'budget': budget,
      'requirements': requirements,
      'skills': skills,
      'experience': experience,
      'createdAt': createdAt,
    };
  }

  static fromJson(Map<String, dynamic> data) {}
}
