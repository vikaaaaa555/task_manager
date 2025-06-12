part of 'sign_in_bloc.dart';

/// Base class for all sign-in related states in the authentication flow.
///
/// Represents the various states that the sign-in process can be in.
/// All concrete sign-in states must extend this class.
sealed class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object?> get props => [];
}

final class SignInInitial extends SignInState {}

final class SignInLoading extends SignInState {}

final class SignInSuccess extends SignInState {
  final User user;

  const SignInSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

final class SignInFailure extends SignInState {
  final String? code;
  final String? message;

  const SignInFailure({this.code, this.message});

  @override
  List<Object?> get props => [code, message];
}
