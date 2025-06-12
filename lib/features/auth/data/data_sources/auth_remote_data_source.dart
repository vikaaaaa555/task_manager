import 'package:firebase_auth/firebase_auth.dart';

/// Abstract class defining the contract for authentication operations with a remote data source.
///
/// This interface describes all authentication-related operations that can be performed
/// with a remote authentication service (e.g., Firebase Authentication).
abstract class AuthRemoteDataSource {
  /// The currently signed-in [User], or null if there is no authenticated user.
  User? get currentUser;

  /// A stream that emits authentication state changes (user sign-in/sign-out).
  ///
  /// This stream emits:
  /// - A [User] object when a user signs in
  /// - Null when the current user signs out
  Stream<User?> get authStateChanges;

  /// Signs in a user with the given email and password.
  ///
  /// Returns a [UserCredential] containing the authenticated user.
  ///
  /// Throws:
  /// - [FirebaseAuthException] if sign-in fails
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Creates a new user account with the given email and password.
  ///
  /// Returns a [UserCredential] containing the newly created user.
  ///
  /// Throws:
  /// - [FirebaseAuthException] if account creation fails
  Future<UserCredential> createAccountWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Sends a password reset email to the specified email address.
  ///
  /// Note: This method doesn't throw if the email doesn't exist in the system.
  Future<void> resetPassword({required String email});

  /// Changes the user's password after reauthentication with the current password.
  ///
  /// Throws:
  /// - [FirebaseAuthException] if reauthentication fails or password update fails
  Future<void> resetPasswordFromCurrentPassword({
    required String email,
    required String currentPassword,
    required String newPassword,
  });

  /// Updates the display name of the currently authenticated user.
  ///
  /// Throws:
  /// - [FirebaseAuthException] if no user is signed in or update fails
  Future<void> updateUsername({required String username});

  /// Signs out the currently authenticated user.
  Future<void> signOut();

  /// Permanently deletes the currently authenticated user's account.
  ///
  /// Requires reauthentication with the user's email and current password.
  ///
  /// Throws:
  /// - [FirebaseAuthException] if reauthentication fails or deletion fails
  /// - [StateError] if no user is currently signed in
  Future<void> deleteAccount({required String email, required String password});
}

/// Concrete implementation of [AuthRemoteDataSource] using Firebase Authentication.
///
/// This class provides the actual implementation of all authentication operations
/// using Firebase Authentication as the backend service.
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  @override
  Future<UserCredential> createAccountWithEmailAndPassword({
    required String email,
    required String password,
  }) async => await _firebaseAuth.createUserWithEmailAndPassword(
    email: email,
    password: password,
  );

  @override
  Future<void> deleteAccount({
    required String email,
    required String password,
  }) async {
    final credential = EmailAuthProvider.credential(
      email: email,
      password: password,
    );
    await currentUser!.reauthenticateWithCredential(credential);
    await currentUser!.delete();
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> resetPassword({required String email}) async =>
      await _firebaseAuth.sendPasswordResetEmail(email: email);

  @override
  Future<void> resetPasswordFromCurrentPassword({
    required String email,
    required String currentPassword,
    required String newPassword,
  }) async {
    final credential = EmailAuthProvider.credential(
      email: email,
      password: currentPassword,
    );
    await currentUser!.reauthenticateWithCredential(credential);
    await currentUser!.updatePassword(newPassword);
  }

  @override
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async => await _firebaseAuth.signInWithEmailAndPassword(
    email: email,
    password: password,
  );

  @override
  Future<void> signOut() async => await _firebaseAuth.signOut();

  @override
  Future<void> updateUsername({required String username}) async =>
      await currentUser!.updateDisplayName(username);
}
