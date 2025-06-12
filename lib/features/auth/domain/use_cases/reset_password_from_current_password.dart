import 'package:equatable/equatable.dart';

import 'package:task_manager/core/use_case.dart';
import '../repositories/auth_repository.dart';

/// Use case for resetting password while authenticated (requires current password).
class ResetPasswordFromCurrentPasswordUseCase
    extends UseCaseWithParams<void, ResetPasswordFromCurrentPasswordParams> {
  final AuthRepository _repository;

  const ResetPasswordFromCurrentPasswordUseCase(this._repository);

  /// Resets password after verifying current credentials.
  @override
  Future<void> call(ResetPasswordFromCurrentPasswordParams params) async =>
      await _repository.resetPasswordFromCurrentPassword(
        email: params.email,
        currentPassword: params.currentPassword,
        newPassword: params.newPassword,
      );
}

/// Container for password change credentials.
class ResetPasswordFromCurrentPasswordParams extends Equatable {
  final String email;
  final String currentPassword;
  final String newPassword;

  const ResetPasswordFromCurrentPasswordParams({
    required this.email,
    required this.currentPassword,
    required this.newPassword,
  });

  @override
  List<Object?> get props => [email, currentPassword, newPassword];
}
