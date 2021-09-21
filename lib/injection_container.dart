import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:trending_on_github/core/data/network/network_info.dart';
import 'package:trending_on_github/features/home/data/data_sources/remote/trending_repos_remote_data_source.dart';
import 'package:trending_on_github/features/home/data/repositories/trending_repos_repository_impl.dart';
import 'package:trending_on_github/features/home/domain/repositories/trending_repos_repository.dart';
import 'package:trending_on_github/features/home/domain/use_cases/get_trending_repos_use_case.dart';
import 'package:trending_on_github/features/home/domain/use_cases/launch_repo_url_use_case.dart';
import 'package:trending_on_github/features/home/domain/use_cases/logout_current_user_use_case.dart';
import 'package:trending_on_github/features/home/presentation/manager/trending_repos_cubit/trending_repos_cubit.dart';
import 'package:trending_on_github/features/home/presentation/manager/trending_repos_scroll_to_top_cubit/trending_repos_scroll_to_top_cubit.dart';
import 'package:trending_on_github/features/login/data/data_sources/remote/login_remote_data_source.dart';
import 'package:trending_on_github/features/login/data/repositories/login_repository_impl.dart';
import 'package:trending_on_github/features/login/domain/repositories/login_repository.dart';
import 'package:trending_on_github/features/login/domain/use_cases/login_with_email_and_password_use_case.dart';
import 'package:trending_on_github/features/login/presentation/manager/login_cubit.dart';
import 'package:trending_on_github/features/splash/data/data_sources/remote/splash_remote_data_source.dart';
import 'package:trending_on_github/features/splash/data/repositories/splash_repository_impl.dart';
import 'package:trending_on_github/features/splash/domain/repositories/splash_repository.dart';
import 'package:trending_on_github/features/splash/domain/use_cases/login_current_user_use_case.dart';
import 'package:trending_on_github/features/splash/presentation/manager/splash_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Services init
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //! Features

  //Splash

  // Bloc
  sl.registerLazySingleton(
    () => SplashCubit(
      loginCurrentUserUseCase: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(
    () => LoginCurrentUserUseCase(
      repository: sl(),
    ),
  );

  // Repository
  sl.registerLazySingleton<SplashRepository>(
    () => SplashRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<SplashRemoteDataSource>(
    () => SplashRemoteDataSourceImpl(firebaseAuth: sl()),
  );

  //Login

  // Bloc
  sl.registerLazySingleton(
    () => LoginCubit(
      loginWithEmailAndPasswordUseCase: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginWithEmailAndPasswordUseCase(
        repository: sl(),
      ));

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

  //Home

  // Bloc
  sl.registerLazySingleton(
    () => TrendingReposCubit(
      getTrendingReposUseCase: sl(),
      launchRepoUrlUseCase: sl(),
      logoutCurrentUserUseCase: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => TrendingReposScrollToTopCubit(),
  );

  // Use cases
  sl.registerLazySingleton(() => GetTrendingReposUseCase(
        repository: sl(),
      ));
  sl.registerLazySingleton(() => LaunchRepoUrlUseCase(
        repository: sl(),
      ));
  sl.registerLazySingleton(() => LogoutCurrentUserUseCase(
        repository: sl(),
      ));

  // Repository
  sl.registerLazySingleton<TrendingReposRepository>(
    () => TrendingReposRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<TrendingReposRemoteDataSource>(
    () => TrendingReposRemoteDataSourceImpl(
      dio: sl(),
      auth: sl(),
    ),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  sl.registerLazySingleton(() => firebaseAuth);
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton(() => Dio());
}
