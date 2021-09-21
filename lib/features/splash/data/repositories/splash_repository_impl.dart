import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trending_on_github/constants/constants.dart';
import 'package:trending_on_github/core/data/network/network_info.dart';
import 'package:trending_on_github/core/domain/error/failures.dart';
import 'package:trending_on_github/features/splash/data/data_sources/remote/splash_remote_data_source.dart';
import 'package:trending_on_github/features/splash/domain/repositories/splash_repository.dart';

class SplashRepositoryImpl implements SplashRepository {
  final SplashRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  SplashRepositoryImpl({
    required SplashRemoteDataSource remoteDataSource,
    required NetworkInfo networkInfo,
  })  : _remoteDataSource = remoteDataSource,
        _networkInfo = networkInfo;

  @override
  Future<Either<Failure, User>> loginCurrentUserEvent() async {
    if (await _networkInfo.isConnected) {
      return await _remoteDataSource.loginCurrentUser();
    } else {
      return const Left(ServerFailure(message: Strings.noNetworkErrorMessage));
    }
  }
}
