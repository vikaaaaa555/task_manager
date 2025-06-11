import '../../../../core/use_case.dart';
import '../repositories/auth_repository.dart';

/// {@template sign_out_use_case}
/// Use case for signing out the current user.
/// {@endtemplate}
class SignOutUseCase extends UseCaseWithoutParams<void> {
  final AuthRepository _repository;

  /// {@macro sign_out_use_case}
  const SignOutUseCase(this._repository);

  /// Performs user sign out operation.
  @override
  Future<void> call() async => await _repository.signOut();
}
