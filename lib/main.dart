import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/constants/constants.dart';
import 'package:news_app/features/login/presentation/manager/login_cubit.dart';
import 'package:news_app/features/login/presentation/pages/login_screen.dart';
import 'package:news_app/injection_container.dart' as di;

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
      home: BlocProvider<LoginCubit>(
        create: (_) => di.sl(),
        child: const LoginScreen(),
      ),
    );
  }
}
