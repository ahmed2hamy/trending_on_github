import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trending_on_github/constants/constants.dart';
import 'package:trending_on_github/features/home/presentation/manager/trending_repos_cubit/trending_repos_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () async {
          await context.read<TrendingReposCubit>().logoutCurrentUser();
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: const [
              LogoutIconWidget(iconSize: 50),
              SizedBox(height: 5),
              Text(Strings.logout, style: kTitleBlackTextStyle),
            ],
          ),
        ),
      ),
    );
  }
}

class LogoutIconWidget extends StatelessWidget {
  final double iconSize;

  const LogoutIconWidget({
    Key? key,
    required this.iconSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: iconSize,
      width: iconSize,
      child: Icon(
        Icons.logout,
        size: iconSize,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
