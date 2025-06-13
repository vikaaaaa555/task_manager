import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/options/localization/l10n.dart';
import '../../../core/utils/media.dart';
import '../../bloc/auth/auth_bloc.dart';
import 'widgets/auth_widget.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AuthBloc>();

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: Media.screenHeight * 0.3,
          horizontal: Media.screenWidth * 0.2,
        ),
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            body: Center(
              child: Column(
                children: [
                  TabBar(
                    tabs: [
                      Tab(text: S.of(context).logIn),
                      Tab(text: S.of(context).signUp),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        AuthWidget(
                          title: S.of(context).logIn,
                          onSubmit:
                              (email, password) => bloc.add(
                                LogInEvent(email: email, password: password),
                              ),
                          showForgotPassword: true,
                        ),
                        AuthWidget(
                          title: S.of(context).signUp,
                          onSubmit:
                              (email, password) => bloc.add(
                                SignUpEvent(email: email, password: password),
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
