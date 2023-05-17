class ProjectApplication {
  final String uid;
  final DateTime appliedAt;
  final String? status;
  final DateTime? hiredAt;
  final String? hiredBy;

  ProjectApplication({
    required this.uid,
    required this.appliedAt,
    this.status,
    this.hiredAt,
    this.hiredBy,
  });

  get projectId => null;

  static fromJson(Map<String, dynamic> data) {}
}
