part of 'auth_bloc.dart';

/// Base class for all authentication-related events.
///
/// Used to trigger authentication logic such as sign up, log in & reset password.
sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

final class SignUpEvent extends AuthEvent {
  final String email;
  final String password;

  const SignUpEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

final class LogInEvent extends AuthEvent {
  final String email;
  final String password;

  const LogInEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

final class ResetPasswordEvent extends AuthEvent {
  final String email;

  const ResetPasswordEvent({required this.email});

  @override
  List<Object?> get props => [email];
}
