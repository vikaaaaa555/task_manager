import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/use_case.dart';
import '../repositories/auth_repository.dart';

/// Use case for authenticating a user with email and password.
///
/// This use case handles the business logic of signing in a user.
class SignInWithEmailAndPasswordUseCase
    extends
        UseCaseWithParams<UserCredential, SignInWithEmailAndPasswordParams> {
  final AuthRepository _repository;

  const SignInWithEmailAndPasswordUseCase(this._repository);

  /// Executes the use case by delegating to the authentication repository.
  ///
  /// [params] must be of type [SignInWithEmailAndPasswordParams] and contain
  /// the user's credentials.
  @override
  Future<UserCredential> call(SignInWithEmailAndPasswordParams params) async =>
      await _repository.signInWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );
}

/// Parameters required for email/password authentication.
class SignInWithEmailAndPasswordParams extends Equatable {
  final String email;
  final String password;

  const SignInWithEmailAndPasswordParams({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}
