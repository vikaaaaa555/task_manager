import 'package:equatable/equatable.dart';

import '../../../../core/use_case.dart';
import '../repositories/auth_repository.dart';

/// {@template reset_password_use_case}
/// Use case for initiating a password reset for the given email.
/// {@endtemplate}
class ResetPasswordUseCase
    extends UseCaseWithParams<void, ResetPasswordParams> {
  final AuthRepository _repository;

  /// {@macro reset_password_use_case}
  const ResetPasswordUseCase(this._repository);

  /// Initiates password reset flow for the email in [params].
  @override
  Future<void> call(ResetPasswordParams params) async =>
      await _repository.resetPassword(email: params.email);
}

/// {@template reset_password_params}
/// Parameters required for password reset.
/// {@endtemplate}
class ResetPasswordParams extends Equatable {
  /// Email address for password reset
  final String email;

  /// {@macro reset_password_params}
  const ResetPasswordParams({required this.email});

  @override
  List<Object?> get props => [email];
}
