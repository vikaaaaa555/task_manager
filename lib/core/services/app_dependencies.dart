import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/data/data_sources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/use_cases/create_account_with_email_and_password.dart';
import '../../features/auth/domain/use_cases/delete_account.dart';
import '../../features/auth/domain/use_cases/reset_password.dart';
import '../../features/auth/domain/use_cases/reset_password_from_current_password.dart';
import '../../features/auth/domain/use_cases/sign_in_with_email_and_password.dart';
import '../../features/auth/domain/use_cases/sign_out.dart';
import '../../features/auth/domain/use_cases/update_username.dart';

final sl = GetIt.instance;

Future<void> registerAppDependencies() async => await Future.wait([
  _registerExternal(),
  _registerUseCases(),
  _registerRepositories(),
  _registerDataSources(),
  _registerStreams(),
]);

Future<void> _registerExternal() async {}

Future<void> _registerUseCases() async =>
    sl
      ..registerLazySingleton(
        () => CreateAccountWithEmailAndPasswordUseCase(sl()),
      )
      ..registerLazySingleton(() => DeleteAccountUseCase(sl()))
      ..registerLazySingleton(() => ResetPasswordUseCase(sl()))
      ..registerLazySingleton(
        () => ResetPasswordFromCurrentPasswordUseCase(sl()),
      )
      ..registerLazySingleton(() => SignInWithEmailAndPasswordUseCase(sl()))
      ..registerLazySingleton(() => SignOutUseCase(sl()))
      ..registerLazySingleton(() => UpdateUsernameUseCase(sl()));

Future<void> _registerRepositories() async =>
    sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

Future<void> _registerDataSources() async =>
    sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(),
    );

Future<void> _registerStreams() async =>
    sl.registerLazySingleton<Stream<User?>>(
      () => sl<AuthRepository>().authStateChanges,
    );
