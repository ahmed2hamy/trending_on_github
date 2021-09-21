import 'package:bloc/bloc.dart';
import 'package:trending_on_github/core/domain/usecases/usecase.dart';
import 'package:trending_on_github/features/home/domain/use_cases/get_trending_repos_use_case.dart';
import 'package:trending_on_github/features/home/domain/use_cases/launch_repo_url_use_case.dart';
import 'package:trending_on_github/features/home/domain/use_cases/logout_current_user_use_case.dart';
import 'package:trending_on_github/features/home/presentation/manager/trending_repos_cubit/trending_repos_state.dart';

class TrendingReposCubit extends Cubit<TrendingReposState> {
  final GetTrendingReposUseCase _getTrendingReposUseCase;
  final LaunchRepoUrlUseCase _launchRepoUrlUseCase;
  final LogoutCurrentUserUseCase _logoutCurrentUserUseCase;

  TrendingReposCubit({
    required GetTrendingReposUseCase getTrendingReposUseCase,
    required LaunchRepoUrlUseCase launchRepoUrlUseCase,
    required LogoutCurrentUserUseCase logoutCurrentUserUseCase,
  })  : _getTrendingReposUseCase = getTrendingReposUseCase,
        _launchRepoUrlUseCase = launchRepoUrlUseCase,
        _logoutCurrentUserUseCase = logoutCurrentUserUseCase,
        super(TrendingReposInitialState());

  Future getTrendingRepos(Map<String, dynamic> request) async {
    emit(TrendingReposLoadingState());
    await getMoreTrendingRepos(request);
  }

  Future getMoreTrendingRepos(Map<String, dynamic> request) async {
    var res = await _getTrendingReposUseCase
        .call(GetTrendingReposParams(request: request));

    res.fold(
      (failure) => emit(
        TrendingReposErrorState(failure.message),
      ),
      (model) => emit(
        TrendingReposLoadedState(model),
      ),
    );
  }

  Future launchRepoUrl(String url) async {
    var res = await _launchRepoUrlUseCase.call(LaunchRepoUrlParams(url: url));

    res.fold(
      (failure) => emit(
        TrendingReposErrorState(failure.message),
      ),
      (_) => null,
    );
  }

  Future logoutCurrentUser() async {
    var res = await _logoutCurrentUserUseCase.call(NoParams());

    res.fold(
      (failure) => emit(
        TrendingReposErrorState(failure.message),
      ),
      (_) => emit(UserLogoutState()),
    );
  }
}
