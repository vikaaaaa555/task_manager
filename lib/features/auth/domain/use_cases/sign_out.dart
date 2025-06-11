import '../../../../core/use_case.dart';
import '../repositories/auth_repository.dart';

/// Use case for signing out the current user.
class SignOutUseCase extends UseCaseWithoutParams<void> {
  final AuthRepository _repository;

  const SignOutUseCase(this._repository);

  /// Performs user sign out operation.
  @override
  Future<void> call() async => await _repository.signOut();
}
