import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trending_on_github/constants/constants.dart';
import 'package:trending_on_github/core/data/network/network_info.dart';
import 'package:trending_on_github/core/domain/error/failures.dart';
import 'package:trending_on_github/features/login/data/data_sources/remote/login_remote_data_source.dart';
import 'package:trending_on_github/features/login/domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  LoginRepositoryImpl({
    required LoginRemoteDataSource remoteDataSource,
    required NetworkInfo networkInfo,
  })  : _remoteDataSource = remoteDataSource,
        _networkInfo = networkInfo;

  @override
  Future<Either<Failure, UserCredential>> loginWithEmailAndPasswordEvent(
      {required String email, required String password}) async {
    if (await _networkInfo.isConnected) {
      return await _remoteDataSource.loginWithEmailAndPassword(
          email: email, password: password);
    } else {
      return const Left(ServerFailure(message: Strings.noNetworkErrorMessage));
    }
  }
}
