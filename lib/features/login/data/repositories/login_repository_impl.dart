import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/constants/constants.dart';
import 'package:news_app/core/data/network/network_info.dart';
import 'package:news_app/core/domain/error/failures.dart';
import 'package:news_app/features/login/data/data_sources/remote/login_remote_data_source.dart';
import 'package:news_app/features/login/domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  LoginRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, User>> loginCurrentUserEvent() async {
    if (await networkInfo.isConnected) {
      return await remoteDataSource.loginCurrentUser();
    } else {
      return const Left(
          ServerFailure(message: Strings.NO_NETWORK_ERROR_MESSAGE));
    }
  }

  @override
  Future<Either<Failure, UserCredential>> loginWithEmailAndPasswordEvent(
      {required String email, required String password}) async {
    if (await networkInfo.isConnected) {
      return await remoteDataSource.loginWithEmailAndPassword(
          email: email, password: password);
    } else {
      return const Left(
          ServerFailure(message: Strings.NO_NETWORK_ERROR_MESSAGE));
    }
  }
}
