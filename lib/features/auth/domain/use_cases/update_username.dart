import 'package:equatable/equatable.dart';

import '../../../../core/use_case.dart';
import '../repositories/auth_repository.dart';

/// Use case for updating user's username.
class UpdateUsernameUseCase
    extends UseCaseWithParams<void, UpdateUsernameParams> {
  final AuthRepository _repository;

  const UpdateUsernameUseCase(this._repository);

  /// Updates the email for the current user.
  @override
  Future<void> call(UpdateUsernameParams params) async =>
      await _repository.updateUsername(username: params.username);
}

/// Parameters required for email update.
class UpdateUsernameParams extends Equatable {
  /// New email to set
  final String username;

  const UpdateUsernameParams({required this.username});

  @override
  List<Object?> get props => [username];
}
