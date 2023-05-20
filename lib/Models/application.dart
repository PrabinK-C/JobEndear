import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectApplication {
  late String userId;
  // late DateTime appliedAt;
  late String? status;
  // late DateTime? hiredAt;
  late String? hiredBy;
  late String? projectId;

  ProjectApplication({
    required this.userId,
    // required this.appliedAt,
    this.status,
    // this.hiredAt,
    this.hiredBy,
    this.projectId,
  });

  ProjectApplication.fromJson(Map<String, dynamic> map) {
    userId = map['userId'].toString();
    // appliedAt = map['appliedAt'].toDate();
    status = map['status'].toString();
    // hiredAt = map['hiredAt'].toDate();
    hiredBy = map['hiredBy'].toString();
    projectId = map['projectId'].toString();
  }

  static fromSnapshot(QueryDocumentSnapshot<Object?> doc) {}
}
