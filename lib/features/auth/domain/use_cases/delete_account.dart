import 'package:equatable/equatable.dart';

import '../../../../core/use_case.dart';
import '../repositories/auth_repository.dart';

/// {@template delete_account_use_case}
/// Use case for permanent account deletion.
/// {@endtemplate}
class DeleteAccountUseCase extends UseCaseWithParams<void, DeleteAccountParams> {
  final AuthRepository _repository;

  /// {@macro delete_account_use_case}
  const DeleteAccountUseCase(this._repository);

  /// Permanently deletes user account after credential verification.
  @override
  Future<void> call(DeleteAccountParams params) async =>
      await _repository.deleteAccount(
        email: params.email,
        password: params.password,
      );
}

/// {@template delete_account_params}
/// Credentials required for account deletion.
/// {@endtemplate}
class DeleteAccountParams extends Equatable {
  final String email;
  final String password;

  /// {@macro delete_account_params}
  const DeleteAccountParams({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}