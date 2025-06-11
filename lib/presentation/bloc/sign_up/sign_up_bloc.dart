import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../features/auth/domain/use_cases/create_account_with_email_and_password.dart';

part 'sign_up_event.dart';

part 'sign_up_state.dart';

/// Business Logic Component (BLoC) responsible for handling the sign-up process.
///
/// Manages the state of the sign-up flow and processes user sign-up requests.
/// Responds to [SignUpEvent]s and emits appropriate [SignUpState]s.
class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final CreateAccountWithEmailAndPasswordUseCase
  _createAccountWithEmailAndPasswordUseCase;

  SignUpBloc({
    required CreateAccountWithEmailAndPasswordUseCase
    createAccountWithEmailAndPasswordUseCase,
  }) : _createAccountWithEmailAndPasswordUseCase =
           createAccountWithEmailAndPasswordUseCase,
       super(SignUpInitial()) {
    on<RequestForSignUpEvent>(_handleRequestForSignUpEvent);
  }

  /// Handles [RequestForSignUpEvent] by attempting to create a new user account.
  ///
  /// State transitions:
  /// 1. Emits [SignUpLoading] immediately when processing starts
  /// 2. On success: emits [SignUpSuccess] with the created user
  /// 3. On failure: emits [SignUpFailure] with error details
  ///
  /// Parameters:
  /// - [event]: Contains the email and password for account creation
  /// - [emit]: Function to emit new states
  Future<void> _handleRequestForSignUpEvent(
    RequestForSignUpEvent event,
    Emitter<SignUpState> emit,
  ) async {
    emit(SignUpLoading());
    try {
      final userCredential = await _createAccountWithEmailAndPasswordUseCase(
        CreateAccountWithEmailAndPasswordParams(
          email: event.email,
          password: event.password,
        ),
      );
      emit(SignUpSuccess(userCredential.user!));
    } on FirebaseAuthException catch (e) {
      emit(
        SignUpFailure(code: e.code, message: e.message ?? 'Sign up failure'),
      );
    } catch (e) {
      emit(SignUpFailure(message: e.toString()));
    }
  }
}
