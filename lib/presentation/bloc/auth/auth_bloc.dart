import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../features/auth/domain/use_cases/create_account_with_email_and_password.dart';
import '../../../features/auth/domain/use_cases/sign_in_with_email_and_password.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final CreateAccountWithEmailAndPasswordUseCase
  _createAccountWithEmailAndPasswordUseCase;
  final SignInWithEmailAndPasswordUseCase _signInWithEmailAndPasswordUseCase;

  AuthBloc({
    required CreateAccountWithEmailAndPasswordUseCase
    createAccountWithEmailAndPasswordUseCase,
    required SignInWithEmailAndPasswordUseCase
    signInWithEmailAndPasswordUseCase,
  }) : _createAccountWithEmailAndPasswordUseCase =
           createAccountWithEmailAndPasswordUseCase,
       _signInWithEmailAndPasswordUseCase = signInWithEmailAndPasswordUseCase,
       super(AuthInitial()) {
    on<SignUpEvent>(_handleSignUpEvent);
    on<LogInEvent>(_handleLogInEvent);
  }

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
}
