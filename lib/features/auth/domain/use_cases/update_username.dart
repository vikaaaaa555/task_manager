import 'package:equatable/equatable.dart';

import '../../../../core/use_case.dart';
import '../repositories/auth_repository.dart';

/// {@template update_username_use_case}
/// Use case for updating user's username.
/// {@endtemplate}
class UpdateUsernameUseCase
    extends UseCaseWithParams<void, UpdateUsernameParams> {
  final AuthRepository _repository;

  /// {@macro update_username_use_case}
  const UpdateUsernameUseCase(this._repository);

  /// Updates the email for the current user.
  @override
  Future<void> call(UpdateUsernameParams params) async =>
      await _repository.updateUsername(username: params.username);
}

/// {@template update_username_params}
/// Parameters required for email update.
/// {@endtemplate}
class UpdateUsernameParams extends Equatable {
  /// New email to set
  final String username;

  /// {@macro update_username_params}
  const UpdateUsernameParams({required this.username});

  @override
  List<Object?> get props => [username];
}
