import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
        if (state is AuthSuccess) context.go('/home');
      },
      builder: (context, state) {
        switch (state) {
          case AuthInitial():
            return const AuthScreen();
          case AuthLoading():
          case AuthSuccess():
            return const Center(child: CircularProgressIndicator());
          case AuthFailure():
            return Column(
              children: [
                Center(child: Text('${state.message}')),
                ElevatedButton(
                  onPressed:
                      () => context.read<AuthBloc>().add(AuthResetEvent()),
                  child: Text(S.of(context).goBack),
                ),
              ],
            );
        }
      },
    );
  }
}
