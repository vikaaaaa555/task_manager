part of 'sign_in_bloc.dart';

/// Base class for all sign-in related events in the authentication flow.
///
/// Events represent user actions or lifecycle events that the [SignInBloc]
/// will process to manage the sign-in state. All concrete sign-in events
/// should extend this class.
sealed class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object?> get props => [];
}

final class RequestForSignInEvent extends SignInEvent {
  final String email;
  final String password;

  const RequestForSignInEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
