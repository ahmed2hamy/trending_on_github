import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/core/data/network/network_info.dart';
import 'package:news_app/features/login/data/data_sources/remote/login_remote_data_source.dart';
import 'package:news_app/features/login/data/repositories/login_repository_impl.dart';
import 'package:news_app/features/login/domain/repositories/login_repository.dart';
import 'package:news_app/features/login/domain/use_cases/login_current_user_use_case.dart';
import 'package:news_app/features/login/domain/use_cases/login_with_email_and_password_use_case.dart';
import 'package:news_app/features/login/presentation/manager/login_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Services init
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //! Features
  // Bloc
  sl.registerLazySingleton(
    () => LoginCubit(
      loginCurrentUserUseCase: sl(),
      loginWithEmailAndPasswordUseCase: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginCurrentUserUseCase(sl()));
  sl.registerLazySingleton(() => LoginWithEmailAndPasswordUseCase(sl()));

  // Repository
  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<LoginRemoteDataSource>(
    () => LoginRemoteDataSourceImpl(firebaseAuth: sl()),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  sl.registerLazySingleton(() => firebaseAuth);
  sl.registerLazySingleton(() => Connectivity());
}
