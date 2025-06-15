import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/options/localization/l10n.dart';
import 'core/services/app_dependencies.dart';
import 'core/utils/constants/styles/theme_config.dart';
import 'core/utils/media.dart';
import 'features/auth/domain/use_cases/create_account_with_email_and_password_use_case.dart';
import 'features/auth/domain/use_cases/reset_password_use_case.dart';
import 'features/auth/domain/use_cases/sign_in_with_email_and_password_use_case.dart';
import 'features/task/domain/use_cases/create_task_use_case.dart';
import 'features/task/domain/use_cases/delete_task_use_case.dart';
import 'features/task/domain/use_cases/get_all_tasks_use_case.dart';
import 'features/task/domain/use_cases/update_task_use_case.dart';
import 'presentation/bloc/auth/auth_bloc.dart';
import 'presentation/bloc/home/home_bloc.dart';
import 'presentation/router/router.dart';

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
        BlocProvider<HomeBloc>(
          create:
              (context) => HomeBloc(
                getAllTasksUseCase: sl<GetAllTasksUseCase>(),
                createTaskUseCase: sl<CreateTaskUseCase>(),
                deleteTaskUseCase: sl<DeleteTaskUseCase>(),
                updateTaskUseCase: sl<UpdateTaskUseCase>(),
              ),
        ),
      ],
      child: MaterialApp.router(
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        theme: lightTheme,
        darkTheme: darkTheme,
        routerDelegate: AppNavigation.router.routerDelegate,
        routeInformationParser:
        AppNavigation.router.routeInformationParser,
        routeInformationProvider:
        AppNavigation.router.routeInformationProvider,
      ),
    );
  }
}
