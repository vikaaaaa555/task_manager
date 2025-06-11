import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/use_case.dart';
import '../repositories/auth_repository.dart';

/// Creates a new user account with email and password authentication.
///
/// Delegates the account creation to the underlying [AuthRepository],
/// handling the business logic of user registration.
class CreateAccountWithEmailAndPasswordUseCase
    extends
        UseCaseWithParams<
          UserCredential,
          CreateAccountWithEmailAndPasswordParams
        > {
  final AuthRepository _repository;

  const CreateAccountWithEmailAndPasswordUseCase(this._repository);

  @override
  Future<UserCredential> call(
    CreateAccountWithEmailAndPasswordParams params,
  ) async => await _repository.createAccountWithEmailAndPassword(
    email: params.email,
    password: params.password,
  );
}

/// Parameters required for email/password creation an account.
class CreateAccountWithEmailAndPasswordParams extends Equatable {
  final String email;
  final String password;

  /// Creates parameters for account creation.
  const CreateAccountWithEmailAndPasswordParams({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}
