import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../features/auth/domain/use_cases/create_account_with_email_and_password.dart';
import '../../../features/auth/domain/use_cases/reset_password.dart';
import '../../../features/auth/domain/use_cases/sign_in_with_email_and_password.dart';

part 'auth_event.dart';

part 'auth_state.dart';

/// Bloc responsible for handling authentication events and states.
///
/// Supports signing up and logging in using email and password. Uses
/// [CreateAccountWithEmailAndPasswordUseCase] and [SignInWithEmailAndPasswordUseCase]
/// to perform authentication via Firebase.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final CreateAccountWithEmailAndPasswordUseCase
  _createAccountWithEmailAndPasswordUseCase;
  final SignInWithEmailAndPasswordUseCase _signInWithEmailAndPasswordUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;

  /// Creates an instance of [AuthBloc] with required use cases.
  AuthBloc({
    required CreateAccountWithEmailAndPasswordUseCase
    createAccountWithEmailAndPasswordUseCase,
    required SignInWithEmailAndPasswordUseCase
    signInWithEmailAndPasswordUseCase,
    required ResetPasswordUseCase resetPasswordUseCase,
  }) : _createAccountWithEmailAndPasswordUseCase =
           createAccountWithEmailAndPasswordUseCase,
       _signInWithEmailAndPasswordUseCase = signInWithEmailAndPasswordUseCase,
       _resetPasswordUseCase = resetPasswordUseCase,
       super(AuthInitial()) {
    on<SignUpEvent>(_handleSignUpEvent);
    on<LogInEvent>(_handleLogInEvent);
    on<ResetPasswordEvent>(_handleResetPasswordEvent);
  }

  /// Handles [SignUpEvent] by creating an account and emitting [AuthSuccess] or [AuthFailure].
  Future<void> _handleSignUpEvent(
    SignUpEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final userCredential = await _createAccountWithEmailAndPasswordUseCase(
        CreateAccountWithEmailAndPasswordParams(
          email: event.email,
          password: event.password,
        ),
      );
      emit(AuthSuccess(userCredential.user!));
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
      final userCredential = await _signInWithEmailAndPasswordUseCase(
        SignInWithEmailAndPasswordParams(
          email: event.email,
          password: event.password,
        ),
      );
      emit(AuthSuccess(userCredential.user!));
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
      await _resetPasswordUseCase(ResetPasswordParams(email: event.email));
      emit(AuthInitial());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(code: e.code, message: e.message));
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }
}
