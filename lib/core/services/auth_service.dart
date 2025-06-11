import 'package:firebase_auth/firebase_auth.dart';

/// A service class that wraps Firebase Authentication functionality.
class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  /// Gets the currently signed-in user.
  ///
  /// Returns:
  /// - [User] if a user is currently signed in
  /// - `null` if no user is signed in
  User? get currentUser => firebaseAuth.currentUser;

  /// A stream of authentication state changes.
  ///
  /// Returns:
  /// - [User] when a user signs in
  /// - `null` when a user signs out
  ///
  /// Uses for reacting to authentication state changes throughout the app.
  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async => await firebaseAuth.signInWithEmailAndPassword(
    email: email,
    password: password,
  );

  Future<UserCredential> createAccountWithEmailAndPassword({
    required String email,
    required String password,
  }) async => await firebaseAuth.createUserWithEmailAndPassword(
    email: email,
    password: password,
  );

  Future<void> resetPassword({required String email}) async =>
      await firebaseAuth.sendPasswordResetEmail(email: email);

  /// Updates user's password after verifying current credentials.
  ///
  /// Steps:
  /// 1. Reauthenticates
  /// 2. Updates to [newPassword] if authentication succeeds
  Future<void> resetPasswordFromCurrentPassword({
    required String email,
    required String currentPassword,
    required String newPassword,
  }) async {
    AuthCredential credential = EmailAuthProvider.credential(
      email: email,
      password: currentPassword,
    );
    await currentUser!.reauthenticateWithCredential(credential);
    await currentUser!.updatePassword(newPassword);
  }

  Future<void> updateUsername({required String username}) async =>
      await currentUser!.updateDisplayName(username);

  Future<void> signOut() async => await firebaseAuth.signOut();

  /// Permanently deletes the current user account after reauthentication.
  ///
  /// Performs:
  /// 1. Reauthentication
  /// 2. Account deletion
  /// 3. Automatic sign out
  Future<void> deleteAccount({
    required String email,
    required String password,
  }) async {
    AuthCredential credential = EmailAuthProvider.credential(
      email: email,
      password: password,
    );
    await currentUser!.reauthenticateWithCredential(credential);
    await currentUser!.delete();
    await firebaseAuth.signOut();
  }
}
