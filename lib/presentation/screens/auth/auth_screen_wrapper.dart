import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/options/localization/l10n.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../home/home_screen_wrapper.dart';
import 'auth_screen.dart';

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
        } else if (state is AuthFailure) {
          Center(
            child: Text(S.of(context).errorCodeAndMessage(
                state.code as Object,
                state.message as Object)),
          );
        }
      },
      builder: (context, state) {
        if (state is AuthInitial) {
          return const AuthScreen();
        } else if (state is AuthLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Center(child: Text(S.of(context).unexpectedError));
        }
      },
    );
  }
}
