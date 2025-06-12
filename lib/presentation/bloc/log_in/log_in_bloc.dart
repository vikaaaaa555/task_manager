import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../features/auth/domain/use_cases/sign_in_with_email_and_password.dart';

part 'log_in_event.dart';
part 'log_in_state.dart';

/// Manages the state of the log-in flow and processes user log-in requests.
class LogInBloc extends Bloc<LogInEvent, LogInState> {
  final SignInWithEmailAndPasswordUseCase _signInWithEmailAndPasswordUseCase;

  LogInBloc({
    required SignInWithEmailAndPasswordUseCase
    signInWithEmailAndPasswordUseCase,
  }) : _signInWithEmailAndPasswordUseCase = signInWithEmailAndPasswordUseCase,
       super(LogInInitial()) {
    on<RequestForLogInEvent>(_handleRequestForSignInEvent);
  }

  Future<void> _handleRequestForSignInEvent(
    RequestForLogInEvent event,
    Emitter<LogInState> emit,
  ) async {
    emit(LogInLoading());
    try {
      final userCredential = await _signInWithEmailAndPasswordUseCase(
        SignInWithEmailAndPasswordParams(
          email: event.email,
          password: event.password,
        ),
      );
      emit(LogInSuccess(userCredential.user!));
    } on FirebaseAuthException catch (e) {
      emit(
        LogInFailure(code: e.code, message: e.message),
      );
    } catch (e) {
      emit(LogInFailure(message: e.toString()));
    }
  }
}
