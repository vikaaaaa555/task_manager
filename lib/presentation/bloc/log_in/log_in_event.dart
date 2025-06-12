part of 'log_in_bloc.dart';

/// Base class for all log-in related events in the authentication flow.
///
/// Events represent user actions or lifecycle events that the [LogInBloc]
/// will process to manage the log-in state. All concrete log-in events
/// should extend this class.
sealed class LogInEvent extends Equatable {
  const LogInEvent();

  @override
  List<Object?> get props => [];
}

final class RequestForLogInEvent extends LogInEvent {
  final String email;
  final String password;

  const RequestForLogInEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
