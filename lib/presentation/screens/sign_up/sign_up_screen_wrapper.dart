import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/options/localization/l10n.dart';
import '../../bloc/sign_up/sign_up_bloc.dart';
import '../home/home_screen_wrapper.dart';
import 'sign_up_screen.dart';

/// This widget listens to the [SignUpBloc] state
///
/// It manages the following states:
/// - [SignUpInitial]: Shows the sign-up form
/// - [SignUpLoading]: Shows a loading indicator
/// - [SignUpSuccess]: Navigates to home screen
/// - [SignUpFailure]: Displays error message
class SignUpScreenWrapper extends StatelessWidget {
  const SignUpScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        switch (state) {
          case SignUpInitial():
            return _buildInitialState();
          case SignUpLoading():
            return _buildLoadingState();
          case SignUpSuccess():
            return _buildSuccessState();
          case SignUpFailure():
            return _buildFailureState(context, state);
        }
      },
    );
  }

  Widget _buildInitialState() => const SignUpScreen();

  Widget _buildLoadingState() =>
      const Center(child: CircularProgressIndicator());

  Widget _buildSuccessState() => const HomeScreenWrapper();

  Widget _buildFailureState(context, state) => Center(
    child: Text(S.of(context).errorCodeAndMessage(
        state.code as Object,
        state.message as Object)),
  );
}
