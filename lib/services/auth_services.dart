import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final FirebaseAuth firebaseAuth;
  AuthServices({required this.firebaseAuth});

  Stream<User?> get authState => firebaseAuth.authStateChanges();
  User? get currentLoggedInUser => firebaseAuth.currentUser;

  Future<String> login(
      {required String email, required String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Logged in";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  /// ***Signup (New user)*** ->  email and password
  ///
  /// Parameters:
  /// - email         --> The email ID associated with the user
  /// - password      --> The password associated with the user
  /// - display name  --> How the username is know throughout the app
  Future<String> signup(
      {required String email, required String password}) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "Signed up";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  // Reset password
  Future<String> resetPassword({required String email}) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return "Password reset link sent to : $email. Please check the spam folder too.";
    } on FirebaseException catch (e) {
      return "Error caused due to : ${e.code}";
    }
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}
