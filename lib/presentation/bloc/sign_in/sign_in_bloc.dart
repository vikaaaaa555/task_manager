import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../features/auth/domain/use_cases/sign_in_with_email_and_password.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

/// Manages the state of the sign-in flow and processes user sign-in requests.
class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInWithEmailAndPasswordUseCase _signInWithEmailAndPasswordUseCase;

  SignInBloc({
    required SignInWithEmailAndPasswordUseCase
    signInWithEmailAndPasswordUseCase,
  }) : _signInWithEmailAndPasswordUseCase = signInWithEmailAndPasswordUseCase,
       super(SignInInitial()) {
    on<RequestForSignInEvent>(_handleRequestForSignInEvent);
  }

  Future<void> _handleRequestForSignInEvent(
    RequestForSignInEvent event,
    Emitter<SignInState> emit,
  ) async {
    emit(SignInLoading());
    try {
      final userCredential = await _signInWithEmailAndPasswordUseCase(
        SignInWithEmailAndPasswordParams(
          email: event.email,
          password: event.password,
        ),
      );
      emit(SignInSuccess(userCredential.user!));
    } on FirebaseAuthException catch (e) {
      emit(
        SignInFailure(code: e.code, message: e.message),
      );
    } catch (e) {
      emit(SignInFailure(message: e.toString()));
    }
  }
}
