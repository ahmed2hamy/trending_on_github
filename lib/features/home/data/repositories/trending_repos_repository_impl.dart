import 'package:dartz/dartz.dart';
import 'package:trending_on_github/constants/constants.dart';
import 'package:trending_on_github/core/data/models/success_model.dart';
import 'package:trending_on_github/core/data/network/network_info.dart';
import 'package:trending_on_github/core/domain/error/failures.dart';
import 'package:trending_on_github/features/home/data/data_sources/remote/trending_repos_remote_data_source.dart';
import 'package:trending_on_github/features/home/data/models/github_repo_model.dart';
import 'package:trending_on_github/features/home/domain/repositories/trending_repos_repository.dart';

class TrendingReposRepositoryImpl extends TrendingReposRepository {
  final TrendingReposRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  TrendingReposRepositoryImpl({
    required TrendingReposRemoteDataSource remoteDataSource,
    required NetworkInfo networkInfo,
  })  : _remoteDataSource = remoteDataSource,
        _networkInfo = networkInfo;

  @override
  Future<Either<Failure, GithubRepoModel>> getTrendingReposEvent(
      Map<String, dynamic> request) async {
    if (await _networkInfo.isConnected) {
      try {
        var res = await _remoteDataSource.getTrendingRepos(request);

        return Right(res);
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return const Left(
        CacheFailure(message: Strings.unimplementedErrorMessage),
      );
    }
  }

  @override
  Future<Either<Failure, SuccessModel>> launchRepoUrlEvent(String url) async {
    if (await _networkInfo.isConnected) {
      try {
        await _remoteDataSource.launchUrl(url);

        return Right(SuccessModel());
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return const Left(
        CacheFailure(message: Strings.unimplementedErrorMessage),
      );
    }
  }

  @override
  Future<Either<Failure, SuccessModel>> logoutCurrentUserEvent() async {
    if (await _networkInfo.isConnected) {
      try {
        await _remoteDataSource.logoutCurrentUser();

        return Right(SuccessModel());
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return const Left(
        CacheFailure(message: Strings.unimplementedErrorMessage),
      );
    }
  }
}
