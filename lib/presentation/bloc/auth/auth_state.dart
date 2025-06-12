part of 'auth_bloc.dart';

/// Base class for all authentication states.
///
/// This class is used to represent the various states during the
/// authentication process, such as loading, success, and failure.
sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// Initial state before any authentication action has occurred.
final class AuthInitial extends AuthState {}

/// State indicating that an authentication process is in progress.
final class AuthLoading extends AuthState {}

/// State indicating that authentication was successful.
///
/// Contains the authenticated [user] data.
final class AuthSuccess extends AuthState {
  final User user;

  const AuthSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

/// State indicating that authentication failed.
final class AuthFailure extends AuthState {
  final String? code;
  final String? message;

  const AuthFailure({this.code, this.message});

  @override
  List<Object?> get props => [code, message];
}