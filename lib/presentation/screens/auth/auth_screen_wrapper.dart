import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/options/localization/l10n.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../home/home_screen_wrapper.dart';
import 'auth_screen.dart';

/// A wrapper widget that listens to [AuthBloc] and navigates accordingly.
///
/// This widget builds the appropriate UI based on the [AuthState]:
/// - Navigates to [HomeScreenWrapper] on [AuthSuccess].
/// - Shows [AuthScreen] on [AuthInitial].
/// - Displays a loading indicator on [AuthLoading] or while navigating.
/// - Displays an error message on [AuthFailure].
class AuthScreenWrapper extends StatelessWidget {
  const AuthScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const HomeScreenWrapper()),
          );
        }
      },
      builder: (context, state) {
        if (state is AuthInitial) {
          return const AuthScreen();
        } else if (state is AuthLoading || state is AuthSuccess) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AuthFailure) {
          return Center(child: Text(S.of(context).errorCodeAndMessage(
            state.code as Object,
            state.message as Object)),
          );
        } else {
          return Center(child: Text(S.of(context).unexpectedError));
        }
      },
    );
  }
}
