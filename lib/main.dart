import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trending_on_github/constants/constants.dart';
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
    return MaterialApp(
      title: Strings.appName,
      theme: kAppThemeData,
      home: BlocProvider<SplashCubit>(
        create: (_) => di.sl(),
        child: const SplashScreen(),
      ),
    );
  }
}
