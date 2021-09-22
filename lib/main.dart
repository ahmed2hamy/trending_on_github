import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trending_on_github/constants/constants.dart';
import 'package:trending_on_github/features/home/presentation/manager/trending_repos_cubit/trending_repos_cubit.dart';
import 'package:trending_on_github/features/home/presentation/manager/trending_repos_scroll_to_top_cubit/trending_repos_scroll_to_top_cubit.dart';
import 'package:trending_on_github/features/login/presentation/manager/login_cubit.dart';
import 'package:trending_on_github/features/splash/presentation/manager/splash_cubit.dart';
import 'package:trending_on_github/features/splash/presentation/pages/splash_screen.dart';
import 'package:trending_on_github/injection_container.dart' as di;

void main() async {
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SplashCubit>(
          create: (_) => di.sl(),
        ),
        BlocProvider<LoginCubit>(
          create: (_) => di.sl(),
        ),
        BlocProvider<TrendingReposCubit>(
          create: (_) => di.sl(),
        ),
        BlocProvider<TrendingReposScrollToTopCubit>(
          create: (_) => di.sl(),
        ),
      ],
      child: MaterialApp(
        title: Strings.appName,
        theme: kAppThemeData,
        home: const SplashScreen(),
      ),
    );
  }
}
