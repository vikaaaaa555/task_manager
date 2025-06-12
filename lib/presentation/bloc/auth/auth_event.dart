part of 'auth_bloc.dart';

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
