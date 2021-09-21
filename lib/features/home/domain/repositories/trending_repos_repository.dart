import 'package:dartz/dartz.dart';
import 'package:trending_on_github/core/data/models/success_model.dart';
import 'package:trending_on_github/core/domain/error/failures.dart';
import 'package:trending_on_github/features/home/data/models/github_repo_model.dart';

abstract class TrendingReposRepository {
  Future<Either<Failure, GithubRepoModel>> getTrendingReposEvent(
      Map<String, dynamic> request);

  Future<Either<Failure, SuccessModel>> launchRepoUrlEvent(String url);

  Future<Either<Failure, SuccessModel>> logoutCurrentUserEvent();
}
