import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Sign In with Email and Password
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      final UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      // Handle errors
      Get.snackbar('Error', 'Error during sign-in: $e');
      return null;
    }
  }

  // Sign Out
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      Get.snackbar('Error', 'Error during sign-out: $e');
    }
  }

  // Check if User is Signed In
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }
}
