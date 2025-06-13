import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:task_manager/features/auth/domain/use_cases/reset_password.dart';

import 'core/options/localization/l10n.dart';
import 'core/services/app_dependencies.dart';
import 'core/utils/styles/theme_config.dart';
import 'features/auth/domain/use_cases/create_account_with_email_and_password.dart';
import 'features/auth/domain/use_cases/sign_in_with_email_and_password.dart';
import 'core/utils/media.dart';
import 'presentation/bloc/auth/auth_bloc.dart';
import 'presentation/screens/auth/auth_screen_wrapper.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /// The root widget of the application.
  ///
  /// Sets up localization, theming, and global [BlocProvider]s.
  /// Initializes screen size configuration via [Media.init].
  @override
  Widget build(BuildContext context) {
    Media.init(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create:
              (context) => AuthBloc(
                createAccountWithEmailAndPasswordUseCase:
                    sl<CreateAccountWithEmailAndPasswordUseCase>(),
                signInWithEmailAndPasswordUseCase:
                    sl<SignInWithEmailAndPasswordUseCase>(),
                resetPasswordUseCase: sl<ResetPasswordUseCase>(),
                authStateChanges: sl<Stream<User?>>(),
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
        home: AuthScreenWrapper(),
      ),
    );
  }
}
