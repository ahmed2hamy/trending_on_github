import 'package:trending_on_github/features/home/data/models/github_repo_model.dart';

abstract class TrendingReposState {}

class TrendingReposInitialState extends TrendingReposState {}

class TrendingReposLoadingState extends TrendingReposState {}

class TrendingReposLoadedState extends TrendingReposState {
  final GithubRepoModel model;

  TrendingReposLoadedState(this.model);
}

class UserLogoutState extends TrendingReposState {}

class TrendingReposErrorState extends TrendingReposState {
  final String errorMessage;

  TrendingReposErrorState(this.errorMessage);
}
