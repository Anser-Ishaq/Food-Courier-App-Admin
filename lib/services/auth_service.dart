import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<User?> signIn(String email, String password) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return credential.user;
  }

  Future<User?> signUp(String email, String password) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return credential.user;
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> changePassword(User user, String oldPassword, String newPassword) async {
    AuthCredential credential = EmailAuthProvider.credential(
      email: user.email!,
      password: oldPassword,
    );
    UserCredential result = await user.reauthenticateWithCredential(credential);
    await result.user!.updatePassword(newPassword);
  }
}
