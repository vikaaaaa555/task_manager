import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:task_manager/features/auth/domain/use_cases/sign_in_with_email_and_password.dart';
import 'package:task_manager/presentation/bloc/sign_in/sign_in_bloc.dart';

import 'core/options/localization/l10n.dart';
import 'core/services/app_dependencies.dart';
import 'core/utils/styles/theme_config.dart';
import 'features/auth/domain/use_cases/create_account_with_email_and_password.dart';
import 'presentation/bloc/sign_up/sign_up_bloc.dart';
import 'presentation/screens/sign_in/sign_in_screen_wrapper.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignUpBloc>(
          create:
              (context) => SignUpBloc(
                createAccountWithEmailAndPasswordUseCase:
                    sl<CreateAccountWithEmailAndPasswordUseCase>(),
              ),
        ),
        BlocProvider<SignInBloc>(
          create:
              (context) => SignInBloc(
                signInWithEmailAndPasswordUseCase:
                    sl<SignInWithEmailAndPasswordUseCase>(),
              ),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        theme: lightTheme,
        darkTheme: darkTheme,
        home: SignInScreenWrapper(),
      ),
    );
  }
}
