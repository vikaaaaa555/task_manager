import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/options/localization/l10n.dart';
import '../../bloc/sign_in/sign_in_bloc.dart';
import '../home/home_screen_wrapper.dart';
import 'sign_in_screen.dart';

/// This widget listens to the [SignInBloc] state
///
/// It manages the following states:
/// - [SignInInitial]: Shows the sign-in form
/// - [SignInLoading]: Shows a loading indicator
/// - [SignInSuccess]: Navigates to home screen
/// - [SignInFailure]: Displays error message
class SignInScreenWrapper extends StatelessWidget {
  const SignInScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      builder: (context, state) {
        switch (state) {
          case SignInInitial():
            return _buildInitialState();
          case SignInLoading():
            return _buildLoadingState();
          case SignInSuccess():
            return _buildSuccessState();
          case SignInFailure():
            return _buildFailureState(context, state);
        }
      },
    );
  }

  Widget _buildInitialState() => const SignInScreen();

  Widget _buildLoadingState() =>
      const Center(child: CircularProgressIndicator());

  Widget _buildSuccessState() => const HomeScreenWrapper();

  Widget _buildFailureState(context, state) => Center(
    child: Text(S.of(context).errorCodeAndMessage(
        state.code as Object,
        state.message as Object)),
  );
}