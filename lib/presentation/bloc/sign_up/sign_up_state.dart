part of 'sign_up_bloc.dart';

/// Base class for all sign-up related states in the authentication flow.
///
/// Represents the various states that the sign-up process can be in.
/// All concrete sign-up states must extend this class.
sealed class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object?> get props => [];
}

/// The initial state of the sign-up process before any actions are taken.
final class SignUpInitial extends SignUpState {}

/// State indicating that a sign-up request is in progress.
final class SignUpLoading extends SignUpState {}

/// State representing a successful user sign-up.
///
/// Contains the authenticated [User] object returned by the authentication service.
final class SignUpSuccess extends SignUpState {
  final User user;

  const SignUpSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

/// State representing a failed sign-up attempt.
final class SignUpFailure extends SignUpState {
  final String? code;
  final String? message;

  const SignUpFailure({this.code, this.message});

  @override
  List<Object?> get props => [code, message];
}