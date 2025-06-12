import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/options/localization/l10n.dart';
import '../../bloc/sign_up/sign_up_bloc.dart';
import '../home/home_screen_wrapper.dart';
import 'sign_up_screen.dart';

class SignUpScreenWrapper extends StatelessWidget {
  const SignUpScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        if (state is SignUpInitial) {
          return SignUpScreen();
        } else if (state is SignUpLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SignUpSuccess) {
          return HomeScreenWrapper();
        } else if (state is SignUpFailure) {
          return Center(
            child: Text(S.of(context).errorCodeAndMessage(
              state.code as Object,
              state.message as Object,
            )),
          );
        } else {
          return Center(child: Text(S.of(context).unexpectedError));
        }
      },
    );
  }
}
