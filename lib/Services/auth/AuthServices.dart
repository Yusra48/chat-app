import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static const String usersCollection = 'Users';

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<UserCredential> signInWithEmailPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _updateUserData(userCredential.user!.uid, email);

      return userCredential;
    } catch (e) {
      print('Error signing in: $e');
      throw Exception('Sign in failed. Please check your credentials.');
    }
  }

  Future<UserCredential> signUpWithEmailPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _updateUserData(userCredential.user!.uid, email);

      return userCredential;
    } catch (e) {
      print('Error signing up: $e');
      throw Exception('Sign up failed. Please try again later.');
    }
  }

  Future<void> _updateUserData(String uid, String email) async {
    try {
      await _firestore.collection(usersCollection).doc(uid).set({
        'uid': uid,
        'email': email,
      });
    } catch (e) {
      print('Error updating user data: $e');
      throw Exception('Failed to update user data.');
    }
  }

  Future<void> signOut() async {
    return await _auth.signOut();
  }
}
