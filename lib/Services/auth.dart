import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:job_endear/Models/user.dart';
import 'package:job_endear/Services/database.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  bool loading = false;

  //create user obj based on FirebaseUser
  User? _userFromFirebaseUser(auth.User? user) {
    if (user != null) {
      return User(uid: user.uid);
    }
    return null;
  }

  //auth change user stream
  Stream<User?> get user {
    loading = true;
    notifyListeners();
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // sign in with email & password
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      debugPrint("1st line");
      auth.UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      auth.User? user = result.user;
      loading = true;
      notifyListeners();
      return user != null ? _userFromFirebaseUser(user) : null;
    } catch (error) {
      debugPrint(error.toString());
      return null;
    }
  }

  // Register with Client
  Future<User?> registerClient(
      String email,
      String password,
      String firstName,
      String lastName,
      String? role,
      String? companyName,
      String? companyAddress) async {
    try {
      auth.UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      auth.User? user = result.user;
      String? uid = user?.uid;
      loading = true;
      notifyListeners();

      // Create a new document for the user with the uid
      final DatabaseService databaseService = DatabaseService();
      databaseService.addClientData(
        email: email,
        firstName: firstName,
        lastName: lastName,
        role: "Client",
        companyName: companyName,
        companyAddress: companyAddress,
        uid: uid,
      );
      debugPrint('Client');
      return _userFromFirebaseUser(user);
    } catch (error) {
      debugPrint(error.toString());
      return null;
    }
  }

//Register With Freelancer
  Future<User?> registerFreelancer(
      String email,
      String password,
      String firstName,
      String lastName,
      String? role,
      String? freelancerTitle,
      String? freelancerDescription) async {
    try {
      auth.UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      auth.User? user = result.user;
      String? uid = user?.uid;
      loading = true;
      notifyListeners();

      // Create a new document for the user with the uid
      final DatabaseService databaseService = DatabaseService();
      databaseService.addFreelancerData(
        email: email,
        firstName: firstName,
        lastName: lastName,
        role: "Freelancer",
        freelancerTitle: freelancerTitle,
        freelancerDescription: freelancerDescription,
        uid: uid,
      );
      debugPrint('Freelancer');
      return _userFromFirebaseUser(user);
    } catch (error) {
      debugPrint(error.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
