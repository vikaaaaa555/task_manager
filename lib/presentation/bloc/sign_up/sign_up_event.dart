part of 'sign_up_bloc.dart';

/// Base class for all sign-up related events in the authentication flow.
///
/// Events represent user actions or lifecycle events that the [SignUpBloc]
/// will process to manage the sign-up state. All concrete sign-up events
/// should extend this class.
sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object?> get props => [];
}

/// Event representing a user request to create a new account.
///
/// The [SignUpBloc] will process this event by attempting to create
/// a new user account with the provided credentials.
final class RequestForSignUpEvent extends SignUpEvent {
  final String email;
  final String password;

  const RequestForSignUpEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
