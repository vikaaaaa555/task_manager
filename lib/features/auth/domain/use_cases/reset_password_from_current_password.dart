import 'package:equatable/equatable.dart';

import 'package:task_manager/core/use_case.dart';
import '../repositories/auth_repository.dart';

/// {@template reset_password_from_current_password}
/// Use case for resetting password while authenticated (requires current password).
/// {@endtemplate}
class ResetPasswordFromCurrentPasswordUseCase
    extends UseCaseWithParams<void, ResetPasswordFromCurrentPasswordParams> {
  final AuthRepository _repository;

  /// {@macro reset_password_from_current_password}
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

/// {@template reset_password_from_current_params}
/// Container for password change credentials.
/// {@endtemplate}
class ResetPasswordFromCurrentPasswordParams extends Equatable {
  final String email;
  final String currentPassword;
  final String newPassword;

  /// {@macro reset_password_from_current_params}
  const ResetPasswordFromCurrentPasswordParams({
    required this.email,
    required this.currentPassword,
    required this.newPassword,
  });

  @override
  List<Object?> get props => [email, currentPassword, newPassword];
}
