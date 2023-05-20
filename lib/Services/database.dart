import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

final FirebaseFirestore _db = FirebaseFirestore.instance;

class DatabaseService {
  // collection references
  CollectionReference _usersCollection = _db.collection('users');

  final FirebaseAuth auth = FirebaseAuth.instance;

  final String uid = FirebaseAuth.instance.currentUser!.uid;

  void addClientData({
    required String email,
    required String firstName,
    required String lastName,
    String? uid,
    String? role,
    String? companyName,
    String? companyAddress,
    String? projectId,
  }) {
    try {
      CollectionReference _usersCollection = _db.collection('users');
      debugPrint(_usersCollection.toString());
      _usersCollection.add({
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'role': role,
        'companyName': companyName,
        'companyAddress': companyAddress,
        'projectIds': projectId,
        'count': 0,
      }).then((DocumentReference ref) => ref.update({'userId': uid}));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void addFreelancerData({
    required String email,
    required String firstName,
    required String lastName,
    String? uid,
    String? role,
    String? freelancerTitle,
    String? freelancerDescription,
    String? projectId,
  }) {
    try {
      CollectionReference _usersCollection = _db.collection('users');
      debugPrint(_usersCollection.toString());
      _usersCollection.add({
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'role': role,
        'freelancerTitle': freelancerTitle,
        'freelancerDescription': freelancerDescription,
        'projectIds': projectId,
        'count': 0,
      }).then((DocumentReference ref) => ref.update({'userId': uid}));
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
