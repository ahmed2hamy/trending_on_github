import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:trending_on_github/core/domain/error/failures.dart';
import 'package:trending_on_github/core/domain/usecases/usecase.dart';
import 'package:trending_on_github/features/home/data/models/github_repo_model.dart';
import 'package:trending_on_github/features/home/domain/repositories/trending_repos_repository.dart';

class GetTrendingReposUseCase
    implements UseCase<GithubRepoModel, GetTrendingReposParams> {
  final TrendingReposRepository _repository;

  GetTrendingReposUseCase({
    required TrendingReposRepository repository,
  }) : _repository = repository;

  @override
  Future<Either<Failure, GithubRepoModel>> call(
      GetTrendingReposParams params) async {
    return await _repository.getTrendingReposEvent(params.request);
  }
}

class GetTrendingReposParams extends Equatable {
  final Map<String, dynamic> request;

  const GetTrendingReposParams({required this.request});

  @override
  List<Object> get props => [request];
}
