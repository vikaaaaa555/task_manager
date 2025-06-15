import 'package:equatable/equatable.dart';

import '../../../../core/use_case.dart';
import '../repositories/auth_repository.dart';

/// Use case for permanent account deletion.
class DeleteAccountUseCase extends UseCaseWithParams<void, DeleteAccountParams> {
  final AuthRepository _repository;

  const DeleteAccountUseCase(this._repository);

  /// Permanently deletes user account after credential verification.
  @override
  Future<void> call(DeleteAccountParams params) async =>
      await _repository.deleteAccount(
        email: params.email,
        password: params.password,
      );
}

/// Credentials required for account deletion.
class DeleteAccountParams extends Equatable {
  final String email;
  final String password;

  const DeleteAccountParams({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}