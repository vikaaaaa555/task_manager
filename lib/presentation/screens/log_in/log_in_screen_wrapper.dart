import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/options/localization/l10n.dart';
import '../../bloc/log_in/log_in_bloc.dart';
import '../home/home_screen_wrapper.dart';
import 'log_in_screen.dart';

/// This widget listens to the [LogInBloc] state
///
/// It manages the following states:
/// - [LogInInitial]: Shows the log-in form
/// - [LogInLoading]: Shows a loading indicator
/// - [LogInSuccess]: Navigates to home screen
/// - [LogInFailure]: Displays error message
class LogInScreenWrapper extends StatelessWidget {
  const LogInScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogInBloc, LogInState>(
      builder: (context, state) {
        switch (state) {
          case LogInInitial():
            return _buildInitialState();
          case LogInLoading():
            return _buildLoadingState();
          case LogInSuccess():
            return _buildSuccessState();
          case LogInFailure():
            return _buildFailureState(context, state);
        }
      },
    );
  }

  Widget _buildInitialState() => const LogInScreen();

  Widget _buildLoadingState() =>
      const Center(child: CircularProgressIndicator());

  Widget _buildSuccessState() => const HomeScreenWrapper();

  Widget _buildFailureState(context, state) => Center(
    child: Text(S.of(context).errorCodeAndMessage(
        state.code as Object,
        state.message as Object)),
  );
}