import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:trending_on_github/core/data/models/success_model.dart';
import 'package:trending_on_github/core/domain/error/failures.dart';
import 'package:trending_on_github/core/domain/usecases/usecase.dart';
import 'package:trending_on_github/features/home/domain/repositories/trending_repos_repository.dart';

class LaunchRepoUrlUseCase
    implements UseCase<SuccessModel, LaunchRepoUrlParams> {
  final TrendingReposRepository _repository;

  LaunchRepoUrlUseCase({
    required TrendingReposRepository repository,
  }) : _repository = repository;

  @override
  Future<Either<Failure, SuccessModel>> call(LaunchRepoUrlParams params) async {
    return await _repository.launchRepoUrlEvent(params.url);
  }
}

class LaunchRepoUrlParams extends Equatable {
  final String url;

  const LaunchRepoUrlParams({required this.url});

  @override
  List<Object> get props => [];
}
