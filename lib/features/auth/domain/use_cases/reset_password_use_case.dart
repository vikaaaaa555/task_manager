import 'package:equatable/equatable.dart';

import '../../../../core/use_case.dart';
import '../repositories/auth_repository.dart';

/// Use case for initiating a password reset for the given email.
class ResetPasswordUseCase
    extends UseCaseWithParams<void, ResetPasswordParams> {
  final AuthRepository _repository;

  const ResetPasswordUseCase(this._repository);

  /// Initiates password reset flow for the email in [params].
  @override
  Future<void> call(ResetPasswordParams params) async =>
      await _repository.resetPassword(email: params.email);
}

/// Parameters required for password reset.
class ResetPasswordParams extends Equatable {
  /// Email address for password reset
  final String email;

  const ResetPasswordParams({required this.email});

  @override
  List<Object?> get props => [email];
}
