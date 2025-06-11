import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/presentation/bloc/sign_up/sign_up_bloc.dart';

import 'core/services/app_dependencies.dart';
import 'core/utils/styles/theme_config.dart';
import 'features/auth/domain/use_cases/create_account_with_email_and_password.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignUpBloc>(
          create: (context) =>
              SignUpBloc(createAccountWithEmailAndPasswordUseCase:
              sl<CreateAccountWithEmailAndPasswordUseCase>()),
        ),
      ],
      child: MaterialApp(
          theme: lightTheme,
          darkTheme: darkTheme,
          home:
      ),
    );
  }
}
