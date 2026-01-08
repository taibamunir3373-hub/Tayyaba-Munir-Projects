import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign In Logic
  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } catch (e) {
      // In a real app, you would handle specific errors here
      return null;
    }
  }

  // Sign Out Logic
  Future<void> signOut() async => await _auth.signOut();
}