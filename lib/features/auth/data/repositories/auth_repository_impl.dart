import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_remote_data_source.dart';

/// Implementation of [AuthRepository] that communicates with a remote data source
/// for authentication-related operations.
///
/// This class acts as an intermediary between the domain layer and the data layer,
/// delegating all authentication operations to the provided [AuthRemoteDataSource].
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _dataSource;

  const AuthRepositoryImpl(this._dataSource);

  @override
  User? get currentUser => _dataSource.currentUser;

  @override
  Stream<User?> get authStateChanges => _dataSource.authStateChanges;

  @override
  Future<UserCredential> createAccountWithEmailAndPassword({
    required String email,
    required String password,
  }) async => await _dataSource.createAccountWithEmailAndPassword(
    email: email,
    password: password,
  );

  @override
  Future<void> deleteAccount({
    required String email,
    required String password,
  }) async => await _dataSource.deleteAccount(email: email, password: password);

  @override
  Future<void> resetPassword({required String email}) async =>
      await _dataSource.resetPassword(email: email);

  @override
  Future<void> resetPasswordFromCurrentPassword({
    required String email,
    required String currentPassword,
    required String newPassword,
  }) async => await _dataSource.resetPasswordFromCurrentPassword(
    email: email,
    currentPassword: currentPassword,
    newPassword: newPassword,
  );

  @override
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async => await _dataSource.signInWithEmailAndPassword(
    email: email,
    password: password,
  );

  @override
  Future<void> signOut() async => await _dataSource.signOut();

  @override
  Future<void> updateUsername({required String username}) async =>
      await _dataSource.updateUsername(username: username);
}
