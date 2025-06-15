import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../features/auth/domain/use_cases/create_account_with_email_and_password_use_case.dart';
import '../../../features/auth/domain/use_cases/reset_password_use_case.dart';
import '../../../features/auth/domain/use_cases/sign_in_with_email_and_password_use_case.dart';

part 'auth_event.dart';

part 'auth_state.dart';

/// Bloc responsible for handling authentication events and states.
///
/// Supports signing up and logging in using email and password. Uses
/// [CreateAccountWithEmailAndPasswordUseCase] and [SignInWithEmailAndPasswordUseCase]
/// to perform authentication via Firebase.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final CreateAccountWithEmailAndPasswordUseCase
  createAccountWithEmailAndPasswordUseCase;
  final SignInWithEmailAndPasswordUseCase signInWithEmailAndPasswordUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;
  final Stream<User?> authStateChanges;

  late final StreamSubscription<User?> _authStateSubscription;

  /// Creates an instance of [AuthBloc] with required use cases.
  AuthBloc({
    required this.createAccountWithEmailAndPasswordUseCase,
    required this.signInWithEmailAndPasswordUseCase,
    required this.resetPasswordUseCase,
    required this.authStateChanges,
  }) : super(AuthInitial()) {
    on<SignUpEvent>(_handleSignUpEvent);
    on<LogInEvent>(_handleLogInEvent);
    on<ResetPasswordEvent>(_handleResetPasswordEvent);
    on<_AuthStatusChangedEvent>(_handleAuthStatusChangedEvent);
    on<AuthResetEvent>(_handleAuthResetEvent);

    _authStateSubscription = authStateChanges.listen(
      (user) =>
          user != null
              ? add(_AuthStatusChangedEvent(user))
              : add(_AuthStatusChangedEvent(null)),
    );
  }

  /// Handles [SignUpEvent] by creating an account and emitting [AuthSuccess] or [AuthFailure].
  Future<void> _handleSignUpEvent(
    SignUpEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await createAccountWithEmailAndPasswordUseCase(
        CreateAccountWithEmailAndPasswordParams(
          email: event.email,
          password: event.password,
        ),
      );
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(code: e.code, message: e.message));
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  /// Handles [LogInEvent] by signing in.
  Future<void> _handleLogInEvent(
    LogInEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await signInWithEmailAndPasswordUseCase(
        SignInWithEmailAndPasswordParams(
          email: event.email,
          password: event.password,
        ),
      );
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(code: e.code, message: e.message));
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  /// Handles [ResetPasswordEvent] by reset password.
  Future<void> _handleResetPasswordEvent(
    ResetPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await resetPasswordUseCase(ResetPasswordParams(email: event.email));
      emit(AuthInitial());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(code: e.code, message: e.message));
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  /// Handles changes in the authentication state by listening to the
  /// [FirebaseAuth.authStateChanges] stream.
  ///
  /// If a [User] is provided, it emits [AuthSuccess] with the current user.
  /// Otherwise, it emits [AuthInitial], indicating no authenticated user.
  void _handleAuthStatusChangedEvent(
    _AuthStatusChangedEvent event,
    Emitter<AuthState> emit,
  ) =>
      event.user != null ? emit(AuthSuccess(event.user!)) : emit(AuthInitial());

  void _handleAuthResetEvent(AuthResetEvent event, Emitter<AuthState> emit) =>
      emit(AuthInitial());

  /// Cancels the [authStateChanges] subscription when the BLoC is closed.
  ///
  /// This prevents memory leaks by properly cleaning up the subscription
  /// to the Firebase authentication state stream.
  @override
  Future<void> close() {
    _authStateSubscription.cancel();
    return super.close();
  }
}
