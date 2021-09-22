import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trending_on_github/constants/constants.dart';
import 'package:trending_on_github/core/ui/helpers/app_navigator.dart';
import 'package:trending_on_github/core/ui/helpers/screen_info.dart';
import 'package:trending_on_github/features/home/presentation/pages/home_screen.dart';
import 'package:trending_on_github/features/login/presentation/pages/login_screen.dart';
import 'package:trending_on_github/features/splash/presentation/manager/splash_cubit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<SplashCubit>().loginCurrentUser();
    return BlocListener<SplashCubit, SplashState>(
      listener: (con, state) {
        if (state is SplashLoadedState) {
          if (state.user.refreshToken != null) {
            AppNavigator.pushReplacement(
              context,
              widget: const HomeScreen(),
            );
          }
        } else if (state is SplashErrorState) {
          AppNavigator.pushReplacement(
            context,
            widget: const LoginScreen(),
          );
        }
      },
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Center(
            child: Image(
              image: const AssetImage(kLogoImage),
              width: ScreenInfo.screenWidth(context) * 0.5,
            ),
          ),
        ),
      ),
    );
  }
}
