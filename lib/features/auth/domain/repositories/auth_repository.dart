import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  /// The currently signed-in [User], or null if there is none.
  ///
  /// This is a direct pass-through to the underlying data source.
  User? get currentUser;

  /// A stream of authentication state changes (user sign-in/sign-out).
  ///
  /// This stream emits:
  /// - The current user when they sign in
  /// - Null when they sign out
  Stream<User?> get authStateChanges;

  /// Signs in a user with the given [email] and [password].
  ///
  /// Returns a [UserCredential] containing the authenticated user.
  ///
  /// Throws:
  /// - [FirebaseAuthException] if authentication fails
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Creates a new user account with the given [email] and [password].
  ///
  /// Returns a [UserCredential] containing the newly created user.
  ///
  /// Throws:
  /// - [FirebaseAuthException] if the operation fails
  Future<UserCredential> createAccountWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Sends a password reset email to the specified [email] address.
  ///
  /// No exceptions are thrown if the email doesn't exist in the system.
  Future<void> resetPassword({required String email});

  /// Changes the user's password from [currentPassword] to [newPassword].
  ///
  /// Throws:
  /// - [FirebaseAuthException] if current password is incorrect
  Future<void> resetPasswordFromCurrentPassword({
    required String email,
    required String currentPassword,
    required String newPassword,
  });

  /// Updates the display name of the current user to [username].
  ///
  /// Throws:
  /// - [FirebaseAuthException] if no user is signed in
  Future<void> updateUsername({required String username});

  /// Signs out the current user.
  ///
  /// Does not throw exceptions if no user is signed in.
  Future<void> signOut();

  /// Permanently deletes the current user's account.
  ///
  /// Throws:
  /// - [FirebaseAuthException] if authentication fails or operation is denied
  Future<void> deleteAccount({required String email, required String password});
}
