part of 'log_in_bloc.dart';

/// Base class for all log-in related states in the authentication flow.
///
/// Represents the various states that the log-in process can be in.
/// All concrete log-in states must extend this class.
sealed class LogInState extends Equatable {
  const LogInState();

  @override
  List<Object?> get props => [];
}

final class LogInInitial extends LogInState {}

final class LogInLoading extends LogInState {}

final class LogInSuccess extends LogInState {
  final User user;

  const LogInSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

final class LogInFailure extends LogInState {
  final String? code;
  final String? message;

  const LogInFailure({this.code, this.message});

  @override
  List<Object?> get props => [code, message];
}
